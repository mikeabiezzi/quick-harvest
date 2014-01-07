class UserSetting < ActiveRecord::Base
  if Rails.env.production? && ENV["ENCRYPTION_KEY"].blank?
    raise "ENCRYPTION_KEY environment variable must be set in production"
  end
  ENCRYPTION_KEY = ENV["ENCRYPTION_KEY"] || "develpoment"

  belongs_to :user

  has_many :project_mappings, dependent: :destroy
  accepts_nested_attributes_for :project_mappings

  attr_encrypted :tracker_full_name, :tracker_api_token,
    :harvest_organization, :harvest_username, :harvest_password,
    :key => ENCRYPTION_KEY
end
