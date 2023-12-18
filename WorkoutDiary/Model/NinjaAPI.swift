//
//  NinjaAPI.swift
//  WorkoutDiary
//
//  Created by Arin Rahim on 2023-12-18.
//

import Foundation
import CoreData

class NinjaAPI: ObservableObject 
{

    @Published var exercises = [Exercises]()

    func loadData(completion: @escaping ([Exercises]) -> ()) {
        let query = "biceps".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle=" + query!)!
        var request = URLRequest(url: url)
        request.setValue("zMoGk9CWn1sKaLAHYDKrzA==Yt5VgZpBgYNbebEx", forHTTPHeaderField: "X-Api-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                // Handle error appropriately, e.g., return an empty array or show an error message
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {
                let exercises = try JSONDecoder().decode([Exercises].self, from: data!)
                print(exercises)
                DispatchQueue.main.async {
                    completion(exercises)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                // Handle decoding error appropriately, e.g., return an empty array or show an error message
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }

}

struct Exercises: Decodable {
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}

struct CoreDataExercises: Codable
{
    var exerciseName: String
    var muscle: String
}
