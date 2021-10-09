//
//  WeatherDetailController.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    // MARK: - Variables

    var weatherInfo: WeatherInfo?
    var weather5Days: WeatherForFiveDaysInfo?
    let weatherService = WeatherService()

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.reloadData()
    }

    // MARK: - ViewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherService.getWeather(city: weatherInfo!.city, unit: weatherInfo!.system, language: weatherInfo!.language) { (error, weather) in
            if let error = error {
                self.presentAlert(message: error.localizedDescription)
            } else if let weather = weather {
                self.temperatureLabel.text = "\(weather.main.temp) \(String(describing: self.weatherInfo!.unit))"
                self.descriptionLabel.text = weather.weather[0].description
                self.weatherService.getIcon(icon: weather.weather[0].icon) { (error, icon) in
                    if let error = error {
                        self.presentAlert(message: error.localizedDescription)
                    } else if let icon = UIImage(data: icon!) {
                        self.iconImageView.image = icon
                        self.weatherService.getWeatherForFiveDays(city: self.weatherInfo!.city, unit: self.weatherInfo!.system) {  (error, weather) in
                            if let error = error {
                                self.presentAlert(message: error.localizedDescription)
                            } else if let weather = weather {
                                self.weather5Days = weather
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func returnPushed(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension TableView

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.layer.cornerRadius = 25
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constantes.weatherCell) as? WeatherCell {
            if weather5Days != nil {
                cell.dateLabel.text = weather5Days!.weather[indexPath.row].date
                cell.tempLabel.text = String(weather5Days!.weather[indexPath.row].temp) + weatherInfo!.unit
                cell.iconImageView.image = UIImage(named: weather5Days!.weather[indexPath.row].icon)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather5Days?.weather.count ?? 0
    }
}
