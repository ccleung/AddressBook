class AddContactToPhoneNumber < ActiveRecord::Migration
  def change
    add_reference :phone_numbers, :contact, index: true
  end
end
