//
//  Campus_Map_2App.swift
//  Campus Map 2
//
//  Created by Bert Yan on 2/28/22.
//

import SwiftUI

@main
struct Campus_Map_2App: App {
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
