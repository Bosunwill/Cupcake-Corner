//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Gui Ndikum on 4/21/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    @State private var userName = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                Picker("Select you cake type", selection: $order.type){
                    ForEach(0..<Order.types.count, id: \.self) {
                        Text(Order.types[$0])
                    }
                }
                Stepper(value: $order.quantity, in: 3...20) {
                    Text("Number of cakes: \(order.quantity)")
                }
            }
            Section {
                Toggle(isOn: $order.specialRequestEnabled.animation()){
                    Text("Any extra request")
                }
                if order.specialRequestEnabled {
                    Toggle(isOn: $order.extraFrosting){
                        Text("Add extra frosting")
                    }
                    Toggle(isOn: $order.addSprinkles) {
                        Text("Add extra sprinkles")
                    }
                }
            }
            Section {
                NavigationLink(destination: AddressView(order: order)) {
                    Text("Delivery details")
                }
            }
        }
        .navigationBarTitle("Cupcake Corner")
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
