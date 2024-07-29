

import Foundation

struct HoroscopeResponse: Codable {
    let data: HoroscopeData
    let status: Int
    let success: Bool
}

struct HoroscopeData: Codable {
    let date: String
    let horoscopeData: String

    enum CodingKeys: String, CodingKey {
        case date
        case horoscopeData = "horoscope_data"
    }
}

class HoroscopeApiService {
    static let shared = HoroscopeApiService()
    private init() {}
    
    private let baseURL = "https://horoscope-app-api.vercel.app"
    
    func getDailyHoroscope(sign: String, day: String = "TODAY", completion: @escaping (Result<HoroscopeResponse, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseURL)/api/v1/get-horoscope/daily") else {
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "sign", value: sign),
            URLQueryItem(name: "day", value: day)
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let horoscopeResponse = try JSONDecoder().decode(HoroscopeResponse.self, from: data)
                completion(.success(horoscopeResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
