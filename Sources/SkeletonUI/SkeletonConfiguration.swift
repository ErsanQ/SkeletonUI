import SwiftUI

/// Configuration for the visual and behavioral aspects of a skeleton loader.
public struct SkeletonConfiguration: Sendable {
    /// The primary color of the skeleton placeholder.
    public let baseColor: Color
    /// The color of the moving shimmer highlight.
    public let highlightColor: Color
    /// The duration of one full shimmer cycle in seconds.
    public let speed: Double
    /// The corner radius applied to the skeleton shapes.
    public let cornerRadius: CGFloat
    
    /// Creates a custom skeleton configuration.
    public init(
        baseColor: Color = .gray.opacity(0.3),
        highlightColor: Color = .gray.opacity(0.1),
        speed: Double = 1.5,
        cornerRadius: CGFloat = 8
    ) {
        self.baseColor = baseColor
        self.highlightColor = highlightColor
        self.speed = speed
        self.cornerRadius = cornerRadius
    }
    
    /// The standard ErsanQ skeleton style.
    public static let `default` = SkeletonConfiguration()
}
