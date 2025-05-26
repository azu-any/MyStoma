//
//  LoadJSON.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//

import Foundation

func loadOstomyFromBundle() -> Ostomy? {
    guard let url = Bundle.main.url(forResource: "Colostomy-en", withExtension: "json") else {
        print("colostomy.json not found.")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Ostomy.self, from: data)
    } catch {
        print("Failed to decode Ostomy: \(error)")
        return nil
    }
}
