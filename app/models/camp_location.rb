class CampLocation < ApplicationRecord
	def self.search(search)
    if search
      where('name LIKE ? OR id LIKE ?', "%#{search}%", "%#{search}%")
    else
      CampLocation.page(params[:page])
    end
  end
end