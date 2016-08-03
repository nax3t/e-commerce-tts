require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get add_to_cart" do
    get cart_add_to_cart_url
    assert_response :success
  end

  test "should get view_order" do
    get cart_view_order_url
    assert_response :success
  end

  test "should get _checkout" do
    get cart__checkout_url
    assert_response :success
  end

end
