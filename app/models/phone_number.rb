class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
  # allow empty phone number
    if !Phony.plausible?(record.number)
      record.errors[:base] << "Number is invalid " + record.number + " Please ensure you have country code and area code filled in"
    end
  end
end

class PhoneNumber < ActiveRecord::Base
	belongs_to :contact
	validates_with PhoneNumberValidator
end
