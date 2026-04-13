//
//  ContentView.swift
//  ChallengeMultiplication
//
//  Created by Valentin Constantin on 12/04/2026.
//

import SwiftUI

struct Intrebare {
    var numar1: Int
    var numar2: Int
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

struct WoolTexture: View {
    var body: some View {
        Canvas { context, size in
            // Generăm puncte aleatorii pe tot ecranul
            for _ in 0..<20000 {
                let x = CGFloat.random(in: 0...size.width)
                let y = CGFloat.random(in: 0...size.height)
                let rect = CGRect(x: x, y: y, width: 1.5, height: 1.5)
                
                // Folosim o culoare albă sau neagră cu opacitate foarte mică
                context.fill(Path(rect), with: .color(Color.white.opacity(0.05)))
            }
        }
        .blendMode(.overlay) // Acest mod face textura să se combine natural cu fundalul
    }
}

struct ContentView: View {
    func generareListaElemente(numarAles: Int, numarIntrebari: Int) {
        for _ in 0..<numarIntrebari {
            intrebari.append(Intrebare(numar1: numarAles, numar2: Int.random(in: 1...10)))
            
            
        }
    }
    @State private var numarIntrebari: Int? = nil
    @FocusState private var eFocusat: Bool
    @State private var numarAles: Int? = nil
    @State private var ecranInitial: Bool = true
    @State private var raspunsCorect: Int? = nil
    @State private var intrebari: [Intrebare] = []
    @State private var hasStarted: Bool = false
    @State private var numarIntrebare = 0
    @State private var score = 0
    @State private var raspunsText: String = ""
    @State private var arataMesaj = false
    @State private var arataMesajGresit = false
    @State private var arataFinish = false
    @State private var arataEroare = false
    @State private var startApasat = false
    @State private var isSelected = false
    @State private var isPressed = false
    @State private var valoareEfect = 1.0
    @State private var ultimulApasat: Int? = nil
    @State private var ultimulApasatIntrebari: Int? = nil
    @State private var valoareEfect2 = 1.0
    @State private var pulse = false
    let numereIntrebari = [5, 10, 20, 50]
    func verificareRaspuns(raspunsInt: Int) {
        if numarIntrebare == (numarIntrebari ?? 0) - 2 {
            withAnimation(.snappy){
                arataFinish = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.snappy){
                    arataFinish = false
                    reset()
                    hasStarted.toggle()
                }
                
                
            }
            
        }
        
        
        
        
        else if raspunsInt == intrebari[numarIntrebare].numar1 * intrebari[numarIntrebare].numar2 {
            withAnimation {
                score += 1
            }
           
            
            // Animăm apariția
            withAnimation(.bouncy) {
                arataMesaj = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Animăm dispariția
                withAnimation(.bouncy) {
                    arataMesaj = false
                }
            }
            numarIntrebare += 1
        
            
            
        }
        else if raspunsText == "" {
            withAnimation(.bouncy) {
                arataEroare = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Animăm dispariția
                withAnimation(.bouncy) {
                    arataEroare = false
                }
            }
            
        }else {
            withAnimation(.bouncy){
                arataMesajGresit = true
            }
            
           
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.spring){
                        arataMesajGresit = false
                    }
                    
                }
            
            
            print("Incorrect")
            numarIntrebare += 1
        }
        raspunsText = ""
        
        
        
    }
    func reset() {
        numarAles = nil
        score = 0
        intrebari.removeAll()
        numarIntrebare = 0
        numarIntrebari = nil
    }
    
   
    
    
    
    var body: some View {
        
        
        
        
        ZStack {
            //container fundal verde
          
            
            if hasStarted == false {
                RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "76c945"), // Verdele deschis din centru
                                    Color(hex: "4a932c")  // Verdele mai închis de la margini
                                ]),
                                center: .center,       // Începe din mijloc
                                startRadius: 20,       // Raza unde începe prima culoare
                                endRadius: 500         // Raza unde se termină a doua culoare
                            )
                .ignoresSafeArea()
                WoolTexture()
                                .opacity(15)
                    
                VStack {
                    
                    //container mare
                    Spacer()
                    VStack(spacing: 30) {
                        //container selectare tabla inmultirii
                        Text("Tabla inmultirii").frame(maxWidth: .infinity, alignment: .leading).font(.system(.title)).foregroundStyle(.white).fontWeight(.bold)
                        VStack {
                            HStack(spacing: 15) {
                                ForEach(1..<6) { numar in
                                    Button {
                                        numarAles = numarAles == numar ? nil : numar
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                                ultimulApasat = numar
                                            }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            ultimulApasat = nil}
                                    } label: {
                                        Text("\(numar)")
                                            
                                            .foregroundStyle(numarAles == numar ? .white : .green)
                                            .fontWeight(.bold)
                                            .font(.system(size: 30))
                                            .frame(width: 50, height: 50)
                                            
                                            
                                            .background(numarAles == numar ? .orange : .white)
                                            
                                            .clipShape(.rect(cornerRadius: 15))
                                            .scaleEffect(ultimulApasat == numar ? 1.2 : 1.0)
                                                    .animation(.spring(response: 0.4, dampingFraction: 0.4), value: ultimulApasat)
                                        
                                    }
                                    
                                }
                            }
                            HStack(spacing: 15) {
                                ForEach(6..<11) { numar in
                                    
                                    Button {
                                        numarAles = numarAles == numar ? nil : numar
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                            ultimulApasat = numar
                                        }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        ultimulApasat = nil}
                                        
                                    } label: {
                                        Text("\(numar)")
                                            .foregroundStyle(numarAles == numar ? .white : .green)
                                            .fontWeight(.bold)
                                            .font(.system(size: 30))
                                            .frame(width: 50, height: 50)
                                            
                                            
                                            .background(numarAles == numar ? .orange : .white)
                                            
                                            .clipShape(.rect(cornerRadius: 15))
                                            .scaleEffect(ultimulApasat == numar ? 1.2 : 1.0)
                                                    .animation(.spring(response: 0.3, dampingFraction: 0.4), value: ultimulApasat)

                                    }
                                    
                                }
                            }
                            
                        }
                    }.padding()
                    VStack(spacing: 30) {
                        //container selectare tabla inmultirii
                        Text("Numar intrebari").frame(maxWidth: .infinity, alignment: .leading).font(.system(.title)).foregroundStyle(.white).fontWeight(.bold)
                        VStack {
                            HStack(spacing: 20) {
                                ForEach(numereIntrebari.indices, id: \.self) { i in
                                    
                                    Button {
                                        numarIntrebari = numereIntrebari[i]+1 == numarIntrebari ? nil : numereIntrebari[i]+1
                                           withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                               ultimulApasatIntrebari = numereIntrebari[i]
                                           }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            ultimulApasatIntrebari = nil }
                                    } label: {
                                        Text("\(numereIntrebari[i])")
                                            .foregroundStyle(numarIntrebari == numereIntrebari[i] + 1 ? .white : .green)
                                            .fontWeight(.bold)
                                            .font(.system(size: 30))
                                            .frame(width: 65, height: 50)
                                            .background(numarIntrebari == numereIntrebari[i] + 1 ? .orange : .white)
                                            .clipShape(.rect(cornerRadius: 15))
                                            .scaleEffect(ultimulApasatIntrebari == numereIntrebari[i] ? 1.3 : 1.0)
                                                    .animation(.spring(response: 0.3, dampingFraction: 0.4), value: ultimulApasatIntrebari)
                                    }
                                    
                                }
                            }
                            
                        }
                    }.padding()
                   Spacer()
                        .frame(height: 30)
                    Image("start")
                        .resizable()
                        .frame(width: 230, height: 200)
                        .offset(x: -20)
                        .shadow(radius: 5)
                        .scaleEffect(pulse ? 1.02 : 0.99)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: pulse)
                            .onAppear {
                                pulse = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    pulse = true
                                }
                            }
                    Button {
                        generareListaElemente(numarAles: numarAles ?? 0, numarIntrebari: numarIntrebari ?? 0)
                        for intrebare in intrebari {
                                print("\(intrebare.numar1) x \(intrebare.numar2)")
                            }
                       
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring) {
                                    hasStarted.toggle()
                                }
                                
                            }
                            
                           
                        
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                startApasat = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    startApasat = false
                                }
                            }
                        
                    } label: {
                        Text("Start")
                            .foregroundStyle(.green)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .frame(width: 250, height: 130)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 55))
                            .padding()
                            .shadow(color: .orange.opacity(0.5), radius: 25)
                            .scaleEffect(startApasat ? 0.92 : 1.0)
                            .scaleEffect(numarAles == nil || numarIntrebari == nil ? 0.99 : 1.0)
                            
                        
                            
                            
                           
                            
                    }.disabled(numarAles == nil || numarIntrebari == nil)
                        .opacity(numarAles == nil || numarIntrebari == nil ? 0.5 : 1.0)
                      
                       
          
                
                        
                
                }.padding()
                    .transition(.slide)
                
            } else {
                RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.7, blue: 0.2), // Portocaliu deschis (Centru)
                                    Color(red: 0.8, green: 0.3, blue: 0.0)  // Portocaliu închis (Margini)
                                ]),
                                center: .center,
                                startRadius: 20,
                                endRadius: 500
                            )
                    .ignoresSafeArea()
                WoolTexture()
                                .opacity(15)
                VStack {
                    
                    
                    //container mare
                    Spacer()
                    
                    VStack(spacing: 30) {
                        //container intrebare
                        Text("Intrebarea \(numarIntrebare+1)/\((numarIntrebari ?? 0) - 1)").frame(maxWidth: .infinity, alignment: .center).font(.system(size: 35)).foregroundStyle(.white).fontWeight(.bold)
                        VStack {
                            
                          
                            
                            HStack(spacing: 15) {
                                Button {
                                    //actiune
                                } label: {
                                    
                                    Text("\(intrebari[numarIntrebare].numar1)")
                                        .foregroundStyle(.orange)
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                        .frame(width: 80, height: 80)
                                        .background(.white)
                                        .clipShape(.rect(cornerRadius: 15))
                                }
                                Text("x").font(.system(size: 25)).fontWeight(.bold).foregroundStyle(.white)
                                Button {
                                    //actiune
                                } label: {
                                    Text("\(intrebari[numarIntrebare].numar2)")
                                        .foregroundStyle(.orange)
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                        .frame(width: 80, height: 80)
                                        .background(.white)
                                        .clipShape(.rect(cornerRadius: 15))
                                }
                            }
                            
                            
                            
                        }
                    }.padding()
                    Spacer().frame(height: 80)
                    
                    VStack(spacing: 30) {
                        //container raspuns
                        HStack(spacing: 0) {
                            Text("Raspuns:").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 30)).foregroundStyle(.white).fontWeight(.bold).padding()
                            TextField("", text: $raspunsText)
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(.orange)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 15))
                                .frame(width: 150)
                                .keyboardType(.numberPad)
                                .onSubmit {
                                       let raspunsInt = Int(raspunsText) ?? 0
                                    
                                        verificareRaspuns(raspunsInt: raspunsInt)
                                    
                                       
                                   }
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Verifica") {
                                            let raspunsInt = Int(raspunsText) ?? 0
                                            verificareRaspuns(raspunsInt: raspunsInt)
                                            eFocusat = false
                                        }
                                    }
                                }
                                .focused($eFocusat)
                        }
                      
                        
                      
                    }.padding()
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        
                        VStack(spacing: 3) {
                            Text("Scorul este").foregroundStyle(.secondary)
                            Text("\(score)")
                                .font(.system(size: 25))
                                .contentTransition(.numericText())
                                .scaleEffect(score > 0 ? 1.3 : 1.0)
                                    .animation(.bouncy, value: score)
                                
                        }.foregroundStyle(.white)
                            .frame(width: 110, height: 80)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .background(Color(hex: "245c47"))
                            .clipShape(.rect(cornerRadius: 15))
                            .shadow(radius: 4)
                            .scaleEffect(score > 0 ? 1.0 : 0.8)
                                .animation(.bouncy, value: score)
                        Image("calcul")
                            .resizable()
                            .frame(width: 230, height: 200)
                            .offset(x: +20)
                            .padding()
                            .shadow(radius: 5)
                            
                        
                    }
                   
                    
                    HStack {
                        Button {
                        
                            withAnimation {
                                hasStarted.toggle()
                            }
                            
                            numarAles = nil
                            numarIntrebari = nil
                            intrebari.removeAll()
                            reset()
                            
                        } label: {
                            Text("Stop")
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .frame(width: 160, height: 80)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 55))
                                .opacity(0.9)
                                .padding()
                                .shadow(color: .green.opacity(0.7), radius: 35)
                                .scaleEffect(valoareEfect)
                        }
                        Button {
                            let raspunsInt = Int(raspunsText) ?? 0
                            verificareRaspuns(raspunsInt: raspunsInt)
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                                withAnimation(.bouncy(duration: 0.35)) {
                                        valoareEfect2 -= 0.1
                                        
                                }
                                
                            }
                            
                            
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                
                                withAnimation(.spring) {
                                        valoareEfect2 = 1
                                        
                                }
                                
                            }
                            
                            
                        } label: {
                            Text("Verifica")
                                .foregroundStyle(Color(hex: "245c4c"))
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .frame(width: 160, height: 80)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 55))
                                .padding()
                                .opacity(0.9)
                                .shadow(color: .green.opacity(0.7), radius: 35)
                                .scaleEffect(valoareEfect2)
                        }
                    }
                  
                        
                
                }.padding()
                    .transition(.slide)
                   
                
            }
            if arataMesaj == true {
                
               
                    // notificarea ta custom deasupra
                    VStack {
                        Image("succes")
                            .resizable()
                            .frame(width: 200, height: 200)
                           
                        Text("BRAVOO! 🎉")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding()
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 15))
                            .foregroundStyle(.black)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.green.opacity(0.4))
                    .transition(.opacity)
                    .zIndex(1)
                
                    .ignoresSafeArea()
                }
            if arataMesajGresit == true {
                
               
                    // notificarea ta custom deasupra
                    VStack {
                        Image("gresit")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("Gresit! 😾")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding()
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 15))
                            .foregroundStyle(.black)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.4))
                    .zIndex(1)
                    .ignoresSafeArea()
                }
            if arataFinish == true {
                
               
                    // notificarea ta custom deasupra
                    VStack {
                        Image("finish")
                            .resizable()
                            .frame(width: 300, height: 300)
                        Text("Gata! 🐈")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding()
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 15))
                            .foregroundStyle(.black)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.purple.opacity(0.5))
                    .ignoresSafeArea()
                    
                }
            if arataEroare == true {
                
               
                    // notificarea ta custom deasupra
                    VStack {
                        Image("gol")
                            .resizable()
                            .frame(width: 300, height: 300)
                        Text("NU POTI AVEA RASPUNS GOL!")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding()
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 15))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red.opacity(0.7))
                    .zIndex(1)
                    .ignoresSafeArea()
                
                }
            
            
            
            
        }
        .preferredColorScheme(.light)
        .ignoresSafeArea()
         
        
    }
    
}

#Preview {
    ContentView()
}
