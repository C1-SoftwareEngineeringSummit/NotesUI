//
//  RowView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/31/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct RowView: View {
    var note: Note
    
    var body: some View {
        NavigationLink(
            destination: NoteEditingView(note: note)
        ) {
            Text(note.title)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(
            note: Note(title: "To Do", content: "To Do")
        )
    }
}
