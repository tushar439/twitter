class CreateFollowerMappings < ActiveRecord::Migration
  def change
    create_table :follower_mappings do |t|
      t.string :follower_id
      t.string :integer
      t.string :followee_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
