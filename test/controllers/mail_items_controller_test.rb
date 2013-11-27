require 'test_helper'

class MailItemsControllerTest < ActionController::TestCase
  setup do
    @mail_item = mail_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_item" do
    assert_difference('MailItem.count') do
      post :create, mail_item: { body: @mail_item.body, date: @mail_item.date, from: @mail_item.from, is_read: @mail_item.is_read, item_id: @mail_item.item_id, name: @mail_item.name, sender: @mail_item.sender, subject: @mail_item.subject, watermark: @mail_item.watermark }
    end

    assert_redirected_to mail_item_path(assigns(:mail_item))
  end

  test "should show mail_item" do
    get :show, id: @mail_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_item
    assert_response :success
  end

  test "should update mail_item" do
    patch :update, id: @mail_item, mail_item: { body: @mail_item.body, date: @mail_item.date, from: @mail_item.from, is_read: @mail_item.is_read, item_id: @mail_item.item_id, name: @mail_item.name, sender: @mail_item.sender, subject: @mail_item.subject, watermark: @mail_item.watermark }
    assert_redirected_to mail_item_path(assigns(:mail_item))
  end

  test "should destroy mail_item" do
    assert_difference('MailItem.count', -1) do
      delete :destroy, id: @mail_item
    end

    assert_redirected_to mail_items_path
  end
end
