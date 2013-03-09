class AddFileNameToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :package_path, :string
  end
end
