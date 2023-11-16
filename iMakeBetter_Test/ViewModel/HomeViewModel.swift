//
//  HomeViewModel.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import CoreData
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var currentlySelectedCategory: FilmCategory = .none
    @Published var topRatedFilms: [FilmModel] = []
    @Published var likedFilms: [Film] = []
    
    
    init() {
        FilmManager.shared.getTopRated { topRatedFilmsModel in
            self.topRatedFilms = topRatedFilmsModel.results
        }
        fetchFilms()
    }
    
    func categorySelected(category: FilmCategory) {
        self.currentlySelectedCategory = category
    }
    
    private func fetchFilms() {
            let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()

            do {
                likedFilms = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            } catch {
                print("Error fetching: \(error)")
            }
        }
    
    func isLikedFilm(film: FilmModel) -> Bool {
        return likedFilms.contains { likedFilm in
            likedFilm.id == film.id
        }
    }

    func likeFilmPressed(likedFilm: FilmModel) {
        if let  itemToDelete = likedFilms.first(where: { film in
            film.id == likedFilm.id
        }) {
                removeFilm(itemToDelete)
                return
            }
        
        let newFilm = Film(context: PersistenceController.shared.container.viewContext)
        newFilm.id = Int32(likedFilm.id)
        newFilm.name = likedFilm.title
        newFilm.genres = likedFilm.genreNames
        
        saveContext()
        }

        private func removeFilm(_ item: Film) {
            PersistenceController.shared.container.viewContext.delete(item)
            saveContext()
        }

        private func saveContext() {
            do {
                try PersistenceController.shared.container.viewContext.save()
                fetchFilms() // Refresh the items after saving
            } catch {
                PersistenceController.shared.container.viewContext.rollback()
                print("Failed to save context: \(error)")
            }
        }
    
    func playVideoPressed(film: FilmModel) {
        let id = film.id
        FilmManager.shared.getVideos(filmId: id) { videos in
            guard let result = videos.results.first else { return }
            if let url = URL(string: "https://www.youtube.com/watch?v=\(result.key)") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    enum FilmCategory: String, CaseIterable {
        case none = "Category", films = "Films", movies = "Movies"
    }
}
