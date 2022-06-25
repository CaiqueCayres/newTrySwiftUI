//
//  ContentView.swift
//  ScheduleApp
//
//  Created by Carlos Cayres on 12/05/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Schedule App")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
