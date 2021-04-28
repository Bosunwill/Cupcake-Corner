//
//  DataOrderViewChallenge.swift
//  Cupcake Corner
//
//  Created by Gui Ndikum on 4/28/21.
//

import Foundation

class DataOrder: ObservableObject {
    @Published var orderStruct = OrderStruct()
}

struct OrderStruct: Codable {
    //enum CodingKeys: CodingKey {
      //  case type, quantity, extrafrosting, addSprinkles, name, streetAddress, city, zip
    //}
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    //And everything @Published just become a var
    
     var type = 0
     var quantity = 3
     var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
     var extraFrosting = false
     var addSprinkles = false
    
     var name = ""
     var streetAddress = ""
     var city = ""
     var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    //private func total () {
        //cost = Double(quantity) * 2
        //cost += Double(type) / 2
        
        //if extraFrosting {
          //  cost += Double(quantity)
        //}
        
        //if addSprinkles {
        //    cost += Double(quantity)
      //  }
    //}
  var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    init() {
        
    }
//    required init(from decoder: Decoder) throws {
  //      let container = try decoder.container(keyedBy: CodingKeys.self)
    //    type = try container.decode(Int.self, forKey: .type)
      //  quantity = try container.decode(Int.self, forKey: .quantity)
        //extraFrosting = try container.decode(Bool.self, forKey: .extrafrosting)
        //addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        //name = try container.decode(String.self, forKey: .name)
        //streetAddress = try container.decode(String.self, forKey: .streetAddress)
        //city = try container.decode(String.self, forKey: .city)
        //zip = try container.decode(String.self, forKey: .zip)

    //}
    //func encode(to encoder: Encoder) throws {
      //  var container = encoder.container(keyedBy: CodingKeys.self)
       // try container.encode(type, forKey: .type)
        //try container.encode(quantity, forKey: .quantity)
        //try container.encode(extraFrosting, forKey: .extrafrosting)
        //try container.encode(addSprinkles, forKey: .addSprinkles)
        //try container.encode(name, forKey: .name)
        //try container.encode(streetAddress, forKey: .streetAddress)
        //try container.encode(city, forKey: .city)
        //try container.encode(zip, forKey: .zip)
    //}
}
