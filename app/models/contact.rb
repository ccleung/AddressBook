class Contact < ActiveRecord::Base
	belongs_to :user
	has_many :phone_numbers
	validates_presence_of :first_name
end
