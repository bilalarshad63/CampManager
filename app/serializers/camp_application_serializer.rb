class CampApplicationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :camp_id, :education, :social_media
end
