//
//  SettingsModel.swift
//  DeskNews
//
//  Created by Keerthika Chokkalingam on 25/11/23.
//

import Foundation
class SettingsModel {
    
    var settingsContent: [[String:Any]] =  [["row Count": 1, "Title": "App Mode", "mode Value": AppConstant.appModeArray, "default mode": "light"],["row Count": 2, "Title": "Landing Screen Category","defaulr Category": "General", "category Values": AppConstant.categories], ["row Count": 3, "Title": "Select News Country", "default Country": "", "country List": AppConstant.countryList], ["row Count": 4, "Tilte": "Select Loader Style", "default Loader": "", "loader Set": ["string"]]]
}
