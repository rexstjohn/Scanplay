class Game < ActiveRecord::Base

	def self.fields
				["coins_enabled",
				"width",
				"height",
				"metascore",
				"coins_revshare_enabled",
				"leaderboard_enabled",
				"achievements_enabled",
				"feed_approval_created",
				"swf_file_size",
				"created",
				"screen2_thumb",
				"popularity",
				"alternate_url",
				"video_url",
				"rating",
				"screen1_thumb",
				"screen3_url",
				"recommendation",
				"category",
				"screen4_thumb",
				"uuid",
				"author",
				"thumbnail_large_url",
				"swf_url",
				"recommended",
				"game_tag",
				"zip_url",
				"screen1_url",
				"updated",
				"description",
				"author_link",
				"game_url",
				"screen2_url",
				"slug",
				"instructions",
				"name",
				"screen3_thumb",
				"thumbnail_url",
				"screen4_url",
				"resolution"]
	end

	def self.create(options)

		#remove any hash elements which are not elements of the schema
		options.delete_if {|key, value| !self.fields.include?(key)}

		super(options)
	end

end
