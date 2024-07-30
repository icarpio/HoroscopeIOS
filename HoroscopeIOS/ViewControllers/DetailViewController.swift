
//  Created by icarpio on 30/7/24.


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var luckTextView: UITextView!
    
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!
    
    
    
    var horoscope: Horoscope?
    var isFavorite: Bool = false
    var horoscopeIndex:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
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
    
    func loadData(){
        if let horoscope = horoscope {
            let favoriteHoroscope = UserDefaults.standard.string(forKey: "FAVORITE_HOROSCOPE") ?? ""
            isFavorite = horoscope.id == favoriteHoroscope
            setFavoriteButtomItem()
            nameLabel.text = horoscope.name
            datesLabel.text = horoscope.dates
            logoImageView.image = horoscope.logo
            fetchHoroscopeData(for: horoscope.id)
        }
    }
    
    @IBAction @objc func setFavorite(_ sender: UIBarButtonItem) {
        isFavorite = !isFavorite
        if isFavorite {
            UserDefaults.standard.setValue(horoscope?.id, forKey: "FAVORITE_HOROSCOPE")
        } else {
            UserDefaults.standard.setValue("", forKey: "FAVORITE_HOROSCOPE")
        }
        setFavoriteButtomItem()
    }
    
    func setFavoriteButtomItem() {
        if (isFavorite) {
            favoriteButtonItem.image = UIImage(named:"horoscope-icons/heart")?.withRenderingMode(.alwaysOriginal)
            favoriteButtonItem.style = .plain
        } else {
            favoriteButtonItem.image = UIImage(named: "horoscope-icons/heart_un")?.withRenderingMode(.alwaysOriginal)
            favoriteButtonItem.style = .plain
        }
    }
    
    @IBAction func goToPrev(_ sender: UIButton) {
        if (horoscopeIndex == 0) {
            horoscopeIndex = HoroscopeProvider.getAllHoroscopes().count
        }
        horoscopeIndex -= 1
        horoscope = HoroscopeProvider.getAllHoroscopes()[horoscopeIndex]
        loadData()
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        horoscopeIndex += 1
        if (horoscopeIndex == HoroscopeProvider.getAllHoroscopes().count) {
            horoscopeIndex = 0
        }
        horoscope = HoroscopeProvider.getAllHoroscopes()[horoscopeIndex]
        loadData()
    }
    
    
    
}
