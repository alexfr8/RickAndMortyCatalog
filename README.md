# RickAndMorty  
## _A simple client for Rick and Morty characters_

[![Build Status](https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Rick_and_Morty.svg/250px-Rick_and_Morty.svg.png)](https://en.wikipedia.org/wiki/Rick_and_Morty)

## 🚀 Features

- **Splash Screen**  
    Includes an image fetched from the internet to display while the first page of characters is being preloaded. Once the download is complete, the app navigates to the character list.

- **Paginated character list** (no more requests are made after reaching the end)  
    · Each page is cached in memory to reduce network usage  
    · When the user scrolls halfway through the page, the next page is fetched to minimize user waiting time during scrolling

- **Character search**  
    · Basic validation to start searching only when 3 or more characters are entered  
    · The search is initially performed within cached pages; if no results are found, the API is queried  
        (example test: without scrolling on the initial window, click on the magnifying glass icon and search for "Cousin". This character is not loaded until page 3 or 4, so it must be found via the API)

    · Search requests are not cached

- **Character detail view**  
    · Basic character information shown using different subviews  
    · To complete the info, a request is made for the episodes the character has appeared in, displayed in a horizontal scroll

- **Internationalization**, though only available in **English** using `String.catalog` (instead of `.strings` files)

- **Navigation abstracted to a router**  
    New screens require modification of routing classes. Navigation is handled through a single `NavigationStack` which is the app’s foundation.

- **MVVM design pattern**

- **Asynchronous image loading**  
    · Images are cached using `NSCache` and reused when showing the character in both the list and detail views

- **Error handling**

- **iOS 18.0+ support**

## 🛠 Technologies

- **SwiftUI** for UI
- **Async/Await** for asynchronous operations
- **Swift Package Manager** for dependency management  
    · Only external dependency used: **SwiftLint** for code style improvement  
    · A local package was created for the services layer, containing necessary classes for HTTP requests

- **Repository Pattern**  
    · All domain data access is done via a single repository (enought for a small app), which manages caching and calls the service layer when needed. If local storage or other data features are needed, they should go through the repository.

- **Dependency Injection**  
    · The goal is to have a single dependency and inject it via `Environment` into each screen, which is then used in the ViewModel. The `AppState` class holds navigation info and data management (repository).

- The project includes support for **strict concurrency**

## 🧪 Testing

The project includes:  
- Unit tests (for ViewModels, extensions, repository, and cache)  
- Mocks for testing  
- Integration tests (a small one to verify services)  
- Test coverage > 60%

## 🔧 Software used

- iOS 18.0+  
- Xcode 16.0+  
- Swift 6.0+  
- Proxyman to inspect HTTP requests  
- Postman to manually test API requests and build the data model  
- Cursor and ChatGPT

## ⬆️ Improvements to consider

- More componentization: e.g. a custom `ProgressView` to avoid code duplication and ensure visual consistency
- Error handling: Improve specificity in error handling to better inform the user
- Data depth: Expand episode information by downloading and showing the full list of characters per episode, possibly in a bottom sheet or expandable view
- HTTP request complexity: Consider downloading 2–3 pages at once, using group tasks to fetch episode data for each character or characters per episode
- More complex color schemes, including dark theme support
