import SwiftUI
import Combine
import CoreData
import ViaPlayAPI

// MARK: - DIContainer

public struct DIContainer: EnvironmentKey {
    public let interactors: Interactors
    public let persistence: PersistenceController
    public let api: ViaPlayAPIClient
    
    public init(
        interactors: Interactors,
        api: ViaPlayAPIClient = .viaPlayProd(),
        persistence: PersistenceController = .shared
    ) {
        self.interactors = interactors
        self.persistence = persistence
        self.api = api
    }

    public static var defaultValue: Self { Self.default }

    private static let `default` = Self(interactors: .stub)
}

public extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(interactors: .stub)
    }
}
#endif

// MARK: - Injection in the view hierarchy

public extension View {
    
    func inject(_ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(interactors: interactors)
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
