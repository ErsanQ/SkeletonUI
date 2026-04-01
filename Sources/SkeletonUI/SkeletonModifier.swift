#if canImport(SwiftUI)
import SwiftUI

/// A ViewModifier that overlays a skeleton placeholder on any view.
@MainActor
public struct SkeletonModifier: ViewModifier {
    
    let isLoading: Bool
    let shape: SkeletonShape
    let config: SkeletonConfiguration
    
    public func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .overlay(
                ZStack {
                    if isLoading {
                        ShimmerView(config: config)
                            .skeletonClip(shape: shape)
                            .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    }
                }
            )
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8), value: isLoading)
    }
}

private extension View {
    @ViewBuilder
    func skeletonClip(shape: SkeletonShape) -> some View {
        switch shape {
        case .rectangle(let radius):
            self.cornerRadius(radius)
        case .circle:
            self.clipShape(Circle())
        case .capsule:
            self.clipShape(Capsule())
        }
    }
}
#endif
