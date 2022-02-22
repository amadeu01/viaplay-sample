import Foundation
import CoreData


extension LocalSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalSection> {
        return NSFetchRequest<LocalSection>(entityName: "LocalSection")
    }

    @NSManaged public var id: String?
    @NSManaged public var sectionDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var pageType: String?
}
