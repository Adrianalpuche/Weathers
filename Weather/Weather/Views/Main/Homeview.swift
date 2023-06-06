//
//  Homeview.swift
//  Weather
//
//  Created by Adrián Alpuche on 15/05/23.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat,CaseIterable{
    case top = 0.83 // 702/844
    case middle = 0.385 //325/844
}

struct Homeview: View{
    private var attributeSting:AttributedString{
        var string = AttributedString("19°" + (hasDragged ? " |":  "\n") + "Mostly clear")
        if let temp = string.range(of: "19°"){
            string[temp].font = .system(size: (96 - (BottomSheetTranslationProrated * (96-20))),weight: hasDragged ? .semibold: .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        if let pipe = string.range(of: "|"){
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(BottomSheetTranslationProrated)
        }
        if let weather = string.range(of: "Mostly clear"){
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    var BottomSheetTranslationProrated: CGFloat{
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    @State var hasDragged: Bool = false
    var body: some View{
        NavigationView {
            GeometryReader { geometry in let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
            let imageOffset = screenHeight + 36
                ZStack{
                    // Este es el color del background
                    Color.background.ignoresSafeArea()
                    
                    Image("Background").resizable()
                        .ignoresSafeArea()
                        .offset(y: -BottomSheetTranslationProrated * imageOffset)
                    
                    Image("House").frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top,257)
                        .offset(y: -BottomSheetTranslationProrated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - BottomSheetTranslationProrated)){
                        Text("Montreal").font(.largeTitle)
                        
                        VStack{
                            //Text("19°" + "\n" + "Mostly clear" )
                            //  Text("19°").font(.system(size: 96,weight: .thin)).foregroundColor(.primary)
                            // +
                            //Text("\n")
                            //+
                            //Text("Mostly Clear")
                            //.font(.title3.weight(.semibold)).foregroundColor(.secondary)
                            //
                            Text(attributeSting)
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - BottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }.padding(.top,51)
                        .offset(y: -BottomSheetTranslationProrated * 46)
                    
                    BottomSheetView(position: $bottomSheetPosition){
                       // Text(BottomSheetTranslationProrated.formatted())
                      
                        
                    }content: {
                        ForecastView(bottomSheetTranslationProrated: BottomSheetTranslationProrated)
                    }
                    .onBottomSheetDrag{
                        tranlation in bottomSheetTranslation = tranlation / screenHeight
                        
                        withAnimation(.easeInOut){
                            if bottomSheetPosition ==  BottomSheetPosition.top{
                                 hasDragged = true
                            }else{
                                 hasDragged = false
                            }
                        }
                     
                    }
                    
                    Tadbar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: BottomSheetTranslationProrated * 115)
                }
            }
            .navigationBarHidden(true)
        }
    }
}



struct Homeview_Previews: PreviewProvider {
    static var previews: some View {
        Homeview()
            .preferredColorScheme(.dark)
      
    }
}


