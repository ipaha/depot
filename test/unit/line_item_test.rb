require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'line item price less than 1000' do
    line_itme = LineItem.new(price: 1001)
    assert line_itme.invalid?
  end
end
