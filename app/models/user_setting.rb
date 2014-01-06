class UserSetting < ActiveRecord::Base
  belongs_to :user

  has_many :project_mappings
end
