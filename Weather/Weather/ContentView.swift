//
//  ContentView.swift
//  Weather
//
//  Created by Adrián Alpuche on 04/05/23.
//

import SwiftUI
import Lottie
import SPAlert

struct ContentView: View {
    var body: some View {
        NavigationView{
            Login()

        }
        .navigationBarHidden(true)
    }
}

struct Login: View{
    @State private var isLoggedIn = false
    @State var correoPre = "Clima@gmail.com"
    @State var contraseñaPre = "climaso09"
    @State var show = false
    @State var mostrar = false
    @State var showAlert = false
    @State var showAlertContraseña = false
    @State var showAlertCorreo = false
    @State var num = ""
    @State var correo = ""
    @State var contraseña = ""
    @State var contrasenaCorrecta = false
    let redIcon = UIImage(systemName: "xmark.seal.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    let redIconCon = UIImage(systemName: "xmark.seal.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    let triangle = UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    var body: some View{
        VStack{
            ZStack{
                Color.background.ignoresSafeArea()
                VStack{
                    AnimatiedView(show: $show).frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)    .scaleEffect(0.5)
                        .padding(.bottom,-35)
                    
                    VStack{
                        HStack{
                            VStack(alignment:.leading, spacing: 10, content: {
                                
                                Text("Iniciar sesión").font(.title)
                                    .fontWeight(.bold).foregroundColor(.black)
                                
                                
                                Text("Inserte sus datos").foregroundColor(.gray)
                            })
                            Spacer(minLength: 15)
                        }
                        
                        VStack{
                            
                            HStack(spacing: 10){
                                Text("Correo").foregroundColor(.black)
                                
                                Rectangle().fill(Color("Fondo")).frame(width:1,height: 18)
                                
                                ZStack(alignment: .leading){
                                    if correo.isEmpty{
                                        Text(verbatim:"example@example.com").font(.caption).foregroundColor(.gray)
                                    }
                                    TextField("", text:$correo).foregroundColor(.gray)
                                }
                            }
                            Divider().background(Color("Fondo"))
                        }
                        VStack{
                            HStack(spacing: 10){
                                Text("Contraseña").foregroundColor(.black)
                                
                                Rectangle().fill(Color("Fondo")).frame(width:1,height: 18)
                                
                                ZStack(alignment: .leading){
                                    if contraseña.isEmpty{
                                        Text(verbatim: "Escribe tu contraseña").font(.caption).foregroundColor(.gray)
                                    }
                                    if mostrar{
                                        TextField("", text:$contraseña).foregroundColor(.black)
                                    }
                                    else{
                                        SecureField("",text:$contraseña).foregroundColor(.gray)
                                    }
                                    HStack{
                                        Spacer()
                                        Button(action: {
                                            mostrar.toggle()
                                        }) {
                                            Image(systemName: self.mostrar ? "eye" : "eye.slash").accentColor(.gray)}}
                                }
                            }
                            Divider().background(Color("Fondo"))
                            Text("¿Olvidaste tu contraseña?").font(.footnote).frame(width: 340,alignment: .trailing).foregroundColor(Color.black)
                        }
                        .padding(.vertical,2)
                        
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                            EmptyView()
                        }
                        .hidden()

                    
                        Button(action: {
                            if contraseña.isEmpty && correo.isEmpty {
                                showAlert = true
                            } else if contraseña == contraseñaPre && correo == correoPre {
                                  isLoggedIn = true
                              }
                            else if contraseña != contraseñaPre && correo == correoPre{
                                showAlertContraseña = true
                            }
                            else if correo != correoPre && contraseña == contraseñaPre{
                                showAlertCorreo = true
                            }
                        }) {
                            Text("Iniciar sesión")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(width: UIScreen.main.bounds.width / 1.2)
                                .background(Color("Fondo"))
                                .clipShape(Capsule())
                        }.SPAlert(
                            isPresent: $showAlert,
                            title: "Completa los campos",
                            message: "Por favor de llenar los campos que faltan",
                            duration: 2.0,
                            dismissOnTap: false,
                            preset: .custom(triangle!),
                            haptic: .success,
                            layout: .init(),
                            completion: {
                                print("Alert is destory")
                            })
                        .SPAlert(
                            isPresent: $showAlertContraseña,
                            title: "Datos erróneos  en la contraseña",
                            message: "La contraseña que se introdujo está mal",
                            duration: 2.0,
                            dismissOnTap: false,
                            preset: .custom(redIconCon!),
                            haptic: .success,
                            layout: .init(),
                            completion: {
                                print("Alert is destory")
                            })
                        .SPAlert(
                            isPresent: $showAlertCorreo,
                            title: "Datos erróneos en el correo ",
                            message: "El correo que se introdujo está  mal",
                            duration: 2.0,
                            dismissOnTap: false,
                            preset: .custom(redIcon!),
                            haptic: .success,
                            completion: {
                                print("Alert is destory")
                            })

                        HStack{
                            Rectangle().fill(Color.black.opacity(0.3)).frame(height: 1)
                            Text("O").foregroundColor(.black)
                            Rectangle().fill(Color.black.opacity(0.3)).frame(height: 1)

                            
                        }.padding(.vertical,2)
                        HStack(spacing:15){
                            Button(action: {}, label: {
                                HStack(spacing: 10){
                                    
                                    Image("Facebook").resizable()
                                        .aspectRatio(contentMode: .fit).frame(width:29 ,height: 29)
                                    
                                    Text("Facebook").fontWeight(.bold)
                                    
                                }.foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(width: UIScreen.main.bounds.width/2.4).background(Color("Facebook"))
                                    .clipShape(Capsule())
                            })
                            Button(action: {}, label: {
                                HStack(spacing: 10){
                                    Image("Google").resizable()
                                        .aspectRatio(contentMode: .fit).frame(width:29 ,height: 29)
                                    
                                    Text("Google").fontWeight(.bold)
                                    
                                }.foregroundColor(.black)
                                    .padding(.vertical,10)
                                    .frame(width: UIScreen.main.bounds.width/2.4).background(Color("Google"))
                                    .clipShape(Capsule())
                            })
                            
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
                    
                    .frame(height: show ? nil:0)
                    .opacity(show ? 1:0)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)

    }
}

struct AnimatiedView: UIViewRepresentable{
    @Binding var show: Bool
    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name:"77075-location-weather-radar",bundle:Bundle.main)
        
        view.play{(status) in
            if status{
                withAnimation(.interactiveSpring(response:0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    show.toggle()
                }
            }
        }
        
        return view
    }
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {

    }
}

