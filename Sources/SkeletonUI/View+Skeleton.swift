import SwiftUI

// MARK: - View+Skeleton (Public API)

public extension View {

    // MARK: - Primary API

    /// Overlays a shimmer skeleton placeholder on this view while data is loading.
    ///
    /// The real content is hidden (opacity → 0) and replaced by an animated
    /// shimmer that matches the given shape. When `isLoading` becomes `false`,
    /// the skeleton fades out and the content fades in.
    ///
    /// **Basic usage:**
    /// ```swift
    /// Text("John Appleseed")
    ///     .skeleton(isLoading: viewModel.isLoading)
    /// ```
    ///
    /// **Custom shape:**
    /// ```swift
    /// AsyncImage(url: avatarURL)
    ///     .skeleton(isLoading: isLoading, shape: .circle)
    /// ```
    ///
    /// **Custom configuration:**
    /// ```swift
    /// CardView()
    ///     .skeleton(
    ///         isLoading: isLoading,
    ///         shape: .rectangle(cornerRadius: 16),
    ///         config: SkeletonConfiguration(
    ///             baseColor: .purple.opacity(0.15),
    ///             highlightColor: .purple.opacity(0.30)
    ///         )
    ///     )
    /// ```
    ///
    /// - Parameters:
    ///   - isLoading: Whether to show the skeleton. Animates in/out.
    ///   - shape: The clipping shape of the skeleton. Defaults to `.rectangle(cornerRadius: 8)`.
    ///   - config: Appearance and animation settings. Defaults to ``SkeletonConfiguration/default``.
    /// - Returns: A view that shows a skeleton placeholder while loading.
    @ViewBuilder
    func skeleton(
        isLoading: Bool,
        shape: SkeletonShape = .rectangle(cornerRadius: 8),
        config: SkeletonConfiguration = .default
    ) -> some View {
        modifier(SkeletonModifier(isLoading: isLoading, shape: shape, config: config))
    }

    // MARK: - Accessibility-aware API

    /// Overlays a shimmer skeleton, automatically respecting the system's
    /// "Reduce Motion" accessibility setting.
    ///
    /// When Reduce Motion is enabled, the skeleton appears as a static
    /// placeholder without animation.
    ///
    /// ```swift
    /// Text("Article title")
    ///     .skeletonAccessible(isLoading: isLoading)
    /// ```
    ///
    /// - Parameters:
    ///   - isLoading: Whether to show the skeleton.
    ///   - shape: The clipping shape. Defaults to `.rectangle(cornerRadius: 8)`.
    @ViewBuilder
    func skeletonAccessible(
        isLoading: Bool,
        shape: SkeletonShape = .rectangle(cornerRadius: 8)
    ) -> some View {
        SkeletonAccessibleWrapper(isLoading: isLoading, shape: shape) {
            self
        }
    }
}

// MARK: - Accessibility Wrapper

/// Internal wrapper that reads the `accessibilityReduceMotion` environment value.
private struct SkeletonAccessibleWrapper<Content: View>: View {

    let isLoading: Bool
    let shape: SkeletonShape
    let content: Content

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(isLoading: Bool, shape: SkeletonShape, @ViewBuilder content: () -> Content) {
        self.isLoading = isLoading
        self.shape = shape
        self.content = content()
    }

    var body: some View {
        content.skeleton(
            isLoading: isLoading,
            shape: shape,
            config: reduceMotion ? .reducedMotion : .default
        )
    }
}
