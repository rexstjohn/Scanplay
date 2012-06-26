class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :zip_url
      t.string :rating
      t.string :uuid
      t.string :description
      t.string :game_url
      t.string :resolution
      t.integer :metascore

      t.timestamps
    end
  end
end
