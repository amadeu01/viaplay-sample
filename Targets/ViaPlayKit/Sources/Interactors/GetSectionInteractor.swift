import Foundation
import ViaPlayAPI
import SharedModel


public typealias GetSectionInteractor = (Links.Section) async throws -> Section



public func makeGetSectionInteractor(
    withLocal localPersistence: PersistenceController,
    api: ViaPlayAPIClient
) -> GetSectionInteractor {
    return { section in
        if let remoteSection = try? await fetch(from: api, andUpdateAt: localPersistence, section) {
            return remoteSection
        }

        let predicate = NSPredicate(format: "id == %@", section.id)
        let fetchRequest = LocalSection.fetchRequest()
        fetchRequest.predicate = predicate
        guard let localSection = ((try? localPersistence.container.viewContext.fetch(fetchRequest)) ?? []).first else {
            return try await fetch(from: api, andUpdateAt: localPersistence, section)
        }

        return Section(
            type: localSection.type,
            pageType: localSection.pageType,
            sectionId: localSection.id,
            title: localSection.title,
            sectionDescription: localSection.sectionDescription,
            links: nil
        )
    }
}

private func fetch(
    from api: ViaPlayAPIClient,
    andUpdateAt localPersistence: PersistenceController,
    _ section: Links.Section
) async throws -> Section {
    let remoteSection = try await api.loadSection(for: section)
    LocalSection.create(
        with: localPersistence.container.viewContext,
        fromRemote: remoteSection
    )
    return remoteSection
}
