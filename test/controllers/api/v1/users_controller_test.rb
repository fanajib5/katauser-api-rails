require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test "should get index as admin" do
    sign_in @admin
    get "/api/v1/users"
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("users")
    assert json_response.key?("meta")
  end

  test "should not get index as regular user" do
    sign_in @user
    get "/api/v1/users"
    assert_response :forbidden
  end

  test "should show user profile" do
    sign_in @user
    get "/api/v1/users/#{@user.id}"
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @user.email, json_response["user"]["email"]
  end

  test "should update own profile" do
    sign_in @user
    patch "/api/v1/users/#{@user.id}", params: {
      user: { first_name: "Updated" }
    }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal "Updated", json_response["user"]["first_name"]
  end
end
