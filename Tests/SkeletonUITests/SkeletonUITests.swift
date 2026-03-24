import XCTest
import SwiftUI
@testable import SkeletonUI

final class SkeletonUITests: XCTestCase {

    // MARK: - SkeletonConfiguration Tests

    func test_defaultConfiguration_hasExpectedDuration() {
        let config = SkeletonConfiguration.default
        XCTAssertEqual(config.animationDuration, 1.5)
    }

    func test_defaultConfiguration_isAnimated() {
        let config = SkeletonConfiguration.default
        XCTAssertTrue(config.isAnimated)
    }

    func test_reducedMotionConfiguration_isNotAnimated() {
        let config = SkeletonConfiguration.reducedMotion
        XCTAssertFalse(config.isAnimated)
    }

    func test_customConfiguration_respectsCustomDuration() {
        let config = SkeletonConfiguration(
            baseColor: .red,
            highlightColor: .orange,
            animationDuration: 2.5
        )
        XCTAssertEqual(config.animationDuration, 2.5)
    }

    // MARK: - SkeletonShape Tests

    func test_rectangleShape_defaultRadius() {
        if case .rectangle(let radius) = SkeletonShape.rectangle() {
            XCTAssertEqual(radius, 8)
        } else {
            XCTFail("Expected .rectangle case")
        }
    }

    func test_rectangleShape_customRadius() {
        if case .rectangle(let radius) = SkeletonShape.rectangle(cornerRadius: 24) {
            XCTAssertEqual(radius, 24)
        } else {
            XCTFail("Expected .rectangle case with radius 24")
        }
    }

    func test_circleShape() {
        guard case .circle = SkeletonShape.circle else {
            XCTFail("Expected .circle case")
            return
        }
    }

    func test_capsuleShape() {
        guard case .capsule = SkeletonShape.capsule else {
            XCTFail("Expected .capsule case")
            return
        }
    }

    // MARK: - Sendable Conformance Tests

    func test_configuration_isSendable() {
        // Compile-time test: SkeletonConfiguration must be Sendable
        let _: any Sendable = SkeletonConfiguration.default
    }

    func test_shape_isSendable() {
        // Compile-time test: SkeletonShape must be Sendable
        let _: any Sendable = SkeletonShape.circle
        let _: any Sendable = SkeletonShape.capsule
        let _: any Sendable = SkeletonShape.rectangle(cornerRadius: 12)
    }
}
