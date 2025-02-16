//
//  StableWidth.swift
//  eul
//
//  Created by Gao Sun on 2020/11/5.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

extension View {
    func stableWidth(_ factor: CGFloat = 10) -> some View {
        modifier(StableWidth(factor: factor))
    }
}

struct StableWidth: ViewModifier {
    @State private var idealWidth: CGFloat?

    var factor: CGFloat

    func getSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async { [self] in
            idealWidth = factor * ceil(proxy.size.width / factor)
        }
        return Color.clear
    }

    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .fixedSize()
                .background(GeometryReader { getSize($0) })
        }
        .frame(idealWidth: idealWidth)
        .fixedSize()
    }
}
