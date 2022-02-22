import SwiftUI
import SharedModel
import ViaPlayKit

public struct RootView: View {
    @State private(set) var loadableContent: Loadable<[Links.Section]>
    @Environment(\.injected) private var injected: DIContainer

    private var loadRootPageInteractor: LoadRootPageInteractor {
        self.injected.interactors.loadRootPageInteractor
    }

    public init(
        content: Loadable<[Links.Section]> = .notRequested
    ) {
        self.loadableContent = content
    }
    
    public var body: some View {
        NavigationView {
            self.contentView
                .navigationBarTitle("Sections")
                .animation(.easeOut, value: 0.3)
        }
    }

    private var contentView: AnyView {
        switch loadableContent {
        case .notRequested: return AnyView(notRequestedView)
        case .isLoading: return AnyView(loadingView())
        case let .loaded(content):
            return AnyView(loadedView(content))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
}

// MARK: - Loading Content

private extension RootView {
    var notRequestedView: some View {
        Text("").onAppear {
            Task { await reload() }
        }
    }

    func loadingView() -> some View {
        AnyView(ProgressView().padding())
    }

    func failedView(_ error: Error) -> some View {
        ErrorView(
            error: error,
            retryAction: {
                Task { await self.reload() }
            }
        )
    }
}

// MARK: - Side Effects

private extension RootView {
    func reload() async {
        do {
            self.loadableContent = .isLoading
            let content = try await self.loadRootPageInteractor()
            self.loadableContent = .loaded(content)
        } catch {
            self.loadableContent = .failed(error)
        }
    }
}

// MARK: - Displaying Content

private extension RootView {
    func loadedView(
        _ sections: [Links.Section]
    ) -> some View {
        List(sections) { section in
            cell(for: section)
        }.padding(.bottom, 0)
    }

    private func cell(
        for section: Links.Section
    ) -> some View {
        NavigationLink {
            SectionView(section: section)
        } label: {
            Text(section.title ?? "")
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(content: .loaded(Content.mock.links?.sections ?? []))
            .inject(.stub)

        RootView(content: .isLoading)
            .inject(.stub)

        RootView(content: .failed(URLError(.badURL)))
            .inject(.stub)
    }
}
#endif
