//
//  HomeScreen.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-17.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            WorkoutView().tabItem {
                Image(systemName: "dumbbell").font(.title)
                Text("Workout")
            }
            .tag(1)
            Text("Tab Content 2").tabItem {
                Image(systemName: "chart.bar")
                Text("Statistics")
            }
            .tag(2)
            WorkoutListView().tabItem {
                Image(systemName: "list.clipboard").font(.title)
                Text("Workouts")
                    .font(.title)
            }
            .tag(3)
            Text("Tab Content 4").tabItem {
                Image(systemName: "gear")
                Text("Settings")
                    .font(.title)
            }
            .tag(4)
        }
    }
}

#Preview {
    HomeScreen()
}
