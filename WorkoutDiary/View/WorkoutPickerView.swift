//
//  WorkoutPickerView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-27.
//
import SwiftUI

struct WorkoutPickerView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedWorkoutIndex: Int?
    @State private var isAddingWorkout = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.savedWorkouts.indices, id: \.self) { index in
                        NavigationLink(destination: SavedWorkoutView(viewModel: viewModel, selectedWorkoutIndex: index)) {
                            Text(viewModel.savedWorkouts[index].workoutName)
                        }
                    }
                }
                .background(LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all))
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Pick a Workout")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        isAddingWorkout = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isAddingWorkout) {
                        AddWorkoutView(viewModel: viewModel)
                    }
                }
            )
        }
    }
}

struct WorkoutPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPickerView(viewModel: ViewModel())
    }
}



