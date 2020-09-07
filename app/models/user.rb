class User < ApplicationRecord
  filterrific(
    available_filters: %i[
      search_query
      sorted_by
    ]
  )
  scope :search_query, lambda { |query|
    return nil if query.blank?

    query = query.to_s
    terms = query.downcase.split(/\s+/)
    terms = terms.map do |e|
      (e.tr('*', '%') + '%').gsub(/%+/, '%')
    end
    num_or_conds = 3
    where(
      terms.map do |_term|
        '(LOWER(users.first_name) LIKE ? OR LOWER(users.last_name) LIKE ? OR LOWER(users.email) LIKE ?)'
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }
  scope :sorted_by, lambda { |sort_options|
    direction = sort_options =~ /desc$/ ? 'desc' : 'asc'
    case sort_options.to_s
    when /^email_/
      order("LOWER(users.email) #{direction}")
    when /^username_/
      order("LOWER(users.username) #{direction}")
    when /^country_/
      order("LOWER(users.country) #{direction}")
    when /^phone_number_/
      order("LOWER(users.phone_number) #{direction}")
    when /^id_/
      order("LOWER(users.id) #{direction}")
    else
      raise(ArgumentError, 'Invalid sort option')
    end
  }
  def self.options_for_sorted_by
    [
      ['email (AZ)', 'email_asc'],
      ['email (ZA)', 'email_desc'],
      %w[phone_number phone_number_asc],
      %w[phone_number phone_number_desc],
      %w[id id_asc],
      %w[id id_desc],
      ['username (AZ)', 'username_asc'],
      ['username (ZA)', 'username_desc'],
      ['country (ZA)', 'country_desc'],
      ['country (ZA)', 'country_desc']
    ]
  end

  before_validation :add_username_in_db
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :image

  def add_username_in_db
    self.username = "#{first_name} #{last_name}"
  end

  validates :password, presence: true, on: :create, unless: :skip_password_validation
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true, format: { with: /(?:\+?\d{1,3}[- ]?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{2}[- ]?\d{2}/, message: 'only allows numbers' }, length: { in: 7..25 }

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
