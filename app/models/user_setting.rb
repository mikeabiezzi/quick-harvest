class UserSetting < ActiveRecord::Base
  belongs_to :user

  has_many :project_mappings
  accepts_nested_attributes_for :project_mappings
end
