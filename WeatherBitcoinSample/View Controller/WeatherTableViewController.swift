//
//  WeatherTableViewController.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var city = ["Current Location", "London", "Tokyo", "Delhi"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CITIES"
        self.tableView.alwaysBounceVertical = false
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: WBConstants.StoryBoard.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: WBConstants.StoryBoardIds.weatherCityVC) as! CityWeatherTableViewController
        if indexPath.row == 0 {
            vc.currentCity = "current"
        }
        else {
            vc.currentCity = city[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
