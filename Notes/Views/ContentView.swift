//
//  ContentView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var noteStore: NoteStore

    var body: some View {
        NavigationView {
            List {
                ForEach(noteStore.notes) { note in
                    NavigationLink(destination: NoteView(note: note)) {
                        NoteRow(note: note)
                    }
                }
                .onDelete { atIndexSet in
                    self.noteStore.notes.remove(atOffsets: atIndexSet)
                }
                .onMove { sourceIndices, destinationIndex in
                    self.noteStore.notes.move(fromOffsets: sourceIndices, toOffset: destinationIndex)
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                NavigationLink(destination: AddNoteView()) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NoteStore())
    }
}
