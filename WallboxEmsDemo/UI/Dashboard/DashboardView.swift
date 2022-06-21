//
//  Dashboard.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import SwiftUI
import Combine

struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    let connector: DashboardConnector
    
    init(viewModel: DashboardViewModel, connector: DashboardConnector) {
        self.viewModel = viewModel
        self.connector = connector
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    QuasarWidget(totalCharged: viewModel.quasarTotalEnergyCharged, totalDischarged: viewModel.quasarTotalEnergyDischarged)
                    
                    LiveDataWidget(solarPower: viewModel.liveData.solarPower, quasarPower: viewModel.liveData.quasarsPower, gridPower: viewModel.liveData.gridPower, buildingDemand: viewModel.liveData.buildingDemand)
                    
                    PowerPercentsWidget(solarPower: viewModel.liveData.solarPowerPercent, quasarPower: viewModel.liveData.quasarPowerPercent, gridPower: viewModel.liveData.gridPowerPercent) {
                        Task {
                            await viewModel.send(.showDetailTapped)
                        }
                    }
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 20.0)
                .alert(viewModel.viewError.title, isPresented: $viewModel.viewError.show) {
                    Button("OK", role: .cancel) { }
                }
                NavigationLink("", isActive: $viewModel.showDetailView) { DetailView(viewModel: connector.configureDetailViewModel())
                }
                .navigationTitle("Dashboard")
            }
            .onAppear {
                Task {
                    await viewModel.send(.viewAppeared)
                }
            }
        }
    }
}

struct QuasarWidget: View {
    var totalCharged: String
    var totalDischarged: String
    
    var body: some View {
        VStack {
            WidgetTitle(title: "Quasar charger")
            
            HorizontalTexts(title: "Charged:", subtitle: totalCharged)
            HorizontalTexts(title: "Discharged:", subtitle: totalDischarged)
        }
        .modifier(Widget(background: .blue))
    }
}

struct LiveDataWidget: View {
    
    var solarPower: String
    var quasarPower: String
    var gridPower: String
    var buildingDemand: String
    
    var body: some View {
        VStack {
            WidgetTitle(title: "Energys Live data")
            
            HorizontalTexts(title: "Solar power:", subtitle: solarPower)
            HorizontalTexts(title: "Quasar power:", subtitle: quasarPower)
            HorizontalTexts(title: "Grid power:", subtitle: gridPower)
            HorizontalTexts(title: "Building power:", subtitle: buildingDemand)
            
        }
        .modifier(Widget(background: .purple))
    }
}

struct PowerPercentsWidget: View {
    
    var solarPower: String
    var quasarPower: String
    var gridPower: String
    var completion: () -> ()
    
    var body: some View {
        VStack {
            WidgetTitle(title: "Energy demand percents", showArrow: true)
            
            HorizontalTexts(title: "Quasar power:", subtitle: quasarPower)
            HorizontalTexts(title: "Solar power:", subtitle: solarPower)
            HorizontalTexts(title: "Grid power:", subtitle: gridPower)
        }
        .modifier(Widget(background: .green))
        .onTapGesture {
            completion()
        }
    }
}

struct WidgetTitle: View {
    var title: String
    var showArrow = false
    
    var body: some View {
        HStack {
            Text(title)
                .lineLimit(nil)
                .font(Font.system(.footnote).bold())
                .multilineTextAlignment(.leading)
            Spacer()
            
            if showArrow {
                Image(systemName: "chevron.right")
                    .font(Font.system(.footnote).bold())
            }
        }
    }
}

struct HorizontalTexts: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
            Text(subtitle)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding(2.0)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let gateway = DataRepository(remoteDataSource: Backend(), localDataSource: LocalStorage())
        let connector = DashboardConnector(gateway: gateway)
        
        DashboardView(viewModel: connector.ensambledViewModel(), connector: connector)
    }
}
