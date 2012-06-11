module Scurge

	class Token


	end


	class Document



	end


	def parse_text_to
	end

	#####################################################################
	# Function analyzes the sentiment of a tweet. Very basic. This just
	# imports a list of words with sentiment scores from file and uses
	# these to perform the analysis.
	#
	# tweet: string -- string to analyze the sentiment of
	# return: int -- 0 negative, 1 means neutral, and 2 means positive
	#####################################################################
	def analyze_sentiment ( text )
	  
	  # load the word file (words -> sentiment score)
	  sentihash = load_senti_file ('sentiwords.txt')

	  # load the symbol file (smiles and ascii symbols -> sentiment score)  
	  sentihash.merge!(load_senti_file ('sentislang.txt'))
	  
	  # tokenize the text
	  tokens = text.split

	  # Check the sentiment value of each token against the sentihash.
	  # Since each word has a positive or negative numeric sentiment value
	  # we can just sum the values of all the sentimental words. If it is
	  # positive then we say the tweet is positive. If it is negative we 
	  # say the tweet is negative.
	  sentiment_total = 0.0

	  for token in tokens do

	    sentiment_value = sentihash[token]

	    if sentiment_value

	      # for debugging purposes
	      #puts "#{token} => #{sentiment_value}"

	      sentiment_total += sentiment_value

	    end
	  end
	  
	  # threshold for classification
	  threshold = 0.0

	  # if less then the negative threshold classify negative
	  if sentiment_total < (-1 * threshold)
	    return 0
	  # if greater then the positive threshold classify positive
	  elsif sentiment_total > threshold
	    return 2
	  # otherwise classify as neutral
	  else
	    return 1
	  end
	end
end