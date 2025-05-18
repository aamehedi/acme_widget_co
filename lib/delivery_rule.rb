# frozen_string_literal: true

class DeliveryRule
  def initialize(rules:)
    @rules = rules.sort_by { |rule| -rule[:threshold] }
  end

  def calculate(subtotal)
    @rules.each do |rule|
      return rule[:cost] if subtotal >= rule[:threshold]
    end

    @rules.last&.[](:cost) || 0.0
  end
end 
