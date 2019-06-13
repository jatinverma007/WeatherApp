//
//  UITableViewCell+WeatherBitcoin.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func wt_disableTap(){
        self.isUserInteractionEnabled = false
        self.wt_disableHighlight()
    }
    func wt_disableHighlight() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
}
