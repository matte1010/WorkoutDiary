//
//  CoreDataManager.swift
//  WorkoutDiary
//
//  Created by Arin Rahim on 2023-12-20.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    let persistentContainer: NSPersistentContainer

        init() {
            persistentContainer = NSPersistentContainer(name: "WorkOutCoreData")
            setupPersistentContainer()
        }


    func saveWorkoutToCoreData(workoutCoreData: WorkOutCoreData) {
        let context = persistentContainer.viewContext
        let workout = WorkOutEntity(context: context)

        workout.exercise = String(workoutCoreData.exercise)
        workout.muscle = String(workoutCoreData.muscle)

        do {
            try context.save()
        } catch {
            print("Failed to save to Core Data: \(error)")
        }
    }

    func fetchWorkoutsFromCoreData() -> [WorkOutEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WorkOutEntity> = WorkOutEntity.fetchRequest()

        do {
            let workouts = try context.fetch(fetchRequest)
            return workouts
        } catch {
            print("Failed to fetch workouts from Core Data: \(error)")
            return []
        }
    }
    
    private func setupPersistentContainer() {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }
    
}

struct  WorkOutCoreData {
    var exercise: String
    var muscle: String
}
