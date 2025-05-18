# frozen_string_literal: true

class CartItem
  attr_reader :product, :quantity

  def initialize(product:, quantity: 1, offer_list:)
    @product = product
    @quantity = quantity
    @offer_list = offer_list
  end

  def total_price
    @product.price * quantity - discount
  end

  def discount
    offer = @offer_list.find(@product.code)
    return 0 unless offer

    offer.calculate_discount(self)
  end

  def add_quantity
    @quantity += 1
  end
end
