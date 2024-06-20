# Flutter Gallery App

Flutter Gallery App is an app that you can use to search for images. All images you load will be cached so they can be displayed again later quicker.

# Features
- Search images
- Cache all loaded images

# Features to be developed
- (Un)bookmark images
- An overview of all bookmarked images
- (Maybe) an overview of all the cached images and a way to remove them from the cache


# Challenges and Solutions

One idea I had in mind was to make a page where you can see all the images that are cached and eventually remove them. That is not possible with the package I chose to use to cache the images. An idea to fix this problem would be to use a StateNotifier which has a list of the cached images (urls) with that list you can load in every image from the cache and display it. You can also use that same list to bookmark the images, so maybe I will implement that in the future.

Another idea I was thinking about was to cache the images myself without using a package, but I chose not to do that because I did not want to make a huge list of UInt8Lists with all of the other properties as well. Otherwise I would have done that the same way as the StateNotifier mentioned above.

Another possibility to 'cache' the images would have been to make a Firebase Storage and put the images in there but that's not really caching them as then they are still a network image.

Because I was thinking about that first idea for some time without using packages it took me a bit longer to make this application than I wanted it to take.