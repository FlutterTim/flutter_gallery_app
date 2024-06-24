# Flutter Gallery App

Flutter Gallery App is an app that you can use to search for images. All images you load will be cached so they can be displayed again later quicker.

![Flutter Gallery App](https://github.com/FlutterTim/flutter_gallery_app/blob/v1.0.0/gallery%20app.gif)

## Features
- Search images
- Cache all loaded images
- (Un)bookmark images
- An overview of all bookmarked images
- An overview of all the cached images and a way to remove them all or only one from the cache

## Current limitations/Future improvements
- Bookmarking/deleting/viewing the image on the search page is currently not possible, only on the other screens. I am still thinking about solutions for that.
- Adding unit tests for the imagenotifier which has the add/delete functionalities.
- Images are currently immediately cached, in the future it should be possible to select an image and then decide if you want to cache it or not.
- The code supports changes to how many images are loaded in when searching, but there is currently no UI to support that feature.
- In the future some filters can be added, the image API (Pexels) supports the image color and the orientation of the image.
- An improvement can be made to the `fetchImages` function as it currently requires a `searchTerm` but is unneccesary when you use an `url`. Also when you give it an URL that's not from Pexels the application will break, to fix that I will remove the `url` parameter in the future and strip the neccesary parameters from the url to use them seperately.
- The `Button` object does not really do anything special at this moment and will be more advanced in the future.

## 'API' reference
Seeing as this application does not really have an API I will specify the ImageNotifier here which has the add/remove features of the images.

You can call these functions by watching or reading the `imageProvidder.notifier`.

| Function Name | Return DataType | Parameters | Description |
| fetchImages | Future<SearchResult> | Required: String searchTerm \n Optional: int pageNumber, int amountOfImagesPerPage, String? url | Fetches the images, you can give it an URL or parameters that will be used with the declared URL. |
| addImage | void | ImageModel image | Adds the image to the state. |
| removeAllImages | Future<void> | None | Removes all images from the cache and the state. |
| removeImage | Future<void> | String imageUrl | Removes the image with the given image URL from the cache and the state. |
| bookmarkImage | void | String imageUrl | Bookmarks the image with the given URL in the state. |

## Used packages
- fast_cached_network_image, I used this package to cache the images
- hooks_riverpod, I used this package for the state management of the app
- flutter_hooks, I used this package to be able to use hooks in the app with riverpod
- http, I used this package for the network call to the Pexels API
- flutter_dotenv, I used this package for the .env with the variables/secrets
- path_provider, this package was neccesary for the fast_cached_network_image package to be able to save the images locally
- flutter_localizations was used for the localizations in the app.

## Challenges and Solutions
Another idea I was thinking about was to cache the images myself without using a package, but I chose not to do that because I did not want to make a huge list of UInt8Lists with all of the other properties as well.

I could have also saved the images locally myself but then i would also have to make a database for the other properties of the image and as i have never done that I chose to go for the package.

Because I used a package for the caching it makes testing harder, and to do that I would have to use a mocking package to test it.

Another possibility to 'cache' the images would have been to make a Firebase Storage and put the images in there but that's not really caching them as then they are still a network image.

Because I was thinking about that first idea for some time without using packages it took me a bit longer to make this application than I wanted it to take.
