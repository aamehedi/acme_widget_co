# frozen_string_literal: true

require_relative 'product'
require_relative 'product_catalog'
require_relative 'delivery_rule'
require_relative 'offer_list'
require_relative 'buy_one_get_next_half_offer'
require_relative 'cart_item'

class Basket
  def initialize(products:, delivery_rule:, offers:)
    @cart_items = {}
    @product_catalog = ProductCatalog.new(products)
    @delivery_rule = delivery_rule
    @offer_list = OfferList.new(offers)
  end

  def add(product_code)
    product = @product_catalog.find(product_code)
    raise ArgumentError, "Invalid product code: #{product_code}" unless product

    add_or_initialize_item(product)
  end

  def total
    subtotal = @cart_items.values.sum(&:total_price)
    delivery_charge = @delivery_rule.calculate(subtotal)
    
    (subtotal + delivery_charge).floor(2)
  end

  private
  def add_or_initialize_item(product)
    if @cart_items[product.code]
      @cart_items[product.code].add_quantity
    else
      @cart_items[product.code] = CartItem.new(product: product, offer_list: @offer_list)
    end
  end
end 
