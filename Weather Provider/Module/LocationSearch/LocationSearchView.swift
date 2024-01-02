//
//  LocationSearchView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/14/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct LocationSearchView: View {

    @EnvironmentObject var userDelegate: UserDelegate
    @Environment(\.dismiss) var dismiss
    
    @State var searchLocation: AutoCompleteLocation? = nil  // location
    @State var weatherData: WeatherInfo? = nil              // weather
    @State private var isFetchingWeatherData: Bool = false
    @State private var viewState: ViewState = .loading
    
    @ObservedObject var weatherNetwork = WeatherNetwork()
    
    @State var query: String = ""
    @State var isSearching: Bool = false
    @State var searchResults: [AutoCompleteLocation] = []
    
    
    
    var body: some View {
        Background(displayType: .two, userDelegate.theme) {
            ZStack {
                    locationDisplay()
//                if isSearching == true {
//                    List {
//                        ForEach(searchResults, id: \.id) { result in
//                            searchListRow(location: result)
//                        }
//                        .listRowBackground(userDelegate.theme.weatherBackground)
//                    } // List
//                    .listStyle(.plain)
//                }
            }
        }
//        .foregroundStyle(Color.red)
//        .searchable(text: $query, isPresented: $isSearching, placement: .navigationBarDrawer)
        .onSubmit(of: .search) {
            // MARK: DISMISS KEYBOARD - ISSUE: #WPTL-36
            print("Submit")
        }
        .tint(userDelegate.theme.accentColor)
        .onAppear {
            isSearching = false
        }
        .onChange(of: query) { oldValue, newValue in
            if !newValue.isEmpty {
                
                isSearching = true
                Task(priority: .background) {
                    do {
                        searchResults = try await weatherNetwork.searchAutoComplete(for: query)
                    } catch {
                        print("Could not fetch Search Results")
                    }
                }
            } else {
                isSearching = false
            }
        }
    }
    
}

@available(iOS 17.0, *)
#Preview {
    LocationSearchView(isSearching: true)
        .environmentObject(UserDelegate() )
}


@available(iOS 17.0, *)
extension LocationSearchView {
    
    
    func searchListRow(location: AutoCompleteLocation) -> some View {
        
        Button {
            searchLocation = location
            isSearching = false
        } label: {
            
            VStack(alignment: .leading) {
                WPText("\(location.name), \(location.region)",
                       userDelegate.theme)
                .font(.title2)
                .bold()
                WPText("\(location.country)",
                       userDelegate.theme)
                .font(.body)
                WPText("lat: \(location.latitude.roundByTwoDigits)°, long: \(location.longitude.roundByTwoDigits)°",
                       userDelegate.theme)
                .italic()
            }
            .padding(5)
            
        }
        .buttonStyle(PlainButtonStyle() )
        
        
    }
    
    
    func locationDisplay() -> some View {
        ZStack {
            switch viewState {
                case .loading, .success:
                    VStack {
                        VStack {
                            HStack {
                                TextField("Location", text: $query)
                                    .padding()
                                    .background(Color.black.opacity(0.05) )
                                    .roundedCorner(12, corners: .allCorners)
                                    .foregroundStyle(userDelegate.theme.textColor)
                                
                                if isSearching == true {
                                    Button {
                                        query = ""
                                        isSearching = false
                                    } label: {
                                        WPText("Cancel", userDelegate.theme)
                                    }
                                    .animation(.easeIn, value: isSearching)
                                }
                                
                            }
                            Divider().background(userDelegate.theme.textColor)
                        }.padding(.horizontal)
                        
                        ZStack {
                            
                            // Body
                            VStack {
                                WPOTitle("New Location:",
                                         color: userDelegate.theme.textColor)
                                .shadow(radius: 2, x: 0, y: 1)
                                
                                Spacer()
                                
                                TemporaryWeatherDisplay(weather: weatherData,
                                                        theme: userDelegate.theme)
                                .shadow(radius: 2, x: 0, y: 1)
                                .padding(.horizontal, 20)
                                Spacer()
                                if viewState == .success {
                                    WPButton("Select",
                                             theme: userDelegate.theme) {
                                        guard let searchLocation = searchLocation else { return }
                                        userDelegate.save(location: searchLocation.asLocation() )
                                        dismiss()
                                    }
                                             .shadow(radius: 2, x: 0, y: 1)
                                    Spacer()
                                }
                            }.padding()
                            
                            
                            // Auto Complete List
                            if isSearching == true {
                                List {
                                    ForEach(searchResults, id: \.id) { result in
                                        searchListRow(location: result)
                                    }
                                    .listRowBackground(userDelegate.theme.weatherBackground)
                                } // List
                                .listStyle(.plain)
                                .shadow(radius: 2, x: 0, y: 1)
                                .animation(.easeInOut, value: isSearching)
                            }
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                case .failure(_):
                    WPText("Failure", userDelegate.theme)
                    
            }
//            if searchResults.count != 0 && isSearching == true  {
//                RoundedRectangle(cornerRadius: 0)
//                    .edgesIgnoringSafeArea([.bottom, .horizontal])
//                    .foregroundStyle(.black)
//                    .opacity(0.20)
//            }
        }
        .onChange(of: viewState) { oldValue, newValue in
            switch viewState {
                case .loading:
                    isFetchingWeatherData = true
                case .failure(_):
                    viewState = .loading
                case .success:
                    break
            }
        }
        .onChange(of: isFetchingWeatherData, { oldValue, newValue in
            switch isFetchingWeatherData {
                case true:
                    Task(priority: .background) {
                        let latitudeAndLongitude = "\(searchLocation?.latitude ?? 0.0),\(searchLocation?.longitude ?? 0.0)"
                        weatherData = try await weatherNetwork.fetchTenDayForecast(in: latitudeAndLongitude)
                        isFetchingWeatherData = false
                    }
                case false:
                    break
            }
        })
        .onChange(of: weatherData) { oldValue, newValue in
            if weatherData != nil {
                viewState = .success
            } else {
                viewState = .failure(reason: "Weather could not be unwrapped")
            }
        }
        .onChange(of: searchLocation) { oldValue, newValue in
            if searchLocation == nil {
                isFetchingWeatherData = false
            } else {
                isFetchingWeatherData = true
                viewState = .success
            }
        }
    }
    
}

