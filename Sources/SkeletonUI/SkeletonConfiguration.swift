import SwiftUI

// MARK: - SkeletonConfiguration

/// Controls the visual appearance and animation behavior of skeleton placeholders.
///
/// You can create a custom configuration and pass it to any skeleton modifier,
/// or simply use ``SkeletonConfiguration/default`` for a sensible out-of-the-box look.
///
/// ```swift
/// let config = SkeletonConfiguration(
///     baseColor: .purple.opacity(0.15),
///     highlightColor: .purple.opacity(0.30),
///     animationDuration: 1.2
/// )
///
/// Text("Title")
///     .skeleton(isLoading: isLoading, config: config)
/// ```
public struct SkeletonConfiguration: Sendable {

    // MARK: - Properties

    /// The base fill color of the skeleton.
    public var baseColor: Color

    /// The bright highlight color that sweeps across during the shimmer animation.
    public var highlightColor: Color

    /// Duration in seconds for one complete shimmer sweep. Defaults to `1.5`.
    public var animationDuration: Double

    /// Determines whether the shimmer animation plays.
    ///
    /// Set to `false` to show a static placeholder without animation.
    /// Useful for respecting `UIAccessibility.isReduceMotionEnabled`.
    public var isAnimated: Bool

    // MARK: - Initializer

    public init(
        baseColor: Color,
        highlightColor: Color,
        animationDuration: Double = 1.5,
        isAnimated: Bool = true
    ) {
        self.baseColor = baseColor
        self.highlightColor = highlightColor
        self.animationDuration = animationDuration
        self.isAnimated = isAnimated
    }
}

// MARK: - Default Configuration

public extension SkeletonConfiguration {

    /// The default skeleton configuration, adapting automatically to light and dark mode.
    static var `default`: SkeletonConfiguration {
        SkeletonConfiguration(
            baseColor: .skeletonBase,
            highlightColor: .skeletonHighlight,
            animationDuration: 1.5
        )
    }

    /// A configuration with reduced motion — useful when `UIAccessibility.isReduceMotionEnabled` is `true`.
    static var reducedMotion: SkeletonConfiguration {
        SkeletonConfiguration(
            baseColor: .skeletonBase,
            highlightColor: .skeletonBase,
            animationDuration: 1.5,
            isAnimated: false
        )
    }
}

// MARK: - Internal Color Helpers

private extension Color {

    static var skeletonBase: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemGray5)
        #elseif canImport(AppKit)
        Color(nsColor: .separatorColor).opacity(0.4)
        #else
        Color.gray.opacity(0.2)
        #endif
    }

    static var skeletonHighlight: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemGray4)
        #elseif canImport(AppKit)
        Color(nsColor: .separatorColor).opacity(0.7)
        #else
        Color.gray.opacity(0.35)
        #endif
    }
}
