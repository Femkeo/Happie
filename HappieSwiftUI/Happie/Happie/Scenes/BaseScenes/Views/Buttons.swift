//
//  Buttons.swift
//  Happie
//
//  Created by Femke Offringa on 23/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import SwiftUI

struct bottomButtonView: View {
    let buttonTitle: String = "Start"
    var body: some View {
        ZStack {
            Button(action: {}){
                Text(buttonTitle)
            }.frame(width: 200, height: 40, alignment: .center)
                .background(Color(Colors.orangeDarkest))
                .cornerRadius(10)
                .accentColor(.white)
        }.frame(height: 70)
    }
}
