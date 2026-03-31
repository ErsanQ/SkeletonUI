import SwiftUI

// MARK: - View+Skeleton (Public API)

public extension View {

    // MARK: - Primary API

    /// Overlays a shimmer skeleton placeholder on this view while data is loading.
    @MainActor
    @ViewBuilder
    func skeleton(
        isLoading: Bool,
        shape: SkeletonShape = .rectangle(cornerRadius: 8),
        config: SkeletonConfiguration = .default
    ) -> some View {
        modifier(SkeletonModifier(isLoading: isLoading, shape: shape, config: config))
    }

    // MARK: - Accessibility-aware API

    /// Overlays a shimmer skeleton, automatically respecting the system's "Reduce Motion" setting.
    @MainActor
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

@MainActor
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
