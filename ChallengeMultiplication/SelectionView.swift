//
//  SelectionView.swift
//  ChallengeMultiplication
//
//  Created by Valentin Constantin on 26/04/2026.
//

import SwiftUI

// SelectareView.swift

struct SelectionView: View {
    // Citește și modifică → @Binding
    @Binding var numarAles: Int?
    @Binding var numarIntrebari: Int?
    @Binding var ultimulApasat: Int?
    @Binding var ultimulApasatIntrebari: Int?
    @Binding var startApasat: Bool
    @Binding var pulse: Bool
    @Binding var hasStarted: Bool
    @Binding var intrebari: [Intrebare]

    // Citește doar → let
    let numereIntrebari: [Int]

    // Funcția pasată ca closure
    var onStart: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 30) {
                Text("Multiplication Table")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.title))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                VStack {
                    HStack(spacing: 15) {
                        ForEach(1..<6) { numar in
                            Button {
                                numarAles = numarAles == numar ? nil : numar
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                    ultimulApasat = numar
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    ultimulApasat = nil
                                }
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
                                    ultimulApasat = nil
                                }
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
                Text("Questions")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.title))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                HStack(spacing: 20) {
                    ForEach(numereIntrebari.indices, id: \.self) { i in
                        Button {
                            numarIntrebari = numereIntrebari[i]+1 == numarIntrebari ? nil : numereIntrebari[i]+1
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                                ultimulApasatIntrebari = numereIntrebari[i]
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                ultimulApasatIntrebari = nil
                            }
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
            }.padding()

            Spacer().frame(height: 30)

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
                onStart()  // ← apelezi closure-ul din ContentView
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
            }
            .disabled(numarAles == nil || numarIntrebari == nil)
            .opacity(numarAles == nil || numarIntrebari == nil ? 0.5 : 1.0)

        }.padding()
    }
}
