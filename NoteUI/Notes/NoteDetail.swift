//
//  NoteDetail.swift
//  Notes
//
//  Created by Crowson, John on 5/14/20.
//  Copyright © 2020 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteDetail: View {
    @Binding var notes: [Note]
    let index: Int

    var body: some View {
        TextView(text: $notes[index].content)
            .navigationBarTitle(notes[index].title)
    }
}

struct NoteDetail_Previews: PreviewProvider {
    static let notes = [Note(title: "Note title", content: "some content...")]
    static var previews: some View {
        NavigationView {
            NoteDetail(notes: .constant(notes), index: 0)
        }
    }
}
