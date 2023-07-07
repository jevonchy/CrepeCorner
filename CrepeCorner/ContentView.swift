//
//  ContentView.swift
//  CrepeCorner
//
//  Created by Afropunk 4:44 on 4/3/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var oo = ObservableOrder(order: Order())

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your crêpe", selection: $oo.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $oo.order.quantity, in: 3...20) {
                        Text("Number of crêpes: \(oo.order.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $oo.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if oo.order.specialRequestEnabled {
                        Toggle(isOn: $oo.order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $oo.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: AddressView(oo: oo)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Crêpes Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
