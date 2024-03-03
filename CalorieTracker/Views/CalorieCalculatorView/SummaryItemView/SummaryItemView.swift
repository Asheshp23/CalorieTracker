import SwiftUI

struct SummaryItemView: View {
    var description: String
    var value: String?
    
    var body: some View {
        HStack {
            if let value = value {
                Text("\(description)")
                Spacer()
                Text("\(value)")
            } else {
                Text("\(description)")
            }
        }
        .font(.body)
    }
}
