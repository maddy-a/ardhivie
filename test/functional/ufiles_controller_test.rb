require 'test_helper'

class UfilesControllerTest < ActionController::TestCase
  setup do
    @ufile = ufiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ufiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ufile" do
    assert_difference('Ufile.count') do
      post :create, ufile: { name: @ufile.name }
    end

    assert_redirected_to ufile_path(assigns(:ufile))
  end

  test "should show ufile" do
    get :show, id: @ufile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ufile
    assert_response :success
  end

  test "should update ufile" do
    put :update, id: @ufile, ufile: { name: @ufile.name }
    assert_redirected_to ufile_path(assigns(:ufile))
  end

  test "should destroy ufile" do
    assert_difference('Ufile.count', -1) do
      delete :destroy, id: @ufile
    end

    assert_redirected_to ufiles_path
  end
end
