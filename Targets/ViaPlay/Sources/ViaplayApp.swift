import SwiftUI
import ViaPlayUI
import ViaPlayKit
import CoreData

@main
struct ViaplayApp: App {
    @Environment(\.scenePhase) private var scenePhase
    private let container: DIContainer

    init() {
        self.container = .bootstrap()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.dynamicTypeSize, .medium)
                .environment(\.colorScheme, .light)
                .environment(\.accessibilityEnabled, false)
                .environment(\.locale, .init(identifier: "en-US"))
                .inject(self.container)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .background: saveContext()
            default: break
            }
        }
    }

    func saveContext() {
        let context = self.container.persistence.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
