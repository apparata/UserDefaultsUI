
# UserDefaultsUI

Swift package that provides a `UserDefaults` browser and editor for debug mode in SwiftUI apps.

## License

See the LICENSE file for licensing information.

## Usage

Let's say the keys of your user defaults have a prefix, e.g. "com.example.", and you don't need to see it prominently in the `UserDefaults` browser, then you would list that prefix in the `hidePrefixes` parameter to the `UserDefaultsBrowser` initializer.

In the example below, `NavigationView` is used, but `NavigationStack` works too.

```swift
import SwiftUI
import UserDefaultsUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            UserDefaultsBrowser(hidePrefixes: ["com.example."])
        }
    }
}
```

Screenshot

![Screenshot](https://github.com/apparata/UserDefaultsUI/assets/384210/dd968515-f971-4fb5-9920-200b326fbfe1)

