class AddPairToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :encrypted_tracker_pair_full_name, :string
  end
end
