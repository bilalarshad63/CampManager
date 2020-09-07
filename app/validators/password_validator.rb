class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    rules = {
      ' must contain at least one lowercase letter' => /[a-z]+/,
      ' must contain at least one uppercase letter' => /[A-Z]+/,
      ' must contain at least one digit' => /\d+/,
      ' must contain at least one special character' => /[^A-Za-z0-9]+/,
      ' Length must be of atleast 7 characters' => /.{7,}$/
    }
    rules.each do |message, regex|
      record.errors.add(:password, message) unless value.match(regex)
    end
   end
end
