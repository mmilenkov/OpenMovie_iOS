//
//  RootViewModel.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import Foundation

class RootViewModel: NSObject {
    enum DataError: Error {
        case failedToFetchData
        case noMovieAvailable
    }
    
    enum DataResult {
        case success(MovieData)
        case failure(DataError)
    }
    typealias FetchMovieDataCompletion = (DataResult) -> Void
    
    var didFetchMovieData: FetchMovieDataCompletion?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init()
    }
    
    func fetchMovieData(for title: String) {
        let movieRequest = MovieRequest(baseURL: MovieService.authenticatedBaseUrl, title: Utility.sanitizeString(string: title))
        networkService.fetchData(with: movieRequest.url) {
            [weak self] (data,response,error) in
            if let response = response as? HTTPURLResponse {
                print("Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    self?.didFetchMovieData?(DataResult.failure(.failedToFetchData))
                } else if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let response = try decoder.decode(OMDBResponse.self, from: data)
                        self?.didFetchMovieData?(DataResult.success(response))
                    } catch {
                        self?.didFetchMovieData?(DataResult.failure(.noMovieAvailable))
                    }
                } else {
                    self?.didFetchMovieData?(DataResult.failure(.noMovieAvailable))
                }
            }
        }
    }
    
}
