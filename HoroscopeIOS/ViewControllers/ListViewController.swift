//
//  ViewController.swift
//  HoroscopeIOS
//
//  Created by Mañanas on 29/7/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    

    
    @IBOutlet weak var tableView: UITableView!
    
    var horoscopeList: [Horoscope] = []
    var horoscopeDataList: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horoscopeList = HoroscopeProvider.getAllHoroscopes()
        tableView.dataSource = self
    
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horoscopeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!HoroscopeViewCell
        let horoscope = horoscopeList[indexPath.row]
        cell.nameLabel.text = horoscope.name
        cell.datesLabel.text = horoscope.dates
        cell.logoImageView.image = horoscope.logo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedHoroscope = horoscopeList[indexPath.row]
                let detailVC = segue.destination as! DetailViewController
                detailVC.horoscope = selectedHoroscope
            }
        }
    }
    
    //Llamada a la API
    func fetchHoroscopeData() {
            let group = DispatchGroup()
            
            for horoscope in horoscopeList {
                group.enter()
                HoroscopeApiService.shared.getDailyHoroscope(sign: horoscope.id) { result in
                    switch result {
                    case .success(let horoscopeResponse):
                        let horoscopeData = horoscopeResponse.data.horoscopeData
                        self.horoscopeDataList[horoscope.id] = horoscopeData
                    case .failure(let error):
                        print("\(horoscope.name): \(error)")
                        self.horoscopeDataList[horoscope.id] = "Error fetching data"
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.printHoroscopeData()
                print("Finished fetching all horoscope data")
            }
        }
        
        func printHoroscopeData() {
            for horoscope in horoscopeList {
                if let horoscopeData = horoscopeDataList[horoscope.id] {
                    print("\(horoscope.name):\n\(horoscopeData)\n")
                    print("\n")
                }
            }
        }
    
    /**
     // Llamada a la API con parámetro de signo
     func fetchHoroscopeData(for sign: String) {
         HoroscopeApiService.shared.getDailyHoroscope(sign: sign) { result in
             switch result {
             case .success(let horoscopeResponse):
                 let horoscopeData = horoscopeResponse.data.horoscopeData
                 self.horoscopeDataList[sign] = horoscopeData
                 self.printHoroscopeData(for: sign)
             case .failure(let error):
                 print("\(sign): \(error)")
                 self.horoscopeDataList[sign] = "Error fetching data"
                 self.printHoroscopeData(for: sign)
             }
         }
     }

     // Función para imprimir los datos de un signo específico
     func printHoroscopeData(for sign: String) {
         if let horoscopeData = horoscopeDataList[sign] {
             print("\(sign):\n\(horoscopeData)\n")
             print("\n")
         }
     }
     
     fetchHoroscopeData(for: "aries")
     */
         

}

