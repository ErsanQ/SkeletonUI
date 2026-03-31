import SwiftUI

public extension View {
    /// Adds a shimmering skeleton overlay to the view when a condition is met.
    ///
    /// - Parameters:
    ///   - active: If true, the skeleton shimmer is visible.
    ///   - config: Custom configuration for the shimmer effect.
    /// - Returns: A view that displays a skeleton when active.
    @MainActor
    func skeleton(active: Bool, config: SkeletonConfiguration = .default) -> some View {
        self.modifier(SkeletonModifier(active: active, config: config))
    }
}

/// An internal ViewModifier that handles the conditional rendering of the skeleton overlay.
@MainActor
private struct SkeletonModifier: ViewModifier {
    let active: Bool
    let config: SkeletonConfiguration
    
    func body(content: Content) -> some View {
        content
            .overlay(
                active ? ShimmerView(config: config).mask(content) : nil
            )
    }
}
