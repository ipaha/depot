class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
    @counter = current_counter
  end
end
