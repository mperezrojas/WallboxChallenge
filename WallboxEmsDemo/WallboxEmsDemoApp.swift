//
//  WallboxEmsDemoApp.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 27/3/22.
//

import SwiftUI

@main
struct WallboxEmsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            let backend = Backend()
            let storage = LocalStorage()
            let gateway = DataRepository(remoteDataSource: backend, localDataSource: storage)
            let connector = DashboardConnector(gateway: gateway)
            DashboardView(viewModel: connector.ensambledViewModel(), connector: connector)
        }
    }
}
