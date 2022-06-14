//
//  SwiftUIView.swift
//  Muse
//
//  Created by 유재훈 on 2022/06/13.
//

import SwiftUI

struct AnimationView: View {

    @State private var offset: CGFloat = 0.0
    @State var animate: Bool = false
        
        var body: some View {
            
            VStack {
                Button("눌러봐") {
                    animate.toggle()
                  
                }
           Rectangle()
                .frame(width: 100, height: 100)
                .font(Font.system(size: 100.0))
                .offset(y: offset)
                .shadow(radius: 10.0)
                .onTapGesture { offset += 100.0 }
                .animation(Animation.easeInOut(duration: 1), value: offset)

           RoundedRectangle(cornerRadius: 20)
                .frame(width: animate ? 300 : 50, height: 100)

            
        }
        }
    }

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
