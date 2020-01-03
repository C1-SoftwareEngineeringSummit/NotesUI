//
//  TextField.swift
//  Notes
//
//  Created by Longe, Chris on 1/2/20.
//  Copyright © 2020 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        return UITextView()
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct TextField_Previews: PreviewProvider {
    @State static var textValue = "Note 1\nTesting 1, 2, 3..."
    static var previews: some View {
        TextView(text: $textValue)
    }
}
