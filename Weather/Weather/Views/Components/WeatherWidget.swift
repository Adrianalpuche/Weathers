import SwiftUI
import Foundation
import Alamofire

struct WeatherWidget: View {
    @State private var temperature: Double = 0
    @State private var cityName: String = ""
    
    let city: String
    let coordinates: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 174)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(temperature)°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(cityName)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 0) {
                    Image(systemName: "sun.max")
                        .padding(.trailing, 4)
                    
                    Text("Sunny")
                        .font(.footnote)
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184, alignment: .bottom)
        .onAppear {
            obtenerTemperaturas()
            obtenerCiudad()
        }
    }
    
    let openKey = "970fea80c462414fab9f759fe436138c"
    let tomorrowKey = "9f2ee93b17d97359edad2b954c8accbd"
    
    func obtenerTemperaturas() {
        let coordenadasArray = coordinates.components(separatedBy: ",")
        
        if coordenadasArray.count == 2, let lat = coordenadasArray.first, let lon = coordenadasArray.last {
            let apiKey = "TU_API_KEY"
            let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(tomorrowKey)"
            
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let main = json["main"] as? [String: Any],
                       let temperature = main["temp"] as? Double {
                        DispatchQueue.main.async {
                            self.temperature = temperature
                        }
                    } else {
                        print("Error en la respuesta JSON para la ciudad \(self.city)")
                    }
                    
                case .failure(let error):
                    print("Error al realizar la solicitud para la ciudad \(self.city): \(error)")
                }
            }
        } else {
            print("Error en las coordenadas para la ciudad \(self.city)")
        }
    }
    
    func obtenerCiudad() {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://api.opencagedata.com/geocode/v1/json?q=\(encodedCity)&key=\(openKey)"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let firstResult = results.first,
                   let formatted = firstResult["formatted"] as? String {
                    DispatchQueue.main.async {
                        self.cityName = formatted
                    }
                } else {
                    print("Error en la respuesta JSON para la ciudad \(self.city)")
                }
            case .failure(let error):
                print("Error al realizar la solicitud para la ciudad \(self.city): \(error)")
            }
        }
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(citiesCanada.indices, id: \.self) { index in
            WeatherWidget(city: citiesCanada[index], coordinates: citiesCanadaCoordenadas[index])
        }            .preferredColorScheme(.dark)
    }
}
