
//  Created by icarpio on 30/7/24.


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var luckTextView: UITextView!
    
    var horoscope: Horoscope?
    var selectedSign: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let horoscope = horoscope {
            nameLabel.text = horoscope.name
            datesLabel.text = horoscope.dates
            logoImageView.image = horoscope.logo
            fetchHoroscopeData(for: horoscope.id)
        }

    }
    
    func fetchHoroscopeData(for sign: String) {
            HoroscopeApiService.shared.getDailyHoroscope(sign: sign) { result in
                switch result {
                case .success(let horoscopeResponse):
                    let horoscopeData = horoscopeResponse.data.horoscopeData
                    DispatchQueue.main.async {
                        self.luckTextView.text = horoscopeData
                    }
                case .failure(let error):
                    print("\(sign): \(error)")
                    DispatchQueue.main.async {
                        self.luckTextView.text = "Error fetching data"
                    }
                }
            }
        }
    

}
