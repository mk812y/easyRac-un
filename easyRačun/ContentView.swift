//
//  ContentView.swift
//  easyRačun
//
//  Created by Михаил Куприянов on 5.11.23..
//

import SwiftUI

struct ContentView: View {
    @State private var racunData: [Racun] = []

        var body: some View {
            List(racunData.indices, id: \.self) { index in
                let racun = racunData[index]
                VStack(alignment: .leading) {
                    Text("Date and Time: \(racun.DateTime)")
                        .font(.title3)
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
}


//#Preview {
//    ContentView()
//}
