class CampLocation < ApplicationRecord
  def self.search(search)
    if search
      where('name LIKE ? OR id LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def self.to_csv
    attributes = %w[name]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |camp_location|
        csv << attributes.map { |attr| camp_location.send(attr) }
      end
    end
  end
end
