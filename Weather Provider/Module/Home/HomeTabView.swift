//
//  HomeTabView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 3/10/25.
//

import SwiftUI


struct HomeTabView<Content: View>: View {
    
    @Binding var selectedTab: Int
    @Binding var weatherData: [WeatherInfo]
    @Binding var viewState: ViewState
    
    let content: Content
    
    init(selectedTab: Binding<Int>, weatherData: Binding<[WeatherInfo]>, viewState: Binding<ViewState>, @ViewBuilder content: () -> Content) {
        _selectedTab = selectedTab
        _weatherData = weatherData
        _viewState = viewState
        self.content = content()
    }
    
    
    var body: some View {
        
        tabView()
    }
    
}


extension HomeTabView {
    
    func tabView() -> some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<weatherData.count,
                    id: \.self) { index in
                tabViewBody()
                    .tag(index)
            }
        }
    }
    
    
    func tabViewBody() -> some View {
        ZStack {
            switch viewState {
                case .loading:
                    ProgressView()
                case .failure(let reason):
                    Text("Failure - \(reason)")
                case .success:
                    content
            }
        }
        
    }

}

