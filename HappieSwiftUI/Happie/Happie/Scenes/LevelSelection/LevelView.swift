//
//  LevelView.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import SwiftUI

struct LevelView: View {
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        ZStack {
            Color(Colors.orangeLightest)
            Text("Hello, World!")
        }
        .onAppear{
            self.isNavigationBarHidden = false
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(isNavigationBarHidden: .constant(false))
    }
}
