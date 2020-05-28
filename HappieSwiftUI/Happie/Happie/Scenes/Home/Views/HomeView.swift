//
//  HomeView.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var isNavigationBarHidden = true

    var body: some View {
        NavigationView{
            AvatarView(navBarIsHidden: $isNavigationBarHidden)
                .navigationBarTitle(Text(""),displayMode: .inline)
                .navigationBarHidden(isNavigationBarHidden)
                .onAppear{
                    self.isNavigationBarHidden = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
