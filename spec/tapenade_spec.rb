class Hello
  def messages
    @messages ||= []
  end

  def hello(arg1, kwarg1:)
    messages << "hello #{arg1} #{kwarg1} #{yield}"
  end

  private

  def hello_private
  end
end

describe Tapenade do
  let(:instance) { Hello.new }

  it "has a version number" do
    expect(Tapenade::VERSION).not_to be nil
  end

  it "should call method and return self" do
    result = instance.tap.hello("arg1", kwarg1: "kw") { "block" }
    expect(result).to eq instance
    expect(instance.messages).to eq ["hello arg1 kw block"]
  end

  it "should not allow private methods" do
    expect {
      instance.tap.hello_private
    }.to raise_error(NoMethodError)
  end

  it "should raise on undefined method" do
    expect { instance.invalid }.to raise_error(NoMethodError, /undefined method `invalid' for/)
  end

  it "should not change original tap" do
    yielded = nil
    result = instance.tap { yielded = _1 }
    expect(result).to eq instance
    expect(yielded).to eq instance
  end
end
