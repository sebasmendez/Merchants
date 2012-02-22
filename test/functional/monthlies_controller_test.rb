require 'test_helper'

class MonthliesControllerTest < ActionController::TestCase
  setup do
    @monthly = monthlies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monthlies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monthly" do
    assert_difference('Monthly.count') do
      post :create, :monthly => @monthly.attributes
    end

    assert_redirected_to monthly_path(assigns(:monthly))
  end

  test "should show monthly" do
    get :show, :id => @monthly.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @monthly.to_param
    assert_response :success
  end

  test "should update monthly" do
    put :update, :id => @monthly.to_param, :monthly => @monthly.attributes
    assert_redirected_to monthly_path(assigns(:monthly))
  end

  test "should destroy monthly" do
    assert_difference('Monthly.count', -1) do
      delete :destroy, :id => @monthly.to_param
    end

    assert_redirected_to monthlies_path
  end
end
