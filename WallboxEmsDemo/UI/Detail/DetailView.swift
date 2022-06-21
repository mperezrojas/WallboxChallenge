//
//  DetailView.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 28/3/22.
//

import SwiftUI
import SwiftUICharts

struct DetailView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("Quasar") {
                    Task {
                        await viewModel.send(.quasarTapped)
                    }
                }
                .modifier(Selector(background: .orange))
                
                Button("Solar") {
                    Task {
                        await viewModel.send(.solarTapped)
                    }
                }
                .modifier(Selector(background: .blue))
                
                Button("Grid") {
                    Task {
                        await viewModel.send(.gridTapped)
                    }
                }
                .modifier(Selector(background: .purple))

            }
            
            LineView(data: viewModel.data, title: viewModel.title, legend: "kw/min", style: Styles.barChartMidnightGreenLight)
                .padding([.leading, .trailing], 20.0)
        }
        .navigationBarTitle("", displayMode: .inline)
        .alert("Error fetching data", isPresented: $viewModel.showError) {
                    Button("OK", role: .cancel) { }
        }
        .onAppear {
            Task {
                await viewModel.send(.viewAppeared)
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let gateway = DataRepository(remoteDataSource: Backend(), localDataSource: LocalStorage())
        DetailView(viewModel: DetailViewConnector(gateway: gateway).ensambledViewModel())
    }
}
