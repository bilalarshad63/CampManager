class CampApplication < ApplicationRecord
  belongs_to :user
  belongs_to :camp
  attr_accessor :current_step

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
end
