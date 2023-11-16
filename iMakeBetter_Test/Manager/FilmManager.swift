//
//  FilmManager.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import Foundation

struct FilmManager {
    static let shared: FilmManager = FilmManager()
    private let networkManager = NetworkManager()
    private let API  = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOGUyNzBlMzYxOGE5Y2EzNzhkMGY5YTFmOTM0ZDVjOCIsInN1YiI6IjY1NTRjY2Q5ZWE4NGM3MTA5NTlkNDM5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BNfmQGOtajkVAKmbnQ1QUjvoEhYlS14iXgvKHAZtogA"
    
    private init() {}
    
    func getTopRated(closure: @escaping (TopRatedFilmsModel) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated")!
        networkManager.getRequest(url: url, headers: ["accept": "application/json", "Authorization": "Bearer \(API)"]) { (result: Result<TopRatedFilmsModel, Error>) in
            switch result {
                case .success(let dataModel):
                closure(dataModel)
                    // Handle successful response with dataModel
                case .failure(let error):
                print(error.localizedDescription)
                    // Handle error
            }
        }
    }
    
    func getVideos(filmId: Int, closure: @escaping (FilmVideoDetailsModel) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(filmId)/videos?language=en-US")!
        networkManager.getRequest(url: url, headers: ["accept": "application/json", "Authorization": "Bearer \(API)"]) { (result: Result<FilmVideoDetailsModel, Error>) in
            switch result {
                case .success(let dataModel):
                closure(dataModel)
                    // Handle successful response with dataModel
                case .failure(let error):
                print(error.localizedDescription)
                    // Handle error
            }
        }
    }
}
