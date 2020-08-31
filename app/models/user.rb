class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validate :password_complexity

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true, numericality: true, format: {with: /\d[0-9]\)*\z/, message: "only allows numbers" }
  
  def password_complexity
  #   # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
  #   return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{7,}$/

  #   errors.add :password, 'Complexity requirement not met. Length should be atleast 7 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
	  rules = {
	    " must contain at least one lowercase letter"  => /[a-z]+/,
	    " must contain at least one uppercase letter"  => /[A-Z]+/,
	    " must contain at least one digit"             => /\d+/,
	    " must contain at least one special character" => /[^A-Za-z0-9]+/,
	    " Length must be of atleast 7 characters" => /.{7,}$/

	  }

	  rules.each do |message, regex|
	    errors.add( :password, message ) unless password.match( regex )
	  end
   end


end
