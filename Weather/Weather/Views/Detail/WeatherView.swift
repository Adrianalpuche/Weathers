// WeatherView.swift
import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    
    let citiesCanada = [
        "Toronto",
        "Montreal",
        "Vancouver",
        "Calgary",
        "Edmonton",
        "Ottawa",
        "Winnipeg",
        "Halifax",
        "Victoria"
    ]
    
    let citiesCanadaCoordenadas = [
        "43.651070,-79.347015",
        "45.501690,-73.567253",
        "49.282729,-123.120738",
        "51.044270,-114.062019",
        "53.544389,-113.490927",
        "45.421532,-75.699547",
        "49.895077,-97.138451",
        "44.648618,-63.585948",
        "48.428421,-123.365644"
    ]
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return citiesCanada
        } else {
            return citiesCanada.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults, id: \.self) { city in
                        let index = citiesCanada.firstIndex(of: city)!
                        WeatherWidget(city: city, coordinates: citiesCanadaCoordenadas[index])
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
