//
//  ContentView.swift
//  easyRačun
//
//  Created by Михаил Куприянов on 5.11.23..
// "DateTime": "18.10.2023. 18:39:29",

import SwiftUI
import CodeScanner
import Foundation

struct ContentView: View {
    @State private var isShowingScanner = false
    @State private var racunData: [Racun] = []
    
    var body: some View {
        List(racunData.indices, id: \.self) { index in
            let racun = racunData[index]
            VStack(alignment: .leading) {
                Text("\(stringToDate(stringDate: racun.DateTime))")
                ForEach(racun.Items, id: \.self) { item in
                    Text("Name: \(item.Name)")
                    Text("Quantity: \(item.Quantity)")
                    Text("Total: \(item.Total)")
                    Divider()
                }
            }
            .padding(.bottom, 30)
        }
        .onAppear {
            DataModel().fetchData { data in
                self.racunData = data
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
    }
}


//#Preview {
//    ContentView()
//}
