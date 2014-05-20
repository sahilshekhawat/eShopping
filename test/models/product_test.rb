require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end

  test "Product is not valid without a unique title - i18n" do
 	product = Product.new(title: products(:ruby).title,
 						  description: "xxx",
 						  price: 1,
 						  image_url: "fred.gif")
 	assert product.invalid?
 	assert_equal [I18n.translate('errors.messages.taken')],
 	             ["has already been taken"], product.errors[:title]
  end 	

  test "product attribute must not be empty" do
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: "two states",
  						description: "favourite",
  						image_url: "states.jpg")
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"]
  		product.errors[:price]

  	product.price = 1
  	assert product.invalid?
  end

  def new_product(image_url)
  	Product.new(title: "two states",
  				description: "favourite book",
  				proce: 1,
  				image_url: image_url)
  end
  test "image_url" do
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
  			http://a.b.c/x/y/z/fred.git }
  	bad = %w{ fred.doc fred.gitignore fred.git.more }
  	ok.each.do |name|
  		assert new_production(name).valid?, "#{name} should be valid"
  	end
  	bad.each.do |name|
  		assert new_product(name).invalid?, "#{name} shoudn't be valid"
  	end
  end		
end
