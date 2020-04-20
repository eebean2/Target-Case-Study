#  Process Log

This log is here to document my thought process as well as the length of my project. At the start of this log, I've already done the following:

- Researched designs based on what the current Target ecosytem is using
- Looked at successfull designs competitors were doing to funnel users, or hide a feature
- Come to a design based on the mockups and themed in the Target design
- Going to do my best to follow with Tempo & 100% code model

### Monday April 13th

- Created this log
- Added a UINavigationController to control the navigation stack and manage a unified navigation
- Studied Tempo

### Tuesday April 14th

- Noticed in the Target Deals API that not all items have a "salePrice", not sure if this is an oversite or test. Using "price" to replace "salePrice" as all objects are coming from the "Deals API", so we can assume all items are already determeined to be a deal/on sale
- For sake of time, not trying to play font match. May look later if target has a set font they use for their ecosystem/iOS app if time allows
- See Codable under API/ SDK's Used
- Created DetailViewController.swift/.xib to start new view controller, basing it off ListViewController for Tempo. I don't understand Harmony Layout, so if/when I switch to hard coded view I will be using traditional Layout Constraints
- Started re-design of ProductListView

### Wednesday April 15th & Thursday April 16th

- Due to a stomach bug, I was not able to work these days

### Friday April 17th

- Created Deals.swift to pull and handle the Target Deals API, including pulling, processing, and sorting the data from the url given in the readme. Codable and Equatable used here, codable as reasoned below, equatable to ensure future useage of the api is smooth. Unknown if I will need it later, but as "_id" is already coded in, might as well add it now instead of fighting to add it later
- NOTE: Design wise, a good idea would to also include the star rating as included in the current app design. Not only does this give the individual items height (more eye travel over each indivual item), but it also gives more reason for people to (or not to) buy an item
- Decided to use NSCache to cashe images, as the link provided is slow to load and caching the obejcts should not only help with load time, but decrease pressure later on if the app is ever re-used later on
- Created a download manage to handle image downloads, cache manager to handle managing of cached objects (DownloadManager.swift and CacheManger.swift respectivly). Both are singleton classes and are designed for longterm background usage and are prepared to scale


- Finally figured out how to mostly use Tempo/Harmony. Well coded Target.


- Due to the time it took to load, and the number of failures loading the images, the image site has been changed to PlaceBeard.it using notag images


# API/ SDK's Used

## Tempo

As Tempo appears to be an in-house Target API/SDK based on an additional internal API/SDK called Harmony, I wanted to adapt as best as I could to it with as little documentation/sample code as I have.

## Codable

Swift native Codable is used here as an alternative to many older/third party choices due to it's native swift charm. It's easy to use and quick to adapt. If not liked, it is easy to adapt to just about any third party or legacy method due to how little code it takes.

