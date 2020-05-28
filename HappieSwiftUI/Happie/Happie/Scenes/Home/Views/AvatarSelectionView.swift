//
//  AvatarSelectionView.swift
//  Happie
//
//  Created by Femke Offringa on 26/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import SwiftUI

struct AvatarSelectionView: View {
    var body: some View {
        ZStack {
            Color(Colors.orangeDarkest)
            SelectHair()
        }
    }
}

struct AvatarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectionView()
    }
}

struct SelectHair: View {
    var body: some View {
        HStack {
            Image("Hair1")
        }
    }
}
