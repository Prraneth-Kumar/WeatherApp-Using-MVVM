//
//  API.swift
//  WeatherApp Using MVVM
//
//  Created by Prraneth Kumar A R on 12/10/22.
//

import Foundation
//import UIKit
import Alamofire
import SwiftyJSON

struct iden: Identifiable{
    var id = UUID()
    var name: String
    var clouds: Int
    var humidity : Int
    var speed : Double
    var pressure: Int
    var temp: Double
    var image: String
//    var ErrorMessage: String
}

//
//extension ContentView {
//
//    @MainActor
//

class ViewModel: ObservableObject {
    @Published var cityName: String
    @Published var storeInArray = [iden]()
    
    @Published var errorAlert = false
    @Published var message = ""
 
    init(){
        let HomePage = ContentView()
        self.cityName = HomePage.cityName
        if self.cityName.isEmpty{
            self.cityName = "Washington"
        }
    }
    
    func value1() {
        let urlLogin = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=61b92c28724370901caf148b6af61b77&units=metric"
        Alamofire.request(urlLogin, method:.get).responseJSON{
            [self]
            response in
            // print(response)
            let json = try! JSON(data: response.data!)
            print(json)
            
            guard json["cod"] != "404" else{
                errorAlert = true
                message = json["message"].string!
                //weather()
                return
            }
            let name = json["name"].string!
            let clouds = json["clouds"]["all"].int!
            let humidity = json["main"]["humidity"].int!
            let speed = json["wind"]["speed"].doubleValue
            let pressure = json["main"]["pressure"].int!
            let temp = json["main"]["temp"].doubleValue
            let image = json["weather"][0]["icon"].string!
            storeInArray.append(iden(name: name, clouds: clouds, humidity: humidity, speed: speed, pressure: pressure, temp: temp, image: image))
            
            //storeInArray.append(name)
            // print(storeInArray,"IAMLegend")
        }
    }
    // }
    
}
