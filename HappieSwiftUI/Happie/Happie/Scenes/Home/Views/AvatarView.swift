//
//  AvatarView.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        ZStack {
            Color(Colors.orangeDarkest)
            NavigationLink(
            destination: LevelView()) {
                VStack{
                    Image(images.airBalloonScene)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .accentColor(.white)
                    Text("getStartedText")
                        .multilineTextAlignment(.center)
                        .accentColor(.black)
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
