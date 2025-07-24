import SwiftUI

@available(iOS 15.0, *)
public struct CallingCodesListView: View {
    private let onSelect: (CountryCallingCode_Data) -> Void
    @State private var countries: [CountryCallingCode_Data] = []
    @State private var searchText: String = ""

    public init(onSelect: @escaping (CountryCallingCode_Data) -> Void) {
        self.onSelect = onSelect
    }

    public var body: some View {
        List(filteredCountries) { country in
            Button(action: {
                onSelect(country)
            }) {
                HStack {
                    Text(country.flag ?? "")
                    Text(country.name ?? "")
                    Spacer()
                    Text(country.dialCode ?? "")
                }
            }
        }
        .searchable(text: $searchText)
        .onAppear(perform: loadData)
        .navigationBarTitle("Countries", displayMode: .inline)
    }

    private var filteredCountries: [CountryCallingCode_Data] {
        if searchText.isEmpty { return countries }
        return countries.filter { country in
            (country.name?.lowercased().contains(searchText.lowercased()) ?? false) ||
            (country.dialCode?.lowercased().contains(searchText.lowercased()) ?? false)
        }
    }

    private func loadData() {
        ContryJsonData.loadData { model in
            countries = model.countries ?? []
        }
    }
}
