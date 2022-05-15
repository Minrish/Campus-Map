//
//  LocationsManager.swift
//  Campus Map
//
//  Created by Bert Yan on 2/20/22.
//

import Foundation
import MapKit

class LocationsManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager : CLLocationManager
    
    var showsUserLocation = false
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    @Published var campusBuildings = CampusBuildings()
    
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: CampusBuildings.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: CampusBuildings.span, longitudeDelta: CampusBuildings.span))
    
    @Published var showFavorite : Bool = false
    
    // Map will annotate these items
    @Published var mappedPlaces = [Building]()
    
    //This is the route for direction
    @Published var route : MKRoute?
    
    var annotatedPlaces : [Building] {
        if showFavorite{
            // Make sure there is no duplicates in the list, otherwise it would cause error in the map's annotations
            var totalAnnotated = self.getFavoriteList()
            mappedPlaces.forEach{building in
                if !totalAnnotated.contains(where: {$0.id == building.id}){
                    totalAnnotated.append(building)
                }
            }
            return totalAnnotated
        }else{
            return mappedPlaces
        }
    }
    
    func recenter(building: Building){
        region.center = building.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
    
    func recenterOnUser(){
        guard let location = locationManager.location else{
            return
        }
        region.center = location.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
    }
    
    func cleanPinnedBuildings(){
        mappedPlaces = []
    }
    
    func addToMapped(buiding: Building){
        if !mappedPlaces.contains(where:{$0.id==buiding.id}){
            mappedPlaces.append(buiding)
        }
    }
    
    func getFavoriteList() -> [Building] {
        var result = [Building]()
        
        campusBuildings.allBuildings.forEach{building in
            if building.favorite{
                result.append(building)
            }
        }
        return result
    }
}
