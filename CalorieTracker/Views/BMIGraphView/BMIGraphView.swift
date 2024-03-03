import SwiftUI

struct BMIGraphView: View {
    var bmi: Double
    
    private let bmiRanges: [(range: ClosedRange<Double>, label: String, color: Color)] = [
        (0...18.5, "Underweight", Color.blue.opacity(0.8)),
        (18.5...24.9, "Healthy Weight", Color.green.opacity(0.8)),
        (25...29.9, "Overweight", Color.orange.opacity(0.8)),
        (30...34.9, "Obesity I", Color.red.opacity(0.8)),
        (35...39.9, "Obesity II", Color.red.opacity(0.9)),
        (40...100, "Morbid Obesity", Color.red)
    ]
    
    var body: some View {
        VStack {
            Text("Your BMI is \(bmi, specifier: "%.0f")")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 20)
                    .foregroundColor(Color.gray.opacity(0.3))
                
                GeometryReader { geometry in
                    self.bmiBar(geometry: geometry)
                }
            }
            .frame(height: 20)
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            LegendView()
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    private func bmiBar(geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let maxBMI = bmiRanges.last!.range.upperBound
        let normalizedBMI = min(max(bmi, 0), maxBMI)
        let bmiRatio = normalizedBMI / maxBMI
        
        let bmiPosition = width * CGFloat(bmiRatio)
        
        return ZStack(alignment: .leading) {
            ForEach(bmiRanges.indices.reversed(), id: \.self) { index in
                let range = self.bmiRanges[index].range
                let color = self.bmiRanges[index].color
                
                if range.contains(normalizedBMI) {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: bmiPosition, height: 20)
                        .foregroundColor(color)
                        .padding(.bottom)
                }
            }
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 2, height: 20)
                .foregroundColor(Color.black.opacity(0.6))
                .offset(x: bmiPosition)
                .padding(.bottom)
        }
    }
}

struct BMIGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BMIGraphView(bmi: 29.0)
    }
}
