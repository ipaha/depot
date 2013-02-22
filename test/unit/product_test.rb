require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "product attributes must not b empty" do
    product = 	Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price is negative" do
    product = 	Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
  end

  test "product price is zero" do
    product = 	Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
  end

  test "product price is positive" do
    product = 	Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")
    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
  	Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fed.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/y/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |t|
      assert new_product(t).valid?, "#{t} shouldn't be invalid"
    end
    bad.each do |t|
      assert new_product(t).invalid?, "#{t} shouldn't be valid"
    end
  end

end
