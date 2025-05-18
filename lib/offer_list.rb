# frozen_string_literal: true

class OfferList
  def initialize(offers)
    @offers = Hash[offers.map { |offer| [offer.code, offer] }]
  end

  def find(code)
    @offers[code]
  end
end
