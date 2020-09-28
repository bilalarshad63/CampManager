class CampSerializer < ActiveModel::Serializer
  attributes :id, :camp_title, :camp_status, :camp_type
end
