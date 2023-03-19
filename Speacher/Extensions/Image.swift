//
//  Image.swift
//  Speacher
//
//  Created by Vadim on 9/10/22.
//

import Foundation
import SwiftUI

typealias UIImage = NSImage

extension Image {
  init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}
