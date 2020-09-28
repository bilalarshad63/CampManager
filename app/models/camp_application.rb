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
    percentage += 20 if self.education_check?
    percentage += 20 if self.camp_preferences_check?
    percentage += 20 if self.social_media_check?
    percentage += 20 if self.personal_info_check?
    percentage += 20 if self.tech_requirements_check?
    percentage
  end
end
