//
//  TicketPurchaseView.swift
//  Cinepolis
//
// VISTA DE COMPRA DE BOLETOS

import SwiftUI

struct TicketPurchaseView: View {
    @ObservedObject var cart = CartData.shared // Modelo para almacenar los productos seleccionados por el usuario (viene de cartData)
    @State private var adultTickets = 0
    @State private var childTickets = 0
    
    let movie: Movie // Recibe la película seleccionada

    var total: Int {
        (adultTickets * 84) + (childTickets * 69)
    }
    
    var body: some View {
        VStack {
            
            // Información de la película (imagen, titulo y duración)
            HStack(alignment: .top) {
                Image(movie.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.title3)
                        .bold()
                    Text("Duración")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Text(movie.duration)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            Divider()
            
            // Sección de boletos
            VStack(alignment: .leading, spacing: 16) {
                Text("Boletos")
                    .font(.headline)
                    .padding(.horizontal)
                
                TicketRowView(title: "Adulto", price: 84, quantity: $adultTickets) //Usa el componente y establece al boleto de adulto y de niño
                TicketRowView(title: "Niños", price: 69, quantity: $childTickets)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Total a pagar
            VStack(spacing: 8) {
                Text("Total: $\(total)")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                
                // Botón de continuar que manda a la vista del área de dulcería
                NavigationLink(destination: ProductSelectionView()) {
                    Text("Continuar")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Compra de Boletos")
    }
}

// Componente reutilizable para los renglones de boletos
struct TicketRowView: View {
    let title: String
    let price: Int
    @Binding var quantity: Int //Variable que irá cambiando su valor, es para cantidad de boletos
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text("$\(price)")
                .foregroundColor(.gray)
            HStack {
                Button(action: {
                    if quantity > 0 { quantity -= 1 }
                }) {
                    Image(systemName: "minus.circle.fill")    //icono del circulo con el -
                        .foregroundColor(quantity > 0 ? .blue : .gray) //Cambiará de color dependiendo si se selecciona o no
                        .font(.title3)
                }
                
                Text("\(quantity)")
                    .font(.headline)
                    .frame(width: 40, alignment: .center)
                
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
