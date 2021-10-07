//
//  WeatherController.swift
//  Travel Utility
//
//  Created by Adrien PEREA on 02/10/2021.
//

import UIKit

class WeatherController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var parisImageView: UIImageView!
    @IBOutlet weak var newyorkImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    // MARK: - Private Variables

    private var weatherInfo = WeatherInfo()
    private var language = "fr"
    private var unit = "metric"

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
    }

    // MARK: - Private Methods

    // add tapGesture to UIImageView
    private func addTap() {
        let tapParis = UITapGestureRecognizer(target: self, action: #selector(showParis))
        parisImageView.addGestureRecognizer(tapParis)
        let tapNewYork = UITapGestureRecognizer(target: self, action: #selector(showNewYork))
        newyorkImageView.addGestureRecognizer(tapNewYork)
    }

    // set the action to do when tap on Paris
    @objc private func showParis() {
        setWeatherAndPerformSegue(city: "Paris")
    }

    // set the action to do when tap on New York
    @objc private func showNewYork() {
        setWeatherAndPerformSegue(city: "New+york")
    }

    // setup function to do when tap
    private func setWeatherAndPerformSegue(city: String) {
        weatherInfo.city = city
        weatherInfo.system = unit
        weatherInfo.unit = unitLabel.text!
        weatherInfo.language = languageLabel.text!
        performSegue(withIdentifier: "Detail", sender: weatherInfo)
    }

    // MARK: - Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let newController = segue.destination as? WeatherDetailController {
                newController.weatherInfo = sender as? WeatherInfo
            }
        }
    }

    // MARK: - IBActions
    // change setting by checking the tag of the sender to change the right setting ( language or unit )
    @IBAction func changeSettingSwitched(_ sender: UISwitch) {
        if sender.tag == 0 {
            if sender.isOn {
                languageLabel.text = "FR"
                language = "fr"
            } else {
                languageLabel.text = "EN"
                language = "en"
            }
        } else {
            if sender.isOn {
                unitLabel.text = "°C"
                unit = "metric"
            } else {
                unitLabel.text = "°F"
                unit = "imperial"
            }
        }
    }

}
