
* Architecture *

MVVM (ModelView-View-Model)

Data binding is used to communicate between View and ViewModel.

Additionally the app follows the single responsibility princible - classes have just one responsibility, making the code easier to understand and maintain.

* Data *

The data is stored in a single repository which is dependency injected into the view models.
Info fetched from server is stored locally, without being cached. When offline, application is basically unusable anyways.
Core data is overkill for storing data this simple.

* Depedencies used *

Resolver - Dependency injection.
MapBox - Display map data. The API key is stored in the plist. Note, this dependency is huge (600MB+).

* Testing *

Unit tests covering parsing.
Unit tests covering network fetch functionality.
Automation tests covering basic UI functionality.
SwiftUI previews.
