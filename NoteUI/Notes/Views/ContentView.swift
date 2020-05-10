//
//  ContentView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var noteStore = NoteStore()

    var body: some View {
        NavigationView {
            List {
                ForEach(noteStore.notes) { note in
                    // Adding the NavigationLink/NoteView will be bonus work
                    NavigationLink(destination: NoteView(noteStore: self.noteStore, note: note)) {
                        NoteRow(noteStore: self.noteStore, note: note)
                    }
                }
                // Adding onDelete will be bonus work (?)
                .onDelete { atIndexSet in
                    self.noteStore.notes.remove(atOffsets: atIndexSet)
                }
                // Adding onMove will be bonus work
                .onMove { sourceIndices, destinationIndex in
                    self.noteStore.notes.move(fromOffsets: sourceIndices, toOffset: destinationIndex)
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(
                // Adding the EditButton will be bonus work
                leading: EditButton(),
                trailing: Button(action: {
                    self.noteStore.notes.insert(Note(), at: 0)
                }) {
                    Image(systemName: "plus")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
