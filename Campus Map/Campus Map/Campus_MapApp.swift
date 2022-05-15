//
//  Campus_MapApp.swift
//  Campus Map
//
//  Created by Bert Yan on 2/20/22.
//

import SwiftUI

@main
struct Campus_MapApp: App {
    let locationsManager = LocationsManager()
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            CampusView(building: locationsManager.campusBuildings.allBuildings[0]).environmentObject(locationsManager)
        }.onChange(of: scenePhase){phase in
            switch phase{
            case .inactive:
                locationsManager.campusBuildings.saveData()
            default:
                break
            }
        }
    }
}
