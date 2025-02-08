# UI Alumni Mobile Flutter App

UI Alumni Flutter Mobile App created during the Industrial Project Master's Course at Innopolis University.

## Technologies and Architecture

This project uses Bloc/Cubit for state management and DI, AutoRoute for navigation, and Logger for logging. Also some important noted on the project architecture.

#### Clean Layered Structure

- `Data` layer is responsible for data loading and parsing. `Dio` is used to load the data from the Internet, while any Database solution also falls into this layer. Please use `freezed` to parse the data if needed and `fpdart` to present results of functions that *can* fail. 
- `Application` layer is responsible for data processing before presenting it to the UI. It stores everything runtime and frees upcoming Blocs/Cubits from the burden of managing cache, sorting or filtering data. Also, this layer must contain models widely used across the layers. Some data definitely needs different models on the `Presentation` or `Data` layers, but the default option lies here on this layer. You can also know this as a `Domain` layer, but I like the name `Application` more 😎😎.
- `Presentation` layer consists of Blocs/Cubits responsible for the application logic while also containing the UI state. Several rules are assumed:
    - Nothing important should be stored on the `Presentation` layer. Blocs and Cubits must be easy to dispose when needed.
    - Bloc, Cubits and Widgets must keep as stupid as possible. Animations or state management cases coverage alone requires enough lines of code, and it is the reason the presentation layer exists in the first place. Move logic to the `Application` as much as possible.
    - The state must be immutable. Consider Fast Immutable Collections for collections, utilize sealed classes for complex non-interchangeable states.  
