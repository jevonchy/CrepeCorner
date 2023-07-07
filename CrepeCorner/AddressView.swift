//
//  AddressView.swift
//  CrepeCorner
//
//  Created by Afropunk 4:44 on 4/3/22.
//

import SwiftUI

struct AddressView: View {
  
    @ObservedObject var oo: ObservableOrder

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $oo.order.name)
                TextField("Street Address", text: $oo.order.streetAddress)
                TextField("City", text: $oo.order.city)
                TextField("Zip", text: $oo.order.zip)

            }

            Section {
                NavigationLink(destination: CheckoutView(oo: oo)){
                    Text("Checkout")
                }
                .disabled(oo.order.hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
       
        AddressView(oo: ObservableOrder(order: Order()))
    }
}
