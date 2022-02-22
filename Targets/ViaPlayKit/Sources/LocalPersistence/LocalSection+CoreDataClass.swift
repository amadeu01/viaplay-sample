import Foundation
import CoreData
import SharedModel

@objc(LocalSection)
public class LocalSection: NSManagedObject {

}

public extension LocalSection {

    static func create(
        with context: NSManagedObjectContext,
        fromRemote section: Section
    ) -> LocalSection {
        let predicate = NSPredicate(format: "id == %@", section.sectionId ?? "")
        let fetchRequest = LocalSection.fetchRequest()
        fetchRequest.predicate = predicate

        let localSection = ((try? context.fetch(fetchRequest)) ?? []).first ?? LocalSection(context: context)
        update(localSection, fromRemote: section)
        try? context.save()

        return localSection
    }

    private static func update(
        _ localSection: LocalSection,
        fromRemote section: Section
    ) {

        localSection.id = section.sectionId
        localSection.title = section.title
        localSection.type = section.type
        localSection.pageType = section.pageType
        localSection.sectionDescription = section.sectionDescription
    }
}
