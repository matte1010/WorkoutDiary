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
    
    init() {
        getExercises()
    }
    
    func getExercises() {
        NinjaAPI().loadData { (exercises) in
            // This code is executed when the data is loaded
            self.exercisesAPI = exercises

            // Process the loaded data
            for exercise in exercises {
                self.exercises.append(Exercise(id: UUID(), name: exercise.name, sets: [ExerciseSet(id: UUID(), weight: "", reps: "")]))
            }
            // Now the exercises array is populated
            print("Viewexercises: \(self.exercises)")
        }
        // At this point, exercisesAPI may not be populated yet, so printing it here may show an empty array
        print(exercisesAPI)
    }

    
}
