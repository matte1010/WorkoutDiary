//
//  NinjaAPI.swift
//  WorkoutDiary
//
//  Created by Arin Rahim on 2023-12-18.
//

import Foundation
import CoreData

class NinjaAPI: ObservableObject {
    @Published var exercises = [ExercisesAPI]()

    func loadData(completion: @escaping ([ExercisesAPI]) -> ()) {
        let query = "triceps".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle=" + query!)!
        var request = URLRequest(url: url)
        request.setValue("zMoGk9CWn1sKaLAHYDKrzA==Yt5VgZpBgYNbebEx", forHTTPHeaderField: "X-Api-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {
                let exercises = try JSONDecoder().decode([ExercisesAPI].self, from: data!)
                print(exercises)

                // Store data in Core Data
                let coreDataManager = CoreDataManager()

                for exercise in exercises {
                    let workoutCoreData = WorkOutCoreData(exercise: exercise.name, muscle: exercise.muscle)
                    coreDataManager.saveWorkoutToCoreData(workoutCoreData: workoutCoreData)
                }

                DispatchQueue.main.async {
                    completion(exercises)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}

struct ExercisesAPI: Decodable {
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}

