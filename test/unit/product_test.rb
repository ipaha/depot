require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do
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

  test "product title length is less than 10" do
    product = 	Product.new(title: "aaa", description: "yyy", image_url: "zzz.jpg")
    assert product.invalid?
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

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fried.gif")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fried.gif")
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('; ')
  end

  test "product title has message when title length is less than 10" do
    product = Product.new(title: 'aaa', description: "yyy", price: 1, image_url: "fried.gif")
    assert !product.save
    assert_equal "must be at least ten characters long", product.errors[:title].join('; ')
  end

end
