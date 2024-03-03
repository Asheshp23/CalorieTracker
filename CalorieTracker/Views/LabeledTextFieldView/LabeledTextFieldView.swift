import SwiftUI

struct LabeledTextFieldView: View {
    @Binding var text: String
    var placeholder: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .foregroundStyle(.white)
            TextField(placeholder, text: $text)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .accessibilityLabel(label)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextFieldView(text: .constant(""), placeholder: "Enter your value", label: "Title")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
