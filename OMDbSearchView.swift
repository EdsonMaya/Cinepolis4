//
//  OMDbSearchView.swift
//  Cinepolis
//
//  VISTA DE BUSQUEDA DE PELICULAS POR LA API
//

import SwiftUI

struct OMDbSearchView: View {
    @State private var searchText: String = "" //Texto ingresado por el usuario
    @State private var movieDetail: MovieDetail? //Objeto que almacena la información de la película retornada por la API
    @State private var isLoading: Bool = false //Indica si se está realizando una solicitud a la API,
    @State private var errorMessage: String? //Contiene un mensaje de error si algo falla
    private let omdbService = OMDbService()  //nstancia del servicio OMDbService, responsable de manejar las solicitudes a la API.
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Buscar Películas")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Ingresa el título de una película", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: fetchMovieDetail) {
                Text("Buscar")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            //Condiciones por si está cargando y si se presenta algún error
            if isLoading {
                ProgressView("Cargando...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else if let movieDetail = movieDetail {
                
                //Carga Imagen e información de la película
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        if let url = URL(string: movieDetail.Poster), movieDetail.Poster != "N/A" {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                     .scaledToFit()
                                     .frame(maxWidth: 300, maxHeight: 400)
                                     .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        //Información que mostrará sobre cada película que encuentre (info que jalará de la API)
                        Text("Título: \(movieDetail.Title)")
                            .font(.headline)
                        Text("Año: \(movieDetail.Year)")
                        Text("Género: \(movieDetail.Genre)")
                        Text("Director: \(movieDetail.Director)")
                        Text("Actores: \(movieDetail.Actors)")
                        Text("Sinopsis:")
                            .font(.headline)
                        Text(movieDetail.Plot)
                    }
                    .padding()
                }
            }
        }
        .padding()
        .navigationTitle("Busqueda OMDb")
    }
    
//Restricción por si quiere buscar sin haber ingresado nada
private func fetchMovieDetail() {
        guard !searchText.isEmpty else {
            errorMessage = "Por favor ingresa un título."
            return
        }
        isLoading = true
        errorMessage = nil
        movieDetail = nil
        
    //
        omdbService.fetchMovieDetail(title: searchText) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let detail):
                    movieDetail = detail
                case .failure(let error):
                    errorMessage = "Error al buscar la película: \(error.localizedDescription)"
                }
            }
        }
    }
}
