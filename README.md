# SwiftUIKitUI

A description of this package.


```swift

enum HapticType {
    case light
    case heavy
    case error
    case delete
    
    var effectFileName: String {
        switch self {
        case .light:
            return "tap_effect_light"
        case .heavy:
            return "tap_effect_heavy"
        case .error:
            return "error_effect"
        case .delete:
            return "delete_effect_light"
        }
    }
}

```
