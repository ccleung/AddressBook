require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "New user with just an email" do
   	 @user = User.new
   	 @user.email = "admin@example.com"
     assert_not @user.save
   end

   test "New user with password too short" do
   	 @user = User.new
   	 @user.email = "admin@example.com"
   	 @user.password = "123"
   	 @user.password_confirmation = "123"
     assert_not @user.save
   end

   test "New user with sufficient password" do
   	 @user = User.new
   	 @user.email = "admin@examplessss.com"
   	 @user.password = "12345678"
   	 @user.password_confirmation = "12345678"
     assert @user.save
   end

   test "New user without confirmation password matching" do
   	 @user = User.new
   	 @user.email = "admin@examplessss.com"
   	 @user.password = "12345678"
   	 @user.password_confirmation = "12345678a"
     assert_not @user.save
   end
end
