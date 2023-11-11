//
//  DataModel.swift
//  easyRačun
//
//  Created by Михаил Куприянов on 5.11.23..
//

import Foundation

struct Items: Codable, Hashable {
    let GTIN: String
    let Name: String
    let Quantity: Double
    let Total: Double
    let UnitPrice: Double
    let Label: String
    let LabelRate: Int
    let TaxBaseAmount: Double
    let VatAmount: Double
}

struct Racun: Codable, Hashable {
    let DateTime: String
    let Link: String
    let Items: [Items]
}

class DataModel {
    func fetchData(completion: @escaping ([Racun]) -> Void) {
        guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else {
            print("Failed to find JSON file")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let jsonData = data else {
                print("No data found")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Racun].self, from: jsonData)
                completion(decodedData)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print(String(describing: error))
                completion([])
            }
        }.resume()
    }
}

func stringToDate(_ stringDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy. HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "CEST")
    
    if let date = dateFormatter.date(from: stringDate) {
        return date
    } else {
        return Date()
    }
}
