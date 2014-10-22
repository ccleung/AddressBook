require 'test_helper'

class PhoneNumberTest < ActiveSupport::TestCase
  test "Valid phone number structure and phone type" do
     @phone = PhoneNumber.new
     @phone.number = '+1-333-333-3333'
     @phone.phone_type = "mobile"
     assert @phone.save
  end

  test "Invalid number structure missing country code should not save" do
  	@phone = PhoneNumber.new
    @phone.number = '333-333-3333'
    @phone.phone_type = "mobile"
    assert_not @phone.save
  end

  test "Invalid number structure should not save" do
  	@phone = PhoneNumber.new
    @phone.number = 'hello'
    @phone.phone_type = "mobile"
    assert_not @phone.save
  end

  test "mobile phone type should save" do
  	@phone = PhoneNumber.new
    @phone.number = '+1-333-333-3333'
    @phone.phone_type = "mobile"
    assert @phone.save
  end

  test "home phone type should save" do
  	@phone = PhoneNumber.new
    @phone.number = '+1-333-333-3333'
    @phone.phone_type = "home"
    assert @phone.save
  end

  test "work phone type should save" do
  	@phone = PhoneNumber.new
    @phone.number = '+1-333-333-3333'
    @phone.phone_type = "work"
    assert @phone.save
  end

  test "other phone type should save" do
  	@phone = PhoneNumber.new
    @phone.number = '+1-333-333-3333'
    @phone.phone_type = "other"
    assert @phone.save
  end

  test "invalid phone type should not save" do
  	@phone = PhoneNumber.new
    @phone.number = '+1-333-333-3333'
    @phone.phone_type = "jibberish"
    assert_not @phone.save
  end

end
