//
//  LazyView.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
