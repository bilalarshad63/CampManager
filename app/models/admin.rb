class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  attr_accessor :skip_password_validation

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :phone_number

  validates :password, presence: true, unless: :skip_password_validation
  validates :password, confirmation: { case_sensitive: true }

  private
  def password_required?
    return false if skip_password_validation
    super
  end
end
