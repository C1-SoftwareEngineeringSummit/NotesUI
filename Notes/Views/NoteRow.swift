//
//  NoteRow.swift
//  Notes
//
//  Created by Longe, Chris on 1/5/20.
//  Copyright © 2020 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteRow: View {
    var note: Note
    
    var body: some View {
        HStack {
            Text(note.title)
            Spacer()
            Text(shortDateFormatter.string(from: note.dateCreated))
        }.padding()
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteRow(note: Note(title: "Note Title...", content: "Testing 1,2,3"))
                .previewLayout(.fixed(width: 300, height: 70))
            NoteRow(note: Note(title: "2nd Note Title...", content: "Testing 1,2,3"))
                .previewLayout(.fixed(width: 414, height: 70))
        }
    }
}
