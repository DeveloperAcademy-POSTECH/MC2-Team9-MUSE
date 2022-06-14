//
//  AuthButton.swift
//  Muse
//
//  Created by kelly on 2022/06/13.
//

import SwiftUI

struct AuthButton: View {
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: () -> Void
    
    internal init (title: String,
                   background: Color,
                   foreground: Color,
                   border: Color,
                   handler: @escaping () -> Void) {
        self.title = title
        self.foreground = foreground
        self.background = background
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        Button (action: handler, label: {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        })
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(border, lineWidth: 2)
                
        }

    }
}

//struct AuthButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthButton()
//    }
//}
