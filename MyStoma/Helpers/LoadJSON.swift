import Foundation

func loadOstomyFromBundle() -> Ostomy? {
    let languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"

    let fileSuffix: String
    switch languageCode {
    case "it":
        fileSuffix = "it"
    case "es":
        fileSuffix = "es"
    default:
        fileSuffix = "en"
    }
    let fileName = "Colostomy-\(fileSuffix)"
    
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("\(fileName).json not found.")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Ostomy.self, from: data)
    } catch {
        print("Failed to decode Ostomy from \(fileName).json: \(error)")
        return nil
    }
}
