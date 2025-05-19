# frozen_string_literal: true

module Offer
  attr_reader :code

  def calculate_discount
    raise NotImplementedError, "#{self.class} has not implemented method calculate_discount method"
  end
end
