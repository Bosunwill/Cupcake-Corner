//
//  DataViewChallenge.swift
//  Cupcake Corner
//
//  Created by Gui Ndikum on 4/28/21.
//

import SwiftUI

struct DataViewChallenge: View {
    @ObservedObject var order = DataOrder()
    
    @State private var userName = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                Picker("Select you cake type", selection: $order.orderStruct.type){
                    ForEach(0..<OrderStruct.types.count, id: \.self) {
                        Text(OrderStruct.types[$0])
                    }
                }
                Stepper(value: $order.orderStruct.quantity, in: 3...20) {
                    Text("Number of cakes: \(order.orderStruct.quantity)")
                }
            }
            Section {
                Toggle(isOn: $order.orderStruct.specialRequestEnabled.animation()){
                    Text("Any extra request")
                }
                if order.orderStruct.specialRequestEnabled {
                    Toggle(isOn: $order.orderStruct.extraFrosting){
                        Text("Add extra frosting")
                    }
                    Toggle(isOn: $order.orderStruct.addSprinkles) {
                        Text("Add extra sprinkles")
                    }
                }
            }
            Section {
                NavigationLink(destination: DataAddressView(order: order)) {
                    Text("Delivery details")
                }
            }
        }
        .navigationBarTitle("Cupcake Corner")
    }
    }
}

struct DataViewChallenge_Previews: PreviewProvider {
    static var previews: some View {
        DataViewChallenge()
    }
}
