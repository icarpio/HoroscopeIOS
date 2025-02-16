

import Foundation
import UIKit


class HoroscopeProvider {
    
    static func getAllHoroscopes() -> [Horoscope] {
        let list: [Horoscope] = [
                    Horoscope(id: "aries", name: "Aries", logo: UIImage(named: "horoscope-icons/aries")!, dates: "March 21 to April 19"),
                    Horoscope(id: "taurus", name: "Taurus", logo: UIImage(named: "horoscope-icons/taurus")!, dates: "April 20 to May 20"),
                    Horoscope(id: "gemini", name: "Gemini", logo: UIImage(named: "horoscope-icons/gemini")!, dates: "May 21 to June 20"),
                    Horoscope(id: "cancer", name: "Cancer", logo: UIImage(named: "horoscope-icons/cancer")!, dates: "June 21 to July 22"),
                    Horoscope(id: "leo", name: "Leo", logo: UIImage(named: "horoscope-icons/leo")!, dates: "July 23 to August 22"),
                    Horoscope(id: "virgo", name: "Virgo", logo: UIImage(named: "horoscope-icons/virgo")!, dates: "August 23 to September 22"),
                    Horoscope(id: "libra", name: "Libra", logo: UIImage(named: "horoscope-icons/libra")!, dates: "September 23 to October 22"),
                    Horoscope(id: "scorpio", name: "Scorpio", logo: UIImage(named: "horoscope-icons/scorpio")!, dates: "October 23 to November 21"),
                    Horoscope(id: "sagittarius", name: "Sagittarius", logo: UIImage(named: "horoscope-icons/sagittarius")!, dates: "November 22 to December 21"),
                    Horoscope(id: "capricorn", name: "Capricorn", logo: UIImage(named: "horoscope-icons/capricorn")!, dates: "December 22 to January 19"),
                    Horoscope(id: "aquarius", name: "Aquarius", logo: UIImage(named: "horoscope-icons/aquarius")!, dates: "January 20 to February 18"),
                    Horoscope(id: "pisces", name: "Pisces", logo: UIImage(named: "horoscope-icons/pisces")!, dates: "February 19 to March 20")
                ]
        
        return list
    }
    
    
}
