#if canImport(SwiftUI)
import SwiftUI

// MARK: - SkeletonShape

/// Defines the visual shape of the skeleton placeholder.
///
/// Use ``SkeletonShape`` to match the skeleton to the shape of the content it's replacing.
///
/// ```swift
/// // Matches a profile picture
/// AsyncImage(url: url)
///     .skeleton(isLoading: isLoading, shape: .circle)
///
/// // Matches a pill-shaped badge
/// Text("Swift")
///     .skeleton(isLoading: isLoading, shape: .capsule)
///
/// // Matches a card with custom radius
/// CardView()
///     .skeleton(isLoading: isLoading, shape: .rectangle(cornerRadius: 16))
/// ```
public enum SkeletonShape: Sendable {

    /// A rounded rectangle.
    ///
    /// - Parameter cornerRadius: The radius for the rounded corners. Defaults to `8`.
    case rectangle(cornerRadius: CGFloat = 8)

    /// A perfect circle that fills the available space.
    ///
    /// Best suited for avatar images and icon placeholders.
    case circle

    /// A capsule (pill shape) with fully rounded ends.
    ///
    /// Best suited for tags, badges, and button placeholders.
    case capsule
}
#endif
