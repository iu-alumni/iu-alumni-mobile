# IU Alumni Flutter App / Alumni Client

IU Alumni Flutter App created during the Industrial Project Master's Course at Innopolis University.

## Technologies and Architecture

This project uses Bloc/Cubit for state management and DI, AutoRoute for navigation, and Logger for logging. Also some important noted on the project architecture.

#### Clean Layered Structure

- `Data` layer is responsible for data loading and parsing. `Dio` is used to load the data from the Internet, while any Database solution also falls into this layer. Please use `freezed` to parse the data if needed and `fpdart` to present results of functions that could fail. 
- `Application` layer is responsible for data processing before presenting it to the UI. It stores everything runtime and frees upcoming Blocs/Cubits from the burden of managing cache, sorting or filtering data. Also, this layer must contain models widely used across the layers. Some data definitely needs different models on the `Presentation` or `Data` layers, but the default option lies here on this layer. You can also know this as a `Domain` layer.
- `Presentation` layer consists of Blocs/Cubits responsible for the application logic while also containing the UI state. Several rules are assumed:
    - Nothing important should be stored on the `Presentation` layer. Blocs and Cubits must be easy to dispose when needed.
    - Blocs, Cubits and Widgets must be as stupid as possible. Animations or state management cases coverage alone requires enough lines of code, and it is the reason the presentation layer exists in the first place. Move logic to the `Application` as much as possible.
    - The state must be immutable. Consider Fast Immutable Collections for collections, utilize sealed classes for complex non-interchangeable states. 

## Targets

The app supports Web, Android, and iOS. The difference between targets lead us to create two separate branches for mobile and web targets. For instance, web doesn't support AppMetrica or sqflite (used to store cities database, leverage FTS and convert city names to coordinates), and use different map implementations. We don't need to compile unused code and include unused assets. 

Web development takes place in the `web-main` branch that is apparently the main branch of this repo, since the web target is the most popular.

Mobile development takes place in the `mobile-main`. 

After implementing a target-universal feature, cherry-pick it to the second branch. 

### Environment Variables

Environment variables are inserted using `--dart-define`

- All targets require `host_path`, e.g. `--dart-define host_path=https://backendserver.ru` 
- Mobile requires `app_metrica_key`, e.g. `--dart-define app_metrica_key=xx-xx-xx`
