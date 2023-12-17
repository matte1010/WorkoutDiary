//
//  HomeScreen.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-17.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            WorkoutView().tabItem { Text("Workout") }.tag(1)
            Text("Tab Content 2").tabItem { Text("Statistics") }.tag(2)
            Text("Tab Content 3").tabItem { Text("Tab Label 3") }.tag(3)
            Text("Tab Content 4").tabItem { Text("Tab Label 4") }.tag(4)
        }
    }
}

#Preview {
    HomeScreen()
}
