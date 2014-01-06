class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.references :user, null: false

      t.string :tracker_full_name, null: false
      t.string :tracker_api_token, null: false

      t.string :harvest_organization, null: false
      t.string :harvest_username,     null: false
      t.string :harvest_password,     null: false

      t.string :output,             null: false, default: "multi_line"
      t.string :style,              null: false, default: "story_number"
      t.boolean :comma_deliminated, null: false, default: false

      t.timestamps
    end
  end
end
