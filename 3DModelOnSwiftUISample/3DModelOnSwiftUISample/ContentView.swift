//
//  ContentView.swift
//  3DModelOnSwiftUISample
//
//  Created by Yuta Tokoro on 2023/06/26.
//

import RealityKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        // 3D Model by J CUBE Inc. - Maneki USDZ for AR / CC BY 4.0
        // https://j-cube.jp/solutions/multiverse/assets/
        // https://creativecommons.org/licenses/by-sa/4.0/
        Model3D(named: "maneki")
    }
}
