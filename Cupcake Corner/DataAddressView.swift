//
//  DataAddressView.swift
//  Cupcake Corner
//
//  Created by Gui Ndikum on 4/28/21.
//

import SwiftUI

struct DataAddressView: View {
    @ObservedObject var order: DataOrder
    var body: some View {
        Form {
            Section{
                TextField("Name", text: $order.orderStruct.name)
                TextField("Street Address", text: $order.orderStruct.streetAddress)
                TextField("City", text: $order.orderStruct.city)
                TextField("Zip", text: $order.orderStruct.zip)
            }
            Section {
                NavigationLink(destination: DataCheckOutViewChallenge(order: order)) {
                    Text("Check Out")
                }
            }
            .disabled(order.orderStruct.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }

}

struct DataAddressView_Previews: PreviewProvider {
    static var previews: some View {
        DataAddressView(order: DataOrder())
    }
}
