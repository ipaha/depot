require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test 'cart unique products' do
  	product1 = products(:one)
  	product2 = products(:ruby)
  	cart = Cart.new
  	cart.save
  	cart.add_product(product1).save
  	cart.add_product(product2).save
  	assert_equal 2, cart.line_items.count
  	assert_equal product1.price + product2.price, cart.total_price
  end

  test 'cart duplicate products' do
  	product1 = products(:ruby)
  	cart = Cart.new
  	cart.save
  	cart.add_product(product1).save
  	cart.add_product(product1).save
  	assert_equal 1, cart.line_items.count
  	assert_equal product1.price * 2, cart.total_price
  end

end
