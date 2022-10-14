//
//  ContentView.swift
//  WeatherApp Using MVVM
//
//  Created by Prraneth Kumar A R on 12/10/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    
    @State var cityName = ""
    
    @StateObject var viewMode = ViewModel()
    
    let  colorTitle = RadialGradient(gradient: Gradient(colors: [.gray, .gray, .orange]), center: .center, startRadius: 430, endRadius: 30)
    let color1 = LinearGradient(gradient: Gradient(colors: [.gray, .blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .orange]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Text("Enter City Name For Weather")
                    TextField("Enter City or State", text: $cityName)
                        .multilineTextAlignment(.center)
                    Button("Search"){
                        viewMode.cityName = cityName
                        viewMode.value1()
                    }.font(.system(size: 20, weight: .semibold))
                    List($viewMode.storeInArray) {$data in
                        Text("\(data.name)").fontWeight(.bold).multilineTextAlignment(.center)
                           .listRowBackground(colorTitle)
                            .frame(maxWidth: .infinity, alignment: .center)
                        HStack{
                            VStack{
                                Image("\(data.image)")
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)
                            }
                            VStack{
                                Text("Temp: \(data.temp, specifier: "%.2f")°C").fontWeight(.bold)
                                Text("Clouds: \(data.clouds)%").fontWeight(.bold)
                                Text("Humidity: \(data.humidity)%").fontWeight(.bold)
                                Text("Speed: \(data.speed, specifier: "%.2f")m/s").fontWeight(.bold)
                                Text("Pressure: \(data.pressure)hpa").fontWeight(.bold)
                            }
                        }.listRowBackground(color1)
                    }.listStyle(.grouped)
                       // .background(colorTitle)
                        .scrollContentBackground(.hidden)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
