# frozen_string_literal: true

require_relative '../lib/basket'
require 'pry'

RSpec.describe Basket do
  let(:products) {
    [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
  }

  let(:delivery_rule) { DeliveryRule.new(rules: [
    { threshold: 50.0, cost: 2.95 },
    { threshold: 90.0, cost: 0.0 },
    { threshold: 0.0, cost: 4.95 }
  ])}

  let(:offers) { [BuyOneGetNextHalfOffer.new(code: 'R01')] }
  let(:basket) { Basket.new(products: products, delivery_rule: delivery_rule, offers: offers) }

  describe '#add' do
    it 'adds valid products to the basket' do
      expect { basket.add('R01') }.not_to raise_error
    end

    it 'raises error for invalid product code' do
      expect { basket.add('INVALID') }.to raise_error(ArgumentError)
    end
  end

  describe '#total' do
    context 'with example test cases' do
      it 'calculates total for B01, G01' do
        basket.add('B01')
        basket.add('G01')
        expect(basket.total).to eq(37.85)
      end

      it 'calculates total for R01, R01 with offer' do
        basket.add('R01')
        basket.add('R01')
        expect(basket.total).to eq(54.37)
      end

      it 'calculates total for R01, G01' do
        basket.add('R01')
        basket.add('G01')
        expect(basket.total).to eq(60.85)
      end

      it 'calculates total for B01, B01, R01, R01, R01' do
        basket.add('B01')
        basket.add('B01')
        basket.add('R01')
        basket.add('R01')
        basket.add('R01')
        expect(basket.total).to eq(98.27)
      end
    end

    context 'with delivery charges' do
      it 'applies $4.95 delivery charge for orders under $50' do
        basket.add('B01')
        expect(basket.total).to eq(12.90)
      end

      it 'applies $2.95 delivery charge for orders under $90' do
        basket.add('R01')
        basket.add('G01')
        expect(basket.total).to eq(60.85)
      end

      it 'applies free delivery for orders $90 or more' do
        basket.add('R01')
        basket.add('R01')
        basket.add('G01')
        expect(basket.total).to eq(77.32)
      end
    end

    context 'with special offers' do
      it 'applies half price discount on second red widget' do
        basket.add('R01')
        basket.add('R01')
        expect(basket.total).to eq(54.37)
      end

      it 'applies offer multiple times for multiple pairs' do
        basket.add('R01')
        basket.add('R01')
        basket.add('R01')
        basket.add('R01')
        expect(basket.total).to eq(98.85)
      end
    end
  end
end 
