# frozen_string_literal: true
require_relative 'offer'

class BuyOneGetNextHalfOffer
  include Offer

  def initialize(code:)
    @code = code
  end

  def calculate_discount(cart_item)
    return 0 unless cart_item.product.code == @code

    pairs_count = cart_item.quantity / 2
    return pairs_count * (cart_item.product.price / 2) if pairs_count.positive?

    0
  end
end
