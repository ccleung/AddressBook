class AddContactToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :contact, index: true
  end
end
