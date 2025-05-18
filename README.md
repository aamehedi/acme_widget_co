# Acme Widget Co. - Proof of Concept

This project implements a proof of concept for a sales system's basket functionality for Acme Widget Co., as per the provided coding assignment.

## Features

* **Product Catalog**: Manages a list of products with codes, names, and prices.
* **Shopping Basket**:
    * Allows adding products to the basket.
    * Calculates the total cost, incorporating special offers and delivery charges.
* **Delivery Charge Rules**: Applies delivery costs based on the order subtotal after discounts.
    * Orders under \$50: \$4.95 delivery.
    * Orders between \$50 (inclusive) and \$90 (exclusive): \$2.95 delivery.
    * Orders \$90 or more: Free delivery.
* **Special Offers**: Implements a "buy one red widget (R01), get the next half price" offer. The system is designed to be extensible for more offer types using a Strategy pattern.

## Code Structure

The system is built with Ruby and is structured into several classes to ensure good separation of concerns:

* `Product`: Represents a product with `code`, `name`, and `price` attributes.
* `Offer` module (and its implementation like `BuyOneRedGetNextHalfOffer`): Defines the interface for special offers and implements specific offer logic. This allows for easy addition of new offer types.
* `DeliverRule`: Calculates delivery costs based on a set of configurable rules and the subtotal of the basket (after offers are applied).
* `CartItem`: Represents the products that are being added for a customer in their cart, including quantity. 
  * `add_quantity` method allows to add the quantity of the product instead of adding multiple instances of same product in the cart.
  * `discount` method checks for the offers that are applicable for this product type and ask them to calculate discount passing the quantity to the implementation class of the `Offer` module.
  * `total_price` method calculates the subtotal for this particular product and deduct the discount.
* `Basket`: The main class that orchestrates the functionality.
    * It is initialized with the array of instances of the `Product` class, a `DeliverRule` instance, and an array of offer strategy instances (Dependency Injection).
    * The `add(product_code)` method adds a product to the basket.
    * The `total` method calculates the final amount payable.

## Assumptions Made

* **Product Catalog Format**: Assumed to be an array of `Product` instances.
* **Delivery Rules Format**: Assumed to be an array of hashes, each with a `:threshold` (Float) and `:cost` (Float), sorted internally by threshold.
* **Offer Application**: Offers are applied to the initial list of items. Discounts are calculated based on the base prices of products. Also currently maximum of one offer startegy per one type(/code) of product can be implemented. No generic offer is possible for all type of products.
* **Flooring**: The final total is floored to two decimal places using standard Ruby `floor(2)`.
* **Input Validity**: The current implementation assumes valid product codes are passed to the `add` method. Basic error handling (invalid product code) is implemented.
