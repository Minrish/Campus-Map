//
//  CampusView.swift
//  Campus Map
//
//  Created by Bert Yan on 2/20/22.
//

import SwiftUI

struct CampusView: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State var tabSelection = "map"
    @State var building: Building
    
//    init(){
//        building = locationsManager.campusBuildings.allBuildings[0]
//    }
    var body: some View {
        VStack {
            
            TabView(selection: $tabSelection){
                CampusMap(item:$locationsManager.campusBuildings.allBuildings[0],tag:$tabSelection)
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(locationsManager)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }.tag("map")
                
                BuildingListView(tabSelection: $tabSelection)
                    .tabItem {
                    Image(systemName: "list.dash")
                    Text("Buildings")
                    }.tag("list")
                    .environmentObject(locationsManager)
            }
        }
    }
    
    var placesHeight : CGFloat = 60.0
}
