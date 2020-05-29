//
//  HomeView.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navBarPrefs: NavBarPreferences

    var body: some View {
        NavigationView{
            AvatarView()
                .navigationBarTitle(Text(""),displayMode: .inline)
                .navigationBarHidden(navBarPrefs.navBarIsHidden)
                .onAppear{
                    self.navBarPrefs.navBarIsHidden = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
