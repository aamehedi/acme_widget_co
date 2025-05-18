# frozen_string_literal: true

class ProductCatalog
  def initialize(products)
    @products = Hash[products.map { |product| [product.code, product] }]
  end

  def find(code)
    @products[code]
  end
end
