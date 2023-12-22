//
//  ViewModel.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-21.
//

import Foundation

class ViewModel : ObservableObject {
    
    var exercisesAPI = [ExercisesAPI]()
    @Published var exercises = [Exercise]()
    @Published var muscleGroups = [MuscleGroup]()
    
    init() {
        getExercises(forMuscle: "biceps")
        getExercises(forMuscle: "chest")
    }
    
    func getExercises(forMuscle muscle: String) {
            NinjaAPI().loadData(muscle: muscle) { (exercises) in
                // This code is executed when the data is loaded
                var muscleGroupExercises = [Exercise]()

                // Process the loaded data
                for exercise in exercises {
                    let newExercise = Exercise(id: UUID(), name: exercise.name, sets: [ExerciseSet(id: UUID(), weight: "", reps: "")])
                    self.exercises.append(newExercise)
                    muscleGroupExercises.append(newExercise)
                }

                // Create a single MuscleGroup for the muscle and add the corresponding exercises
                let muscleGroup = MuscleGroup(name: muscle, exercises: muscleGroupExercises)
                self.muscleGroups.append(muscleGroup)

                // Now the exercises array and muscleGroups array are populated correctly
                print("View exercises: \(self.exercises)")
                print("View muscleGroups: \(self.muscleGroups)")
            }
            // At this point, exercisesAPI may not be populated yet, so printing it here may show an empty array
            print(exercisesAPI)
        }
    
}
