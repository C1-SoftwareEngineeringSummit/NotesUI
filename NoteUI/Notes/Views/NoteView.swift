//
//  NoteView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/31/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

// This whole view will be part of the bonus work
struct NoteView: View {
    @ObservedObject var noteStore: NoteStore
    let note: Note

    private var index: Int? {
        return noteStore.notes.firstIndex(where: { noteInStore in
            return noteInStore.id == note.id
        })
    }

    var body: some View {
        if let i = index {
            return AnyView(TextView(text: $noteStore.notes[i].content)
                .padding()
                .navigationBarTitle(noteStore.notes[i].title))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let noteStore = NoteStore()
        return NoteView(noteStore: noteStore, note: noteStore.notes[0])
    }
}
