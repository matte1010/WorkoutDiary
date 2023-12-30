//
//  StartedWorkoutsView.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-29.
//

import SwiftUI

struct StartedWorkoutsView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {

        NavigationView {

            List {

                ForEach(viewModel.startedWorkouts) { startedWorkout in

                    Section(header: Text("Started on \(startedWorkout.date)")) {

                        Text(startedWorkout.workout.workoutName)
                            .font(.headline)

                        ForEach(startedWorkout.workout.exercises) { exercise in

                            HStack {
                                Text(exercise.name)
                                Spacer()
                                Text("\(exercise.sets.count) sets")
                            }

                        }

                    }

                }
                
            }
            .navigationTitle("Started Workouts")
            
        }
        
    }
    
}

#Preview {
    StartedWorkoutsView(viewModel: ViewModel())
}
