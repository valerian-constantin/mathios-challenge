//
//  GameView.swift
//  ChallengeMultiplication
//
//  Created by Valentin Constantin on 26/04/2026.
//

import SwiftUI

struct GameView: View {
    @FocusState private var eFocusat: Bool
    @Binding var numarIntrebare: Int
    @Binding var numarIntrebari: Int?
    @Binding var intrebari: [Intrebare]
    @Binding var raspunsText: String
    
    @Binding var score: Int
    @Binding var hasStarted: Bool
    @Binding var numarAles: Int?
    @Binding var valoareEfect: Double
    @Binding var valoareEfect2: Double
    
    var verificareRaspuns: (Int) -> Void
    var reset: () -> Void
    var body: some View {
        
        
        VStack {
            
            
            //container mare
            Spacer()
            
            VStack(spacing: 30) {
                //container intrebare
                Text("Question \(numarIntrebare+1)/\((numarIntrebari ?? 0) - 1)").frame(maxWidth: .infinity, alignment: .center).font(.system(size: 35)).foregroundStyle(.white).fontWeight(.bold)
                VStack {
                    
                  
                    if numarIntrebare < intrebari.count {
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
                    
                    
                    
                    
                }
            }.padding()
            Spacer().frame(height: 80)
            
            VStack(spacing: 30) {
                //container raspuns
                HStack(spacing: 0) {
                    Text("Answer:").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 30)).foregroundStyle(.white).fontWeight(.bold).padding()
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
                            
                                verificareRaspuns(raspunsInt)
                            
                               
                           }
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Verify") {
                                    let raspunsInt = Int(raspunsText) ?? 0
                                    verificareRaspuns(raspunsInt)
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
                    Text("Score is").foregroundStyle(.secondary)
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
                
                    print("INAINTE DE RESET: numarIntrebare: \(numarIntrebare)")
                    print("intrebari.count: \(intrebari.count)")
                    intrebari.removeAll()
                    numarAles = nil
                    numarIntrebari = nil
                    numarIntrebare = 0
                    
                    
                    
                    
                    withAnimation {
                        hasStarted.toggle()
                    }
                    print("DUPA RESET: numarIntrebare: \(numarIntrebare)")
                    print("intrebari.count: \(intrebari.count)")
                    
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
                    verificareRaspuns(raspunsInt)
                    
                    
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
                    Text("Verify")
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
    }


