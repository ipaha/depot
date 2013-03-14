class StoreController < ApplicationController
  def index
    @products = Product.all
    @counter = current_counter
  end

  def pluralizeme
    
  end

end
