class User < ApplicationRecord
  has_many :camp_applications
  has_many :camps, through: :camp_applications
  attr_accessor :skip_password_validation

  before_validation :add_username_in_db
  has_one_attached :image
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :password, password: true, unless: :skip_password_validation

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  #validates :gender, inclusion: { in: %w(man women other) }
  validates :phone_number, presence: true, format: { with: /(?:\+?\d{1,3}[- ]?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{2}[- ]?\d{2}/, message: 'only allows numbers' }, length: { in: 7..25 }
  def country_name
    country = self.country
    ISO3166::Country[country]
  end

  def self.search(search)
    if search
      where('username LIKE ? OR email LIKE ? OR id LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def add_username_in_db
    self.username = "#{first_name} #{last_name}"
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
