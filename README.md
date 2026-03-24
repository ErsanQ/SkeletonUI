# SkeletonUI

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9-orange?logo=swift" alt="Swift 5.9"/>
  <img src="https://img.shields.io/badge/iOS-16%2B-blue?logo=apple" alt="iOS 16+"/>
  <img src="https://img.shields.io/badge/macOS-13%2B-blue?logo=apple" alt="macOS 13+"/>
  <img src="https://img.shields.io/badge/SPM-compatible-green" alt="SPM compatible"/>
  <img src="https://img.shields.io/badge/license-MIT-lightgrey" alt="MIT License"/>
</p>

<p align="center">
  A native SwiftUI skeleton loading library that makes your loading states look effortless.
</p>

---

<p align="center">
  <img src="assets/demo.gif" width="320"/>
</p>

---

## Features

- ✅ One-line API — `.skeleton(isLoading: viewModel.isLoading)`
- ✅ Three shapes: rectangle, circle, capsule
- ✅ Smooth shimmer animation with customizable speed and colors
- ✅ Respects Reduce Motion accessibility setting
- ✅ Animates gracefully in and out
- ✅ Zero dependencies — pure SwiftUI
- ✅ iOS 16+, macOS 13+, tvOS 16+, watchOS 9+, visionOS 1+

---

## Installation

### Swift Package Manager (Recommended)

In Xcode: `File → Add Package Dependencies` and enter:

```
https://github.com/ErsanQ/SkeletonUI
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ErsanQ/SkeletonUI", from: "1.0.0")
]
```

---

## Quick Start

```swift
import SkeletonUI

struct ProfileView: View {
    @State private var isLoading = true

    var body: some View {
        HStack(spacing: 12) {
            // Circle skeleton for avatar
            Image("avatar")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .skeleton(isLoading: isLoading, shape: .circle)

            VStack(alignment: .leading, spacing: 6) {
                // Text skeletons
                Text("John Appleseed")
                    .skeleton(isLoading: isLoading)

                Text("iOS Developer")
                    .skeleton(isLoading: isLoading)
            }
        }
    }
}
```

---

## Usage

### Basic

```swift
Text("Article Title")
    .skeleton(isLoading: isLoading)
```

### Shapes

```swift
// Profile picture
AsyncImage(url: url)
    .skeleton(isLoading: isLoading, shape: .circle)

// Card
CardView()
    .skeleton(isLoading: isLoading, shape: .rectangle(cornerRadius: 16))

// Badge
Text("Swift")
    .skeleton(isLoading: isLoading, shape: .capsule)
```

### Custom Colors

```swift
let brandedConfig = SkeletonConfiguration(
    baseColor: .purple.opacity(0.12),
    highlightColor: .purple.opacity(0.25),
    animationDuration: 1.2
)

Text("Branded content")
    .skeleton(isLoading: isLoading, config: brandedConfig)
```

### Accessibility

Automatically disables animation when the user enables "Reduce Motion":

```swift
Text("Accessible content")
    .skeletonAccessible(isLoading: isLoading)
```

### Building a Full Screen Skeleton

```swift
struct ArticleListView: View {
    @StateObject private var viewModel = ArticleViewModel()

    var body: some View {
        List {
            ForEach(viewModel.isLoading ? placeholders : viewModel.articles) { item in
                ArticleRow(article: item)
                    .skeleton(isLoading: viewModel.isLoading)
            }
        }
        .task { await viewModel.load() }
    }

    private var placeholders: [Article] {
        (0..<5).map { Article.placeholder(id: $0) }
    }
}
```

---

## API Reference

### `View.skeleton(isLoading:shape:config:)`

```swift
func skeleton(
    isLoading: Bool,
    shape: SkeletonShape = .rectangle(cornerRadius: 8),
    config: SkeletonConfiguration = .default
) -> some View
```

### `View.skeletonAccessible(isLoading:shape:)`

```swift
func skeletonAccessible(
    isLoading: Bool,
    shape: SkeletonShape = .rectangle(cornerRadius: 8)
) -> some View
```

### `SkeletonShape`

| Case | Description |
|------|-------------|
| `.rectangle(cornerRadius: CGFloat = 8)` | Rounded rectangle |
| `.circle` | Perfect circle |
| `.capsule` | Pill shape |

### `SkeletonConfiguration`

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `baseColor` | `Color` | `systemGray5` | Base fill color |
| `highlightColor` | `Color` | `systemGray4` | Shimmer highlight |
| `animationDuration` | `Double` | `1.5` | Seconds per sweep |
| `isAnimated` | `Bool` | `true` | Enable/disable animation |

**Presets:** `.default`, `.reducedMotion`

---

## Requirements

- iOS 16.0+ / macOS 13.0+ / tvOS 16.0+ / watchOS 9.0+ / visionOS 1.0+
- Swift 5.9+
- Xcode 15.0+

---

## License

SkeletonUI is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

---

## Author

Built by **Ersan Q Abo Esha** — [@ErsanQ](https://github.com/ErsanQ)

If SkeletonUI saved you time, consider giving it a ⭐️ on [GitHub](https://github.com/ErsanQ/SkeletonUI).
