//
//  Api.swift
//  Weather
//
//  Created by Adrián Alpuche on 30/05/23.
//

import Foundation
import Alamofire


let citiesCanada = [
  "Toronto",
  "Montreal",
  "Vancouver",
  "Calgary",
  "Edmonton",
  "Ottawa",
  "Quebec City",
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
     "46.813878,-71.207981",
     "49.895077,-97.138451",
     "44.648618,-63.585948",
     "48.428421,-123.365644"
]



let openKey = "970fea80c462414fab9f759fe436138c"
let tomorrowKey = "TsKgAgxVl30PyZrZi1zCQF4rehoPXj4o"

func obtenerCiudad() {
    for city in citiesCanada {
        let url = "https://api.opencagedata.com/geocode/v1/json?q=\(city)&key=\(openKey)"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let firstResult = results.first,
                   let formatted = firstResult["formatted"] as? String {
                    print(formatted)
                } else {
                    print("Error en la respuesta JSON para la ciudad \(city)")
                }
            case .failure(let error):
                print("Error al realizar la solicitud para la ciudad \(city): \(error)")
            }
        }
    }
}


func obtenerTemperaturas() {
    for (index, city) in citiesCanada.enumerated() {
        let coordenadas = citiesCanadaCoordenadas[index]
        let url = "https://api.tomorrow.io/v4/timelines?location=\(coordenadas)&fields=temperature&timesteps=1h&units=metric&apikey=\(tomorrowKey)"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let data = json["data"] as? [String: Any],
                   let timelines = data["timelines"] as? [[String: Any]],
                   let firstTimeline = timelines.first,
                   let intervals = firstTimeline["intervals"] as? [[String: Any]],
                   let firstInterval = intervals.first,
                   let values = firstInterval["values"] as? [String: Any],
                   let temperature = values["temperature"] as? Double {
                    print("Temperatura en \(city): \(temperature)°C")
                } else {
                    print("Error en la respuesta JSON para la ciudad \(city)")
                }
            case .failure(let error):
                print("Error al realizar la solicitud para la ciudad \(city): \(error)")
            }
        }
    }
}














    
  
          
