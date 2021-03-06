//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Gui Ndikum on 4/25/21.
//

import SwiftUI
import UIKit

class viewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        if NetworkMonitor.shared.isConnected {
            self.NetWorkAlert(Message: "Connected" )
        } else {
            self.NetWorkAlert(Message: "Your Device is not connected")
        }
    }
    func NetWorkAlert(Message: String) {
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var connectionMessage = ""
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var connect = false
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place order") {
                        // place the order
                        self.placeOrder()
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode:  .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(connectionMessage), message: Text(confirmationMessage), dismissButton: .default(Text("Okay")))
        }

    }
    func placeOrder() {
        //NetworkMonitor.shared.startMonitoring()
        guard let encoded = try? JSONEncoder().encode(order)
        else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            // handle the result here
            guard let data = data else {
                
                self.connectionMessage = "Network problem"
                self.confirmationMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                self.showingConfirmation = true
                
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                
                self.connectionMessage = "Thank you!"
                
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types [decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
