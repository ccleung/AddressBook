require 'test_helper'

class ContactTest < ActiveSupport::TestCase
   test "first name and last name should save" do
     @contact = Contact.new
     @contact.first_name = "John"
     @contact.last_name = "Smith"
     assert @contact.save
   end
   test "missing first name only should not save" do
     @contact = Contact.new
     @contact.last_name = "m"
     assert_not @contact.save
   end
   test "missing last name only should save" do
     @contact = Contact.new
     @contact.first_name = "m"
     assert @contact.save
   end
end
