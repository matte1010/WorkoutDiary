//
//  Exercises.swift
//  WorkoutDiary
//
//  Created by Mathias Olsson on 2023-12-17.
//

import Foundation


struct ExerciseSet: Identifiable, Equatable {
    let id: UUID
    var weight: String
    var reps: String
}

struct Exercise: Identifiable, Equatable {
    let id: UUID
    var name: String
    var sets: [ExerciseSet]
}
