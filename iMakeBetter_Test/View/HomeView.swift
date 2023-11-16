//
//  HomeView.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            categoryList()
                .padding(.horizontal, 16)
            
            carousel()

            popularNowView()
            
            MoviesView()
        }
        
        
        
        .background {
            Color("backgroundColor")
                .ignoresSafeArea()
            LinearGradient(colors: [Color("backgroundGradient1"), Color("backGroundGradient2")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .foregroundStyle(.white)
        
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Hi, Kristina")
                    .font(.system(size: 20, weight: .bold))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Search Pressed")
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
        
    }
    
    private func categoryList() -> some View {
        HStack() {
            ForEach(HomeViewModel.FilmCategory.allCases, id: \.self) { category in
                categoryButton(category: category)
            }

            Spacer()
        }
    }
    
    private func categoryButton(category: HomeViewModel.FilmCategory) -> some View {
        let isCurrentCategory = viewModel.currentlySelectedCategory == category
        return Button {
            viewModel.categorySelected(category: category)
        } label: {
            Text(category.rawValue)
                .font(.system(size: 17))
                .foregroundStyle(isCurrentCategory ? Color("fontColor") : .white)
                .padding(.vertical, 7)
                .padding(.horizontal, 16)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(.white, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundStyle(isCurrentCategory ? .white : .clear)
                        )
                }
                .animation(.easeInOut, value: isCurrentCategory)
        }

    }
    
    private func popularNowView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Popular Now")
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.topRatedFilms) { film in
                        AsyncImageView(urlString: film.posterPath)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 127)
                
            }
        }
    }
    
    private func MoviesView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Movies")
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.topRatedFilms) { film in
                        AsyncImageView(urlString: film.posterPath)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 127)
                
            }
        }
    }
    
    private func carousel() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.topRatedFilms) { film in
                    filmCard(film)
                    .frame(width: 300, height: 450) // Set frame size outside GeometryReader
                }
            }
            .padding(.horizontal, 30)
        }
    }
    
    private func filmCard(_ film: FilmModel) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        return GeometryReader { geometry in
            ZStack {
                AsyncImageView(urlString: film.posterPath)
                LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
                VStack(spacing: 16) {
                    Spacer()
                    
                    Text(film.title)
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        ForEach(film.genreNames.indices, id: \.self) { index in
                                Text(film.genreNames[index])
                                .font(.system(size: 13))

                                if index != film.genreNames.count - 1 {
                                    Circle()
                                        .frame(width: 5)
                                }
                            }
                    }
                    
                    HStack {
                        Button {
                            viewModel.playVideoPressed(film: film)
                        } label: {
                            HStack {
                                Image(systemName: "play.circle")
                                Text("Play")
                                    .font(.system(size: 16, weight: .bold))
                            }
                        }
                        .padding(.vertical, 12)
                        .frame(width: 120)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color("playButtonColor"))
                        }
                        
                        Button {
                            viewModel.likeFilmPressed(likedFilm: film)
                        } label: {
                            HStack {
                            
                                Image(systemName: viewModel.isLikedFilm(film: film) ? "checkmark" : "plus")
                                Text(viewModel.isLikedFilm(film: film) ? "My List" : "Add")
                                    .font(.system(size: 16, weight: .bold))
                            }
                        }
                        .padding(.vertical, 12)
                        .frame(width: 120)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 1)
                        }


                    }
                }
                .padding(16)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1) // Change color and line width as needed
            )
            .scaleEffect(scaleValue(geometry: geometry, screenWidth: screenWidth))
            .animation(.easeInOut, value: scaleValue(geometry: geometry, screenWidth: screenWidth))
        }
    }
    
    private func scaleValue(geometry: GeometryProxy, screenWidth: CGFloat) -> CGFloat {
        let cardMidX = geometry.frame(in: .global).midX
        let diff = abs(screenWidth / 2 - cardMidX)
        let scale = max(0.9, 1 - diff / screenWidth)

        return scale
    }

    
}

#Preview {
    HomeView()
}

