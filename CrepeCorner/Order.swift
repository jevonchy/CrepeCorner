//
//  Order.swift
//  CrepeCorner
//
//  Created by Afropunk 4:44 on 4/3/22.
//

import Foundation

enum OrderCodingKeys: CodingKey {
    case type
    case quantity
    case extraForsting
    case addSprinkles
    case name
    case streetAddress
    case city
    case zip
}

class ObservableOrder: ObservableObject {
    @Published var order: Order

    init(order: Order) {
        self.order = order
    }
}

struct Order: Codable {
    static let types = ["Vanilla Bean", "Strawberry", "Peaches & Cream", "Bananas Foster"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
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
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        if name.isAllSpaces || streetAddress.isAllSpaces || city.isAllSpaces || zip.isAllSpaces {
            return false
        }

        return true
    }

    var cost: Double {
        // $2 per crepe
        var cost = Double(quantity) * 2

        // complicated crepes cost more
        cost += (Double(type) / 2)

        // $1/crepe for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/crepe for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}

fileprivate extension String {

    var isAllSpaces: Bool {
        guard !self.isEmpty else { return false }
        return self.drop(while: { $0 == " " }).isEmpty
    }
}
