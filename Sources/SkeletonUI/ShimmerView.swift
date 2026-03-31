import SwiftUI

/// A GPU-accelerated shimmer effect used as the base for skeletons.
@MainActor
public struct ShimmerView: View {
    
    // MARK: - Properties
    
    private let configuration: SkeletonConfiguration
    @State private var phase: CGFloat = 0
    
    // MARK: - Init
    
    public init(configuration: SkeletonConfiguration = .default) {
        self.configuration = configuration
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base Background
                configuration.baseColor
                
                // Animated Highlight
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        configuration.highlightColor,
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geometry.size.width * 2)
                .offset(x: -geometry.size.width + (geometry.size.width * 2 * phase))
            }
        }
        .onAppear {
            guard configuration.isAnimated else { return }
            withAnimation(
                .linear(duration: configuration.animationDuration)
                .repeatForever(autoreverses: false)
            ) {
                phase = 1
            }
        }
    }
}
