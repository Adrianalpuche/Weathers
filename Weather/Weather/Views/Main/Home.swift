//
//  Home.swift
//  Weather
//
//  Created by Adrián Alpuche on 07/05/23.
//

import SwiftUI


struct Home: View{
    var body: some View{
        Homeview()
            .navigationBarBackButtonHidden(true)

    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
