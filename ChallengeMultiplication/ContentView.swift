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
            
            
            print("Incorrect!")
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
                
                ZStack {
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
                        
                    SelectionView(
                            numarAles: $numarAles,
                            numarIntrebari: $numarIntrebari,
                            ultimulApasat: $ultimulApasat,
                            ultimulApasatIntrebari: $ultimulApasatIntrebari,
                            startApasat: $startApasat,
                            pulse: $pulse,
                            hasStarted: $hasStarted,
                            intrebari: $intrebari,
                            numereIntrebari: numereIntrebari,
                            onStart: {
                                generareListaElemente(numarAles: numarAles ?? 0, numarIntrebari: numarIntrebari ?? 0)
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
                            }
                    )
                    .id(1)
                    
                    
                }.transition(.move(edge: .leading))
                
            } else {
                ZStack {
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
                    GameView(numarIntrebare: $numarIntrebare, numarIntrebari: $numarIntrebari, intrebari: $intrebari, raspunsText: $raspunsText, score: $score, hasStarted: $hasStarted, numarAles: $numarAles, valoareEfect: $valoareEfect, valoareEfect2: $valoareEfect2, verificareRaspuns: verificareRaspuns(raspunsInt:), reset: reset)
                        .id(2)
                        
                       
                }.transition(.move(edge: .trailing))
                
                
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
                        Text("Wrong! 😾")
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
                        Text("Done! 🐈")
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
                        Text("YOU CANNOT HAVE AN EMPTY ANSWER!")
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
