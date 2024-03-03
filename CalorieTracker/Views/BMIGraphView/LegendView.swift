import SwiftUI

struct LegendView: View {
    private let bmiRanges: [(range: ClosedRange<Double>, label: String, color: Color)] = [
        (0...18.5, "Underweight", Color.blue.opacity(0.8)),
        (18.5...24.9, "Healthy Weight", Color.green.opacity(0.8)),
        (25...29.9, "Overweight", Color.orange.opacity(0.8)),
        (30...34.9, "Obesity I", Color.red.opacity(0.8)),
        (35...39.9, "Obesity II", Color.red.opacity(0.9)),
        (40...100, "Morbid Obesity", Color.red)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(bmiRanges.indices, id: \.self) { index in
                    LegendItemView(label: self.bmiRanges[index].label, range: self.bmiRanges[index].range, color: self.bmiRanges[index].color)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}
