class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.string :fname
      t.integer :teamgoals
      t.integer :goals
      t.integer :assists
      t.integer :ranks
      t.boolean :flags
      t.references :post

      t.timestamps
    end
    add_index :rosters, :post_id
  end
end
