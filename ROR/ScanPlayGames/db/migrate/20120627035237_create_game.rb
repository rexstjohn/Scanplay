class CreateGame < ActiveRecord::Migration
  def up
  	create_table :games do |t|
  		#special keys
		t.boolean :coins_enabled
		t.integer :width
		t.integer :height
		t.float   :metascore
		t.boolean :coins_revshare_enabled
		t.boolean :leaderboard_enabled
		t.boolean :achievements_enabled
		t.datetime :feed_approval_created
		t.integer :swf_file_size
		t.datetime :created

		#datetime's

		#strings
		t.string :screen2_thumb
		t.string :popularity
		t.string :alternate_url
		t.string :video_url
		t.string :rating
		t.string :screen1_thumb
		t.string :screen3_url
		t.string :recommendation
		t.string :category
		t.string :screen4_thumb
		t.string :uuid
		t.string :author
		t.string :thumbnail_large_url
		t.string :swf_url
		t.string :recommended
		t.string :game_tag
		t.string :zip_url
		t.string :screen1_url
		t.string :updated
		t.string :description
		t.string :author_link
		t.string :game_url
		t.string :screen2_url
		t.string :slug
		t.string :instructions
		t.string :name
		t.string :screen3_thumb
		t.string :thumbnail_url
		t.string :screen4_url
		t.string :resolution
		t.timestamps

		#dont give a shit about...
		#t.string :control_scheme # takes a hash
		#t.string :key_mappings
		#t.string :tags
		#t.string :controls
		#t.string :languages
		#t.string :categories
		end
  end

  def down
  	drop_table(:games)
  end
end
