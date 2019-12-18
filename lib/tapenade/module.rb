module Tapenade
  def self.prefix
    "tap_".freeze
  end

  private

  def respond_to_missing?(method, include_private = false)
    respond_to_tapenade?(method) || super
  end

  def method_missing(method, *args, **kwargs, &block)
    return super unless respond_to_tapenade?(method)
    public_send(method.to_s[Tapenade.prefix.length..-1], *args, **kwargs, &block)
    self
  end

  def respond_to_tapenade?(method)
    method.to_s.start_with?(Tapenade.prefix) && respond_to?(method.to_s[Tapenade.prefix.length..-1])
  end
end
