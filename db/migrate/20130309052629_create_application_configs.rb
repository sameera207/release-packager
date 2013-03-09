class CreateApplicationConfigs < ActiveRecord::Migration
  def change
    create_table :application_configs do |t|
      t.string :name
      t.string :git_repo_path
      t.string :package_path
      t.string :package_type

      t.timestamps
    end
  end
end
