//
//  TabBar.swift
//  Weather
//
//  Created by Adrián Alpuche on 15/05/23.
//

import SwiftUI

struct Tadbar: View{
    var action: () -> Void
    var body: some View{
        ZStack{
            //Arco
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay{
                    Arc()
                        .stroke(Color.tabBarBorder,lineWidth: 0.5)
                }
            
            //Items del tab
            HStack{
                //Expansion del boton
                Button{action()
                }label:{
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                Spacer()
                //Boton de navegacion
                NavigationLink{
                    WeatherView()
                }label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}


struct Tadbar_Previews: PreviewProvider {
    static var previews: some View {
        Tadbar(action: {})
            .preferredColorScheme(.dark)
    }
}

