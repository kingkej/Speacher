//
//  Main.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import SwiftUI

struct Main: View {
    @Binding var menuState: MenuStates
    @State private var file: FileEntity? = nil
    
    
    var body: some View {
        Group {
            if menuState == .Library {
                Library(menuState: $menuState, selectedFile: $file)
            }
            
            else if menuState == .Settings {
                Settings()
            }
            
            else if menuState == .OpenFile {
                FileView(file: file!)
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(menuState: .constant(.Library))
    }
}
