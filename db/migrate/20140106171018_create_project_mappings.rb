class CreateProjectMappings < ActiveRecord::Migration
  def change
    create_table :project_mappings do |t|
      t.references :user_setting, null: false

      t.string :external_project_id, null: false

      t.string :harvest_project_id, null: false
      t.string :harvest_task_id,    null: false

      t.timestamps
    end
  end
end
