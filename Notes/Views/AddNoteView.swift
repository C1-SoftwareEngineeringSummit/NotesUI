//
//  AddNoteView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/26/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct AddNoteView: View {
    @EnvironmentObject var noteStore: NoteStore
    @Environment(\.presentationMode) var presentationMode
    @State var text = "Enter a note here"
    @State var title = ""
    
    var body: some View {
        VStack {
            TextField("Enter a title here", text: $title)
                .font(.title)
            TextView(text: $text)
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            Button("Add") {
                self.noteStore.notes.append(Note(title: self.title, content: self.text))
                self.presentationMode.wrappedValue.dismiss()
            }
            .disabled(text.isEmpty || title.isEmpty))
    }
}

struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView().environmentObject(NoteStore())
    }
}
