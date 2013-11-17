WordACross
==========

Whats this?

I had an idea for an Android word game called Word A Cross. It's quite simple - you are presented with a word grid
and you must swipe with your finger to chain words together. When you release, the word is automatically detected from
a dictionary and converted into points and more word blocks fall from above.

Will it work anymore? I don't know because I gave my last Android phone to our corporate tester and the Android
emulator is too painful to load. 

I built it off the old Android Cocoas2D Open GL gaming library and then wrapped that with my own custom
model view controller framework. I used a modified MVC framework concept I had seen used in a large Flex 4
app I was working on to wire the views (activities), controllers and models in an eventful manner. 

SQLite was way too slow and heavy for the dictionary, had to serialize it into a flat file. 
