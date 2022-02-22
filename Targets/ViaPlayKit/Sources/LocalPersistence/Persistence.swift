import CoreData

public struct PersistenceController {
    public static let shared = PersistenceController()

    #if DEBUG
    public static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
            let newItem = LocalSection(context: viewContext)
            newItem.id = "\(index)"
            newItem.title = "Test \(index)"
            newItem.sectionDescription = "Description: at \(index)"
            newItem.pageType = "section"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    #endif

    public let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let bundle = Bundle(for: TokenBundle.self)
        guard let modelURL = bundle.url(forResource: "Sections", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else { fatalError() }

        container = NSPersistentContainer(name: "Sections", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

private class TokenBundle {}
