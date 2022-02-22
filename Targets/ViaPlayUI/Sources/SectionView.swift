import SwiftUI
import SharedModel
import ViaPlayKit

public struct SectionView: View {
    private let section: Links.Section
    @State private(set) var loadableContent: Loadable<SharedModel.Section>
    @Environment(\.injected) private var injected: DIContainer
    
    private var getSectionInteractor: GetSectionInteractor {
        self.injected.interactors.getSectionInteractor
    }
    
    public init(
        section: Links.Section,
        content: Loadable<SharedModel.Section> = .notRequested
    ) {
        self.section = section
        self.loadableContent = content
    }
    
    public var body: some View {
        
        List {
            Section() {
                Text("Section name: \(section.name ?? "")")
            }
            self.contentView
        }
        .navigationBarTitle(section.title ?? "")
        .animation(.easeOut, value: 0.3)
        
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

private extension SectionView {
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

private extension SectionView {
    func reload() async {
        do {
            self.loadableContent = .isLoading
            let content = try await self.getSectionInteractor(self.section)
            self.loadableContent = .loaded(content)
        } catch {
            self.loadableContent = .failed(error)
        }
    }
}

// MARK: - Displaying Content

private extension SectionView {
    func loadedView(
        _ section: SharedModel.Section
    ) -> some View {
        Group {
            Section("Section description") {
                Text(section.sectionDescription ?? "")
            }
            
            if let sections = section.links?.sections {
                Section("Linked Sections") {
                    links(sections)
                }
            }
        }
    }
    
    func links(
        _ sections: [Links.Section]
    ) -> some View {
        ForEach(sections) { section in
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
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(
            section: Content.mock.links!.sections!.first!,
            content: .loaded(.mock)
        ).inject(.stub)
        
        SectionView(
            section: Content.mock.links!.sections!.first!,
            content: .isLoading
        ).inject(.stub)
        
        SectionView(
            section: Content.mock.links!.sections!.first!,
            content: .failed(URLError(.badURL))
        ).inject(.stub)
    }
}
#endif
