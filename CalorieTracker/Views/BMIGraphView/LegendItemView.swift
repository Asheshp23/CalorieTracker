import SwiftUI

struct LegendItemView: View {
    var label: String
    var range: ClosedRange<Double>
    var color: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 20, height: 20)
            Text(label)
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.8))
            Text("\(Int(range.lowerBound)) - \(Int(range.upperBound))")
                .font(.caption)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}
