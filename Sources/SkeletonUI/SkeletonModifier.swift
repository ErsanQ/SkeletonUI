import SwiftUI

// MARK: - SkeletonModifier

/// A `ViewModifier` that overlays a shimmer skeleton when `isLoading` is `true`.
///
/// Applied via the `View.skeleton(...)` extension. This modifier:
/// - Hides the real content (opacity → 0) while loading.
/// - Overlays a ``ShimmerView`` clipped to the chosen ``SkeletonShape``.
/// - Fades the skeleton out gracefully when loading ends.
struct SkeletonModifier: ViewModifier {

    // MARK: - Inputs

    let isLoading: Bool
    let shape: SkeletonShape
    let config: SkeletonConfiguration

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .overlay {
                if isLoading {
                    ShimmerView(config: config)
                        .mask(alignment: .center) {
                            skeletonMask
                        }
                        .transition(.opacity.animation(.easeInOut(duration: 0.25)))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: isLoading)
    }

    // MARK: - Mask Shape

    @ViewBuilder
    private var skeletonMask: some View {
        switch shape {
        case .rectangle(let radius):
            RoundedRectangle(cornerRadius: radius, style: .continuous)
        case .circle:
            Circle()
        case .capsule:
            Capsule()
        }
    }
}
