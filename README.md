# DeliveryApp
This project shows a list of deliveries with receiver's photo and item description and also locates the delivery location on the map when clicked on delivery item.

# Requirement
- XCode 10.2
- MAC 10.14

# Installation
- To run the project :
- Open podfile from project repository 
- Open terminal and cd to the directory containing the Podfile
- Run the "pod install" command
- Open DeliveryApp.xcworkspace 

# Language used 
Swift 5.0

# App Version
1.0 
# Design Pattern Used

## VIPER
Viper is a design pattern that implements ‘separation of concern’ paradigm. One feature, one module. For each module VIPER has five different classes with distinct roles.

__View:__ Contains Class that has all the code to show the app interface to the user and get their responses. Upon receiving a response View alerts the Presenter.

__Interactor:__ Interactor has knowledge of our entities, and fetches and stores data with Data Manager. Primarily make API calls to fetch data from a source. Responsible for making data calls but not necessarily from itself.

__Presenter:__ This is nucleus of a module, responsible for all UI related business logic data and determining if it needs more data from the interactor. It gets user response from the View and work accordingly. Only class to communicate with all the other components. Calls the router for wire-framing, Interactor to fetch data (network calls or local data calls), view to update the UI.

__Entity:__ Contains plain model classes used by the interactor.

__Router:__ Does the wire-framing. Listens from the presenter about which screen to present and executes that.

__Data Manager:__ Data Manager decides if data is to be fetched from API or Core Data based on network availability.

![Viper](https://user-images.githubusercontent.com/52790579/62024201-b39a9d80-b1f1-11e9-8fad-da94d19fc142.png)

# Features

## ListView
- Shows list of deliveries with receiver's photo and item description.
- If Network available it fetches deliveries from API only, and in case of no network or failure it shows deliveries fetched from local database if available.

## MapView
- Used Apple Mapkit framework to show delivery on map.

## Data Caching
- Core data is used for data caching. Items fetched from server are displayed to UI and also saves/updates on core data.
- If network connectivity is not available and data is available in Core data then it fetchs data from it and display on UI.

## Pull to Refresh
- If network available - fetches data from starting index from server, if data is available then it is displayed new data to UI and then save/update it into Core data.
- If network not available - Error alert shows "No internet connection".

## Pagination
- Fetching data from starting index and when a user goes to bottom of the table view, hits request for fetching next batch of deliveries by setting offset to count of current deliveries available, then displaying in the UI. Also continuesly saves/updates it into Core data.
- Pagination is also available in case when no network connectivity available and fetches from core data in a batch of 20 items to avoid load on app.
- Pagination ends once we recieve empty list of deliveries with success code from server.

# Crashlytics

App has implemented crashlytics using Fabric. Here is the steps for crashlytics setup.
1. Create Organization on Fabric, it can be named as your company.
2. Then simply update app configurations as per your organization. Please follow https://fabric.io/kits/ios/crashlytics/install for the same.

# Assumptions        
-   The app is designed for iPhones only.        
-   App currently supports English language. However, provision to add support for other languages is available with localization.
-   Mobile platform supported: iOS (10.x11.x, 12.x)        
-   Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series    
-   iPhone app support would be limited to portrait mode.
-   Data caching is available.

# Unit Testing
- Unit testing is done by using XCTest.

# Frameworks/Libraries used
- Alamofire
- SDWebImage
- Fabric
- Crashlytics
- OHHTTPStubs/Swift

# Application Screenshots
![DeliveryList](https://user-images.githubusercontent.com/52790579/61937345-477b2800-afac-11e9-9eb7-02a510d84572.png)
![MapScreen](https://user-images.githubusercontent.com/52790579/61937346-477b2800-afac-11e9-913a-fff5623e19ea.png)
