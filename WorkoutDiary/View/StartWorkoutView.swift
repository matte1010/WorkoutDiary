//
//  StartWorkoutView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-29.
//

import SwiftUI

struct StartWorkoutView: View {

    var workout: Workout
    @ObservedObject var viewModel: ViewModel
    @State private var isDisplayingWorkout = false
    
    var body: some View {
        VStack {
            List {
                ForEach(workout.exercises) { exercise in
                    Section(header: Text(exercise.name)) {
                        Text("\(exercise.sets.count) sets")
                    }
                }
            }
            Button(action: {
                let startedWorkout = Workouts(id: UUID(),
                                                          date: Date(),
                                                          workout: workout)
                            
                            viewModel.startedWorkouts.append(startedWorkout)
                isDisplayingWorkout = true
            }) {
                Text("Start Workout")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isDisplayingWorkout) {
                StartedWorkoutView(viewModel: viewModel, selectedWorkout: $viewModel.startedWorkouts.last!)
            }
            .padding()
        }
        .navigationTitle(workout.workoutName)
    }
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StartWorkoutView(workout: Workout(id: UUID(), workoutName: "Push", exercises: [Exercise(id: UUID(), name: "bench", sets: [ExerciseSet(id: UUID(), weight: "", reps: "")]), Exercise(id: UUID(), name: "Dips", sets: [ExerciseSet(id: UUID(), weight: "", reps: ""), ExerciseSet(id: UUID(), weight: "", reps: "")])]), viewModel: ViewModel())
        }
    }
}

