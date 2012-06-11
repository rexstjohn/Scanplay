module Scurge

	#####################################################################
	# Generate a hash of tokens from an incoming text file
	#####################################################################
	def tokenize (document)

	  token_hash = {}

	  # load the file
	  document = File.new(filename)

	  while (line = document.gets)

	  	#pull out a text line
	    parsedline = line.chomp.split("\t")
	    sentiscore = parsedline[0]
	    text = parsedline[1]
	    sentihash[text] = sentiscore.to_f
	  end

	  document.close

	  return token_hash
	end
end