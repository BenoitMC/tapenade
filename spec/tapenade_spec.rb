class Hello
  def messages
    @messages ||= []
  end

  def hello(arg1)
    messages << "hello #{arg1} #{yield}"
  end

  def respond_to_missing?(method, include_private = false)
    method == :yo || super
  end

  def method_missing(method, *args)
    return super unless method == :yo
    messages << "yo #{args.first} #{yield}"
  end
end

describe Tapenade do
  let(:instance) { Hello.new }

  it "has a version number" do
    expect(Tapenade::VERSION).not_to be nil
  end

  describe "#method_missing" do
    it "should call method and return self" do
      result = instance.tap_hello("arg1") { "block" }
      expect(result).to eq instance
      expect(instance.messages).to eq ["hello arg1 block"]
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
      expect(instance.messages).to eq ["yo arg1 block"]
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
