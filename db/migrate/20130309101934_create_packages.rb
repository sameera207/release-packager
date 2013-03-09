class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.text :commit_id
      t.string :name

      t.timestamps
    end
  end
end
