class CampApplication < ApplicationRecord
  belongs_to :user
  belongs_to :camp
  attr_accessor :current_step
  attr_accessor :percentage

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[education personal_info camp_preference social_media technology_requirements]
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def calculate_percentage
    percentage = 0
    percentage += 1 if self.education.present?
    percentage += 1 if self.camp_preferences.present?
    percentage += 1 if self.social_media.present?
    @user=User.find(self.user_id)
    percentage += 1 if @user.gender.present? && @user.date_of_birth.present?
    percentage += 1 if self.technology_requirements.present?
    percentage
  end
end
