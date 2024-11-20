//
//  MovieDetailView.swift
//  Cinepolis
//
//  
// Vista de detalle con datos de cada película

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie //Asignarle el valor de Movie de MovieData a esta constante

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen y Título de la Película provenientes de MovieData
                Image(movie.image)
                    .resizable()
                    .frame(height: 250)
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                
                // Información General de cada película tambien provenientes de MovieData
                Text("Clasificación: \(movie.classification)")
                Text("Duración: \(movie.duration)")
                Text("Género: \(movie.genre)")
                Text("Sinopsis:")
                    .bold()
                Text(movie.synopsis)
                    .padding(.bottom)
                
                // Lista de Actores con imagenes
                Text("Actores")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(movie.actors) { actor in //ForEach para recorrer actores de la película seleccionada y traer nombre e imagen
                            VStack {
                                Image(actor.image)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                                Text(actor.name)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Detalles") 
        // Botón para la nueva pantalla de búsqueda usando la API.
                        NavigationLink(destination: OMDbSearchView()) {
                            Text("Buscar Películas en OMDb")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding()
                        }
    }
}
