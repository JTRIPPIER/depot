require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "Price must be positive" do

    product = products(:valid_book)

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url must have a valid extension" do
    product = products(:valid_book)

    acceptable = %w{file.png fred.jpg feed.JPG fight.2.gif fly.GiF}
    bad = %w{file.pngg fred.txt feed.html fight.jpeg fly.ffGIFff}

    acceptable.each do |name|
      product.image_url = name
      assert product.valid?, "#{name} should be valid"
    end

    bad.each do |name|
      product.image_url = name
      assert product.invalid?, "#{name} should be invalid"
    end
  end

  test "title attribute must be unique" do
    product = Product.new(title: products(:valid_book).title,
                           description:"A duplicate book",
                           price: 9.95,
                           image_url: "bookbook.png")

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]

  end

  test "title attribute must be unique - i18n" do
    product = Product.new(title: products(:valid_book).title,
                           description:"A duplicate book",
                           price: 9.95,
                           image_url: "bookbook.png")

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]

  end

  test "title must be more than 10 letters - i18n" do
    product = Product.new(title: "Short",
                           description:"A Full Description",
                           price: 9.95,
                           image_url: "bookbook.png")

    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]

  end

  test "description must be more than 10 letters - i18n" do
    product = Product.new(title: "Another Long Title",
                           description:"Short",
                           price: 9.95,
                           image_url: "bookbook.png")

    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:description]

  end

end
