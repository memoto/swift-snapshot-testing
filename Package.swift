// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "swift-snapshot-testing",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "SnapshotTesting",
      targets: ["SnapshotTesting"]
    ),
    .library(
      name: "InlineSnapshotTesting",
      targets: ["InlineSnapshotTesting"]
    ),
    .library(
      name: "SnapshotTestingCustomDump",
      targets: ["SnapshotTestingCustomDump"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.3"),
    .package(url: "https://github.com/memoto/swift-syntax-prebuilt", "509.0.0"..<"601.0.0"),
  ],
  targets: [
    .target(
      name: "SnapshotTesting"
    ),
    .testTarget(
      name: "SnapshotTestingTests",
      dependencies: [
        "SnapshotTesting"
      ],
      exclude: [
        "__Fixtures__",
        "__Snapshots__",
      ]
    ),
    .target(
      name: "InlineSnapshotTesting",
      dependencies: [
        "SnapshotTesting",
        "SnapshotTestingCustomDump",
        .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-prebuilt")
      ]
    ),
    .testTarget(
      name: "InlineSnapshotTestingTests",
      dependencies: [
        "InlineSnapshotTesting"
      ]
    ),
    .target(
      name: "SnapshotTestingCustomDump",
      dependencies: [
        "SnapshotTesting",
        .product(name: "CustomDump", package: "swift-custom-dump"),
      ]
    ),
  ]
)
