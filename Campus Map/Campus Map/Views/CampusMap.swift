//
//  CampusMap.swift
//  Campus Map
//
//  Created by Bert Yan on 2/20/22.
//

import SwiftUI
import MapKit


struct CampusMap: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @GestureState var isLongPressed = false
    @State private var showingAlert = false
    @State private var showingDetails = false
    @Binding  var item :Building
    @Binding var tag :String
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $locationsManager.region,
                interactionModes: .all,
                annotationItems: locationsManager.annotatedPlaces,
                annotationContent: annotationsForCategory)
                .overlay(buttonGroupView,alignment: .bottom)
                .animation(.easeInOut, value: 1.0)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
        
    }
    
    // two buttons that control: 1. clearing the pinned annotations and 2. display/hide the favorite places
    var buttonGroupView : some View{
        HStack{
            Button(action: {locationsManager.cleanPinnedBuildings()}) {
                Image(systemName: "xmark.circle").resizable()
                    .frame(width: 30.0, height: 30.0)
                    .disabled(locationsManager.mappedPlaces.isEmpty)
            }.padding(.horizontal, 15.0)
                .background(Circle().fill(Color.white))
            
            Button(action: {
                locationsManager.showFavorite.toggle()
                
            }) {
                Image(systemName: "heart.circle.fill").resizable()
                    .frame(width: 30.0, height: 30.0)
                    .foregroundColor(locationsManager.showFavorite ? Color.red : Color.gray)
            }.padding(.horizontal, 15.0)
                .background(Circle().fill(Color.white))
            
        }.padding(10.0)
    }
    
    // LONG PRESS FUNCTIONAILITY
    // Upon long pressing on a pinned building from the buildings list, we can trigger a secondary menu that displays the name of the building and a button that navigates to the detail view of the building.
    func annotationsForCategory (item:Building) -> some MapAnnotationProtocol {
        
        MapAnnotation(coordinate: item.coordinate) {
            NavigationLink(destination: BuildingDetailView(building: $item, tabSelection: $tag), isActive: self.$showingDetails) { EmptyView() }
            ZStack{
                Button("") {
                    showingAlert = true
                }
                .alert(item.name, isPresented: $showingAlert) {
                    VStack{
                        Button("View Details") {
                            self.showingDetails = true
                        }
                        Button("Cancel") {
                            
                        }
                    }
                    
                }
                
                Image(systemName: "mappin.and.ellipse").renderingMode(.template)
                
                    .foregroundColor(locationsManager.showFavorite && item.favorite ? Color.red : Color.black)
            }
            .onLongPressGesture(minimumDuration: 0.5) { HELLO in
            } perform: {
                self.item = item
                showingAlert = true
            }
        }
    }
    func annotationPins (item:Building) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate)
    }
    func annotationMarkers (item:Building) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.coordinate)
    }
    
    
}
