class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :user
      t.integer :follow

      t.timestamps
    end
  end
end
