import ProjectDescription
import ProjectDescriptionHelpers


func makeFeatureTargets() -> [Target] {
    let deployment: ProjectDescription.DeploymentTarget = .iOS(
        targetVersion: "15.0",
        devices: .iphone
    )

    let ui = Project.featureFramework(
        name: "ViaPlayUI",
        dependencies: [
            .target(name: "SharedModel"),
            .target(name: "ViaPlayKit")
        ],
        testDependencies: [
            .external(name: "SnapshotTesting")
        ],
        deploymentTarget: deployment
    )

    let viaPlayAPI = Project.featureFramework(
        name: "ViaPlayAPI",
        dependencies: [
            .target(name: "SharedModel"),
            .target(name: "WebClient")
        ],
        testDependencies: [
            .external(name: "Difference"),
            .external(name: "Mocker")
        ],
        deploymentTarget: deployment,
        prodOnly: false
    )

    let webClient = Project.featureFramework(
        name: "WebClient",
        deploymentTarget: deployment,
        prodOnly: true
    )

    let models = Project.featureFramework(
        name: "SharedModel",
        deploymentTarget: deployment,
        prodOnly: true
    )

    let viaPlayKit = Project.featureFramework(
        name: "ViaPlayKit",
        dependencies: [
            .target(name: "SharedModel"),
            .target(name: "ViaPlayAPI")
        ],
        testDependencies: [
            .external(name: "Difference"),
            .external(name: "Mocker"),
            .external(name: "SnapshotTesting")
        ],
        deploymentTarget: deployment,
        prodOnly: false,
        coreDataModels: [.init("Targets/ViaPlayKit/CoreData/Sections.xcdatamodeld")]

    )

    return ui + viaPlayAPI + models + webClient + viaPlayKit
}


let project = Project.app(
    name: "ViaPlay",
    platform: .iOS,
    featureTargets: makeFeatureTargets(),
    additionalTargets: [
        .target(name: "ViaPlayUI"),
        .target(name: "ViaPlayKit")
    ]
)
