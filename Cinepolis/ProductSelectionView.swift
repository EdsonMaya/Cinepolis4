//
//  ProductSelectionView.swift
//  Cinepolis
//
// VISTA DE DULCERÍA
import SwiftUI

struct ProductSelectionView: View {
    @ObservedObject var cart = CartData.shared  // Modelo para almacenar los productos seleccionados por el usuario (viene de cartData)
    
    var total: Int {
        cart.products.reduce(0) { $0 + $1.price }   //metodo reduce para sumar elementos de array Productos
    }
    
    var body: some View {
        VStack {
            ScrollView {
                // Secciones de categorías de cada sector de dulcería, utiliza el Componente creado de categorías
                CategorySectionView(title: "Palomitas", products: popcorns, cart: cart)
                CategorySectionView(title: "Bebidas", products: drinks, cart: cart)
                CategorySectionView(title: "Golosinas", products: candies, cart: cart)
            }
            
            // Va indicando el total a pagar y botón para ir al carrito
            VStack {
                Text("Total: $\(total)")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                NavigationLink(destination: SummaryView()) {
                    Text("Ir al Carrito")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("DULCERIA")

    }
}

// Componente para las Secciones de Categorías donde se establecen las instancias necesarias
struct CategorySectionView: View {
    let title: String
    let products: [Product]
    @ObservedObject var cart: CartData  //objeto que permite agregar o eliminar productos, proviene de CartData

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            //Lista horizontal para dulcería
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(products) { product in //For Each que recorre productos cargados en MovieData y establece lógica para agregar o eliminar un producto del carrito
                        ProductCardView(product: product, isSelected: cart.products.contains(product))
                            .onTapGesture {
                                if cart.products.contains(product) {
                                    cart.removeProduct(product)
                                } else {
                                    cart.addProduct(product)
                            //Cada elemento de dulcería se almacena en una tarjea que tiene un tapGesture, cuando se toca se agrega al carrito y si se vuelve a tocar se elimina
                            
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

// Componente para las Tarjetas de Productos
struct ProductCardView: View {
    let product: Product
    let isSelected: Bool  //Booleano que dice si el producto ya está seleccionado o ne

    var body: some View {
        VStack {
            //Imagen nombre y precio de los productos
            Image(product.image)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3) //Dibuja un circulo azul si está seleccionado el producto de dulcería
                )
                .padding(4)
            
            Text(product.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text("$\(product.price)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 90, height: 120)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
