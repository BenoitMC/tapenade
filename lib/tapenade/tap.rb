module Tapenade
  module Tap
    def tap
      return super if block_given?
      Tapenade::Delegator.new(self)
    end
  end
end
