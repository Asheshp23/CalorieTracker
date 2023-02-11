//
//  BMIGraphView.swift
//  CalorieTracker
//
//  Created by Apdev on 2023-02-10.
//

import SwiftUI

struct BMIGraphView: View {
  var bmi: Double

  var body: some View {
    VStack {
      ZStack {
        Circle()
          .trim(from: 0, to: 0.5)
          .stroke(Color.gray, lineWidth: 10)
          .frame(width: 100, height: 100)
        if bmi >= 30.0 {
          Circle()
            .trim(from: 0, to: CGFloat(bmi / 60))
            .stroke(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 10)
            .frame(width: 100, height: 100)
        } else if bmi >= 25.0 {
          Circle()
            .trim(from: 0, to: CGFloat(bmi / 60))
            .stroke(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 10)
            .frame(width: 100, height: 100)
        } else if bmi >= 18.5 {
          Circle()
            .trim(from: 0, to: CGFloat(bmi / 60))
            .stroke(LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 10)
            .frame(width: 100, height: 100)
        } else {
          Circle()
            .trim(from: 0, to: CGFloat(bmi / 60))
            .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 10)
            .frame(width: 100, height: 100)
        }
      }
      HStack {
        Text("Underweight")
          .foregroundColor(.blue)
        Spacer()
        Text("Healthy Weight")
          .foregroundColor(.green)
        Spacer()
        Text("Overweight")
          .foregroundColor(.orange)
        Spacer()
        Text("Obesity")
          .foregroundColor(.red)
      }
      .padding()
    }
  }
}



struct BMIGraphView_Previews: PreviewProvider {
  static var previews: some View {
    BMIGraphView(bmi: 29.0)
  }
}
