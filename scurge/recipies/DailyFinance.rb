require "Scurge"

url = "http://www.dailyfinance.com/2012/06/13/why-the-dow-dropped-late-today/"

#turn the url into a token string
#discards everything that is not content

#step 1: train the scurge to know what are good an bad tokens
Scurge.learn("good", good_documents)
Scurge.learn("bad", bad_documents)

#step 2: now that scurge is trained, have it classify the polarity of a document
rating = Scurge.classify(document)

#step 3: Have scrape a web page and extract a document
document = Scurge.scrap(url)

#build a mining worker using Scurge
list_of_urls = 
		{
			:cnn =>"cnn.com",
			:wall_street_journal => "wj.com",
			:google_finance => "finance.google.com"
		}
		
Scurge.mine(list_of_urls)