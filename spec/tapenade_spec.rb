class Hello
  def messages
    @messages ||= []
  end

  def hello(arg1, kwarg1:)
    messages << "hello #{arg1} #{kwarg1} #{yield}"
  end

  def hello_no_args
    messages << "hello_no_args"
  end

  private def hello_private
  end

  def respond_to_missing?(method, include_private = false)
    method == :yo || super
  end

  def method_missing(method, *args, **kwargs)
    return super unless method == :yo
    messages << "yo #{args.first} #{kwargs} #{yield}"
  end
end

describe Tapenade do
  let(:instance) { Hello.new }

  it "has a version number" do
    expect(Tapenade::VERSION).not_to be nil
  end

  describe "#method_missing" do
    it "should call method and return self" do
      result = instance.tap_hello("arg1", kwarg1: "kw") { "block" }
      expect(result).to eq instance
      expect(instance.messages).to eq ["hello arg1 kw block"]
    end

    it "should call method without args" do
      result = instance.tap_hello_no_args
      expect(result).to eq instance
      expect(instance.messages).to eq ["hello_no_args"]
    end

    it "should not allow private methods" do
      expect {
        instance.tap_hello_private
      }.to raise_error(NoMethodError)
    end

    it "should raise on tap undefined method" do
      expect { instance.tap_abc }.to raise_error(NoMethodError, /undefined method `tap_abc' for/)
    end

    it "should raise on undefined method" do
      expect { instance.abc }.to raise_error(NoMethodError, /undefined method `abc' for/)
    end

    it "should call parent missing method" do
      result = instance.tap_yo("arg1") { "block" }
      expect(result).to eq instance
      expect(instance.messages).to eq ["yo arg1 {} block"]
    end
  end # describe "method_missing"

  describe "#respond_to_missing?" do
    it "should be true on tap valid method" do
      expect(instance.send :respond_to_missing?, :tap_hello).to eq true
    end

    it "should be false on tap undefined method" do
      expect(instance.send :respond_to_missing?, :tap_abc).to eq false
    end

    it "should be false on undefined method" do
      expect(instance.send :respond_to_missing?, :abc).to eq false
    end

    it "should be true on parent missing method" do
      expect(instance.send :respond_to_missing?, :yo).to eq true
      expect(instance.send :respond_to_missing?, :tap_yo).to eq true
    end
  end # describe "respond_to_missing?"
end
