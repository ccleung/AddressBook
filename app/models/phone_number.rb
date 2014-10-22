class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
  # allow empty phone number
    if !Phony.plausible?(record.number)
      record.errors[:base] << "Number is invalid " + record.number + " Please ensure you have country code and area code filled in"
    end

    if !PhoneNumber.valid_phone_types.include?(record.phone_type)
      record.errors[:base] << "Phone type is invalid " + record.phone_type
    end
  end
end

class PhoneNumber < ActiveRecord::Base
	belongs_to :contact
	validates_with PhoneNumberValidator

	def self.valid_phone_types
		["other", "mobile", "home", "work"]
	end
end
