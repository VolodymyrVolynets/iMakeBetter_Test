//
//  ContentView.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor(named: "backgroundGradient1")
    }

    
    var body: some View {
        NavigationView {
            HomeView()
                .foregroundStyle(.white)
                .background {
                    Color("backgroundColor")
                        .ignoresSafeArea()
                    LinearGradient(colors: [Color("backgroundGradient1"), Color("backgroundGradient2")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                }
        }
    }
}

#Preview {
    ContentView()
}
