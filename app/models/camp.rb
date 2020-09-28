class Camp < ApplicationRecord
  has_many :camp_applications, dependent: :destroy
  has_many :users, through: :camp_applications
  has_and_belongs_to_many :camp_locations
  after_initialize :init

  validates :camp_type, inclusion: { in: %w[virtual real] }
  validates :camp_title, presence: true
  validates :applicant_registration_start_date, presence: true
  validates :applicant_registration_end_date, presence: true
  validates :applicant_registration_start_time, presence: true
  validates :applicant_registration_end_time, presence: true
  validates :parent_application_start_date, presence: true
  validates :parent_application_end_date, presence: true
  validates :parent_application_start_time, presence: true
  validates :parent_application_end_time, presence: true
  validate :validate_time_date

  

  def self.search(search)
    if search
      where('camp_title LIKE ? OR camp_type LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  private

  def init
    self.camp_status ||= :inactive # will set the default camp status to Inactive
  end

  def validate_time_date
    unless applicant_registration_start_date.nil? && applicant_registration_end_date.nil? && parent_application_start_date.nil? && parent_application_end_date.nil?
      if applicant_registration_start_date > applicant_registration_end_date || parent_application_start_date > parent_application_end_date
        errors.add(:end_date, 'must be after the start date')
      end
    end
  end
end
