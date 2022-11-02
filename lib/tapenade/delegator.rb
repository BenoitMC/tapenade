require "delegate"

module Tapenade
  class Delegator < SimpleDelegator
    def method_missing(...)
      super
      __getobj__
    end
  end
end
