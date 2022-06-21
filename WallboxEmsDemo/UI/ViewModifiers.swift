//
//  ViewModifiers.swift
//  WallboxEmsDemo
//
//  Created by Miguel Perez on 30/3/22.
//

import Foundation
import SwiftUI

struct Selector: ViewModifier {
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .font(.footnote)
            .background(background)
            .cornerRadius(10)
    }
}

struct Widget: ViewModifier {
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(background)
            .cornerRadius(10)
            .clipped()
            .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
    }
}
