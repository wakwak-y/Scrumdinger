//
//  TrailingIconLabelStyleLabelStyle.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/08.
//

import SwiftUI

struct TrailingIconLabelStyleLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyleLabelStyle {
    static var trailingIcon: Self { Self() }
}

