//
//  CustomtextFieldView1.swift
//  CalorieTracker
//
//  Created by Apdev on 2023-02-10.
//

import SwiftUI

struct CustomTextFieldView: View {
  @Binding var text: String
  var placeHolder: String
  var title: String

  var body: some View {
    HStack {
      Text(title)
      Spacer()
      TextField(placeHolder, text: $text)
        .keyboardType(.decimalPad)
    }
  }
}
struct CustomTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextFieldView(text: .constant(""), placeHolder: "value", title: "enter")
  }
}
