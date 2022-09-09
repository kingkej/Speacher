//
//  Main.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import SwiftUI

struct Main: View {
    @Binding var menuState: MenuStates
    
    var body: some View {
        Group {
            if menuState == .Library {
                Library()
            }
            else if menuState == .Settings {
                Settings()
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(menuState: .constant(.Library))
    }
}
