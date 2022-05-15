//
//  SectionView.swift
//  Campus Map 2
//
//  Created by Bert Yan on 2/28/22.
//

import SwiftUI

// views for all the buildings satisfying the filter based on section style and title.  Obtains bindings for buildings by finding the indices of the buildings satisfying the property.
struct SectionViews : View {
    @EnvironmentObject var locationsManager : LocationsManager
    @Binding var tabSelection :String
    var filter : ((Building) -> Bool)
    
    var body : some View {
        
        ForEach(locationsManager.campusBuildings.stateIndices(for: filter), id:\.self) { index in
            NavigationLink(destination:
                            BuildingDetailView(
                                building: $locationsManager.campusBuildings.allBuildings[index],
                                tabSelection: $tabSelection
                            )
                            .environmentObject(locationsManager)) {
                BuildingRowView(building: locationsManager.campusBuildings.allBuildings[index])
            }
        }
    }
}
