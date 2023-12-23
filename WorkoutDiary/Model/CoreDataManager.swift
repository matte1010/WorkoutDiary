//
//  CoreDataManager.swift
//  WorkoutDiary
//
//  Created by Arin Rahim on 2023-12-20.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    @Published var workouts: [WorkOutEntity] = []

    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "WorkOutCoreData")
        setupPersistentContainer()
    }

    func saveWorkoutToCoreData(workoutCoreData: WorkOutCoreData) {
        let context = persistentContainer.viewContext
        let workout = WorkOutEntity(context: context)

        workout.exercise = workoutCoreData.exercise
        workout.muscle = workoutCoreData.muscle

        do {
            try context.save()
        } catch {
            print("Failed to save to Core Data: \(error)")
        }
    }

    func fetchWorkouts() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WorkOutEntity> = WorkOutEntity.fetchRequest()


        do {
            workouts = try context.fetch(fetchRequest)
               for workout in workouts {
                   // Accessing attributes to fire faults and load data
                   _ = workout.exercise
                   _ = workout.muscle
                   print(workout)
               }
        } catch {
            print("Failed to fetch workouts from Core Data: \(error)")
            workouts = []
        }
    }
    
    private func setupPersistentContainer() {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }
    
   /* func deleteAllData() {
           let context = persistentContainer.viewContext

           // Create a fetch request for all entities
           let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WorkOutEntity")

           // Create a batch delete request
           let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

           do {
               // Execute the batch delete request
               try context.execute(batchDeleteRequest)

               // Save the changes to persist the deletion
               try context.save()
           } catch {
               print("Failed to delete all data from Core Data: \(error)")
           }
       }*/
}

struct WorkOutCoreData {
    var exercise: String
    var muscle: String
}
