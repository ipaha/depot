class CombinePricesInCart < ActiveRecord::Migration
  def up
    LineItem.all.each do |line_item|
      line_item.update_attributes price: line_item.product.price * line_item.quantity
    end

  end

  def down
  end
end
