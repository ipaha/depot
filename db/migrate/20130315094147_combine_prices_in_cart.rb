class CombinePricesInCart < ActiveRecord::Migration
  def up
    Cart.all.each do |cart|
      cart.line_items.each do |line_item|
      	line_item.price = line_item.product.price * line_item.quantity
      	line_item.save
        #line_item.update_attributes line_item.attributes
        #line_item.update_attributes price: line_item.price
      end
    end

  end

  def down
  end
end
