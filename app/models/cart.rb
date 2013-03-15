class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
#  def add_product(product_id)
  def add_product(product)
    current_item = line_items.where(product_id: product.id).first
    if current_item
      current_item.quantity += 1
      current_item.price += product.price
    else
      current_item = LineItem.new(product_id: product.id, price: product.price)
      line_items << current_item
    end
    current_item
  end

  def total_price
    #line_items.to_a.sum{ |item| item.total_price }
    line_items.to_a.sum{ |item| item.price }
  end
end
