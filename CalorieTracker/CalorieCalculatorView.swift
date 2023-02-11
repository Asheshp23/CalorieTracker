import SwiftUI

struct CalorieCalculatorView: View {
  @State private var weight: String = "73"
  @State private var height: String = "180"
  @State private var age: String = "29"
  @State private var activity: Double = 1.2
  @State private var gender: String = "Male"
  @State private var bmr: Double = 0
  @State private var bmi: Double = 0
  @State private var result: String = ""
  @State private var viewBMI: Bool = false

  let activityLevels = ["Sedentary", "Lightly Active", "Moderately Active", "Very Active", "Extra Active"]
  let genders = ["Female", "Male"]

  var body: some View {
    Form {
      Section(header: Text("Personal Information")) {
        CustomTextFieldView(text: $weight,
                            placeHolder: "Enter your weight:",
                            title: "Weight (kg)")
        CustomTextFieldView(text: $height,
                            placeHolder: "Enter your height:",
                            title: "Height (cm)")
        CustomTextFieldView(text: $age,
                            placeHolder: "Enter your age:",
                            title: "Age")
        HStack {
          Text("Gender")
          Spacer()
          Picker(selection: $gender, label: Text("Select your gender")) {
            ForEach(genders, id: \.self) { gender in
              Text(gender)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
      }
      Section(header: Text("Activity Level")) {
        Picker(selection: $activity, label: Text("Select your activity level")) {
          ForEach(0..<activityLevels.count, id: \.self) { index in
            Text(self.activityLevels[index])
              .tag(Double(index) + 1.2)
          }
        }
        .pickerStyle(WheelPickerStyle())
      }
      Section(header: Text("Results")) {
        HStack {
          Text("BMR (Calories)")
          Spacer()
          Text("\(bmr, specifier: "%.0f")")
        }

        HStack {
          Text("BMI")
          Spacer()
          Text("\(bmi, specifier: "%.0f")")
        }

        HStack {
          Text("Total Calories")
          Spacer()
          Text("\(result)")
        }
        Button(action: {
          self.calculateBMR()
          self.viewBMI.toggle()
        }) {
          Text("View BMI graph")
        }
        Button(action: {
          self.calculateBMR()
        }) {
          Text("Calculate")
        }
      }
    }
    .sheet(isPresented: $viewBMI, content: {
      BMIGraphView(bmi: bmi)
    })
    .navigationBarTitle("Calorie Calculator")
  }
  func calculateBMR() {
    guard let weight = Double(weight), weight > 0 else {
      // show alert or error message for invalid weight
      return
    }
    guard let height = Double(height), height > 0 else {
      // show alert or error message for invalid height
      return
    }
    guard let age = Int(age), age > 0 else {
      // show alert or error message for invalid age
      return
    }
    let cmToM = height / 100.0
    var formula: Double
    if gender == "Female" {
      formula = (655 + (9.6 * weight) + (1.8 * cmToM) - (4.7 * Double(age)))
    } else {
      formula = (66 + (13.7 * weight) + (5 * cmToM) - (6.8 * Double(age)))
    }
    bmr = formula * activity
    bmi = (weight / (cmToM * cmToM))
    result = "(bmr)"
  }
  // you can use alert or error message to show invalid input for weight, height and age.
}
