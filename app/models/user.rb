class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :password, password: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true, format: { with: /(?:\+?\d{1,3}[- ]?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{2}[- ]?\d{2}/, message: 'only allows numbers' }, length: { in: 7..25 }
end
