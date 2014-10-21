class Contact < ActiveRecord::Base
	belongs_to :user
	has_many :phone_numbers
	has_many :addresses
	accepts_nested_attributes_for :phone_numbers, :allow_destroy => true
	accepts_nested_attributes_for :addresses, :allow_destroy => true
	validates_presence_of :first_name
end
