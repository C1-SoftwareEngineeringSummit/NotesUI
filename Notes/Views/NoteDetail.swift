//
//  NoteDetail.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/26/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteDetail: View {
  var noteStore: NoteStore

  @Environment(\.presentationMode) var presentationMode
  @State var text = ""

  var body: some View {
    Form {
      TextField("Add note here", text: $text)

      Button("Add") {
        self.noteStore.notes.append(
          Note(name: self.text)
        )

        self.presentationMode.wrappedValue.dismiss()
      }
      .disabled(text.isEmpty)
    }
  }
}

struct NoteDetail_Previews: PreviewProvider {
  static var previews: some View {
    NoteDetail(noteStore: NoteStore())
  }
}
