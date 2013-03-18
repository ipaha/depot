class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  validates :price, numericality: {less_than_or_equal_to: 1000}
end
