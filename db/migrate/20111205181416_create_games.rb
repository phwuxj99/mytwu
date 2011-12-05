class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :fname
      t.integer :playerid
      t.integer :playerrank
      t.references :post

      t.timestamps
    end
    add_index :games, :post_id
  end
end
