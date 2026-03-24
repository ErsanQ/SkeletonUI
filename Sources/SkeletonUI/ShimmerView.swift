import SwiftUI

// MARK: - ShimmerView

/// An internal view that renders the animated shimmer gradient.
///
/// This is the engine behind the skeleton effect. It renders a `LinearGradient`
/// whose start/end points are animated from off-screen left to off-screen right,
/// producing the signature "sweeping highlight" shimmer.
struct ShimmerView: View {

    // MARK: - Configuration

    let config: SkeletonConfiguration

    // MARK: - State

    @State private var isAnimating = false

    // MARK: - Gradient Points

    private var startPoint: UnitPoint {
        isAnimating ? UnitPoint(x: 1.5, y: 0.5) : UnitPoint(x: -0.5, y: 0.5)
    }

    private var endPoint: UnitPoint {
        isAnimating ? UnitPoint(x: 2.5, y: 0.5) : UnitPoint(x: 0.5, y: 0.5)
    }

    // MARK: - Body

    var body: some View {
        LinearGradient(
            stops: [
                .init(color: config.baseColor, location: 0.0),
                .init(color: config.baseColor, location: 0.35),
                .init(color: config.highlightColor, location: 0.50),
                .init(color: config.baseColor, location: 0.65),
                .init(color: config.baseColor, location: 1.0),
            ],
            startPoint: startPoint,
            endPoint: endPoint
        )
        .onAppear {
            guard config.isAnimated else { return }

            withAnimation(
                .linear(duration: config.animationDuration)
                .repeatForever(autoreverses: false)
            ) {
                isAnimating = true
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
#Preview("Shimmer") {
    ShimmerView(config: .default)
        .frame(height: 40)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding()
}
#endif
