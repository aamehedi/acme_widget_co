# frozen_string_literal: true

module Offer
  attr_reader :code

  def apply
    raise NotImplementedError, "#{self.class} has not implemented method apply method"
  end
end
