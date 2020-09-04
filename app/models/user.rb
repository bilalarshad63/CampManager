class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  validates :password, presence: true, :on => :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true, numericality: true, format: {with: /\d[0-9]\)*\z/, message: "only allows numbers" }, length: { in: 7..15 }
end
