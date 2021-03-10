import ComposableArchitecture
import FavoritesFeature
import Models
import RecentsFeature
import SwiftUI
import WordDefinitionFeature

public struct HomeView: View {
    @ObservedObject var store: Store<HomeState, HomeAction>

    public init(store: Store<HomeState, HomeAction>) {
        self.store = store
    }

    @State private var searchQuery: String = ""

    private var pickerBinding: Binding<Language> {
        Binding<Language>(
            get: { self.store.value.language },
            set: { language in self.store.send(.didTapLanguage(language: language)) }
        )
    }

    public var body: some View {
        NavigationView {
            VStack {
                Picker("Language picker", selection: pickerBinding) {
                    ForEach(Language.allCases, id: \.self) { element in
                        Text(element.rawValue)
                    }
                }.pickerStyle(MenuPickerStyle())
                    .background(Color.gray)
                TextField("Search", text: $searchQuery)
                    .background(Color.gray)
                    .onChange(of: searchQuery) { query in
                        store.send(.didTapSearch(query: query))
                    }
                NavigationLink(
                    "today's word".localizedCapitalized,
                    destination: WordDefinitionView()
                )
                NavigationLink("Recently viewed".localizedCapitalized, destination: RecentsView())
                //                        NavigationLink("Favorites".localizedCapitalized, destination: FavoritesView(store: store))
            }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
    }
}
