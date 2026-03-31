import SwiftUI

/// A view that renders a moving shimmer effect, typical of skeleton loaders.
///
/// `ShimmerView` provides a high-performance linear gradient that animates
/// across its parent container. It respects the system's "Reduce Motion" setting.
@MainActor
public struct ShimmerView: View {
    @State private var phase: CGFloat = 0
    private let config: SkeletonConfiguration
    
    /// Creates a new ShimmerView.
    ///
    /// - Parameter config: The configuration determining colors and speed.
    public init(config: SkeletonConfiguration = .default) {
        self.config = config
    }
    
    public var body: some View {
        GeometryReader { geometry in
            LinearGradient(
                colors: [config.baseColor, config.highlightColor, config.baseColor],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: geometry.size.width * 2)
            .offset(x: -geometry.size.width + (phase * geometry.size.width * 2))
            .onAppear {
                withAnimation(.linear(duration: config.speed).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
        }
    }
}
