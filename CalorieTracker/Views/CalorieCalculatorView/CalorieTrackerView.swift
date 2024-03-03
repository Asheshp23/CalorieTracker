import SwiftUI

struct CalorieTrackerView: View {
    @StateObject var viewModel = CalorieTrackerViewModel()
    
    init() {
    // Sets the background color of the Picker
        UISegmentedControl.appearance().backgroundColor = .clear
    // Disappears the divider
       UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    // Changes the color for the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemPink
    // Changes the text color for the selected item
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var goalPicker: some View {
        VStack(alignment: .leading) {
            Text("Goal")
                .font(.headline)
                .foregroundStyle(.white)
            Picker("Goal", selection: $viewModel.selectedGoal) {
                ForEach(WeightGoal.allCases, id: \.self) { goal in
                    Text(goal.rawValue)
                        .foregroundStyle(.white)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    var personalInfoView: some View {
        VStack(spacing: 8.0) {
            HStack {
                LabeledTextFieldView(text: $viewModel.weight, placeholder: "Enter your weight", label: "Weight (kg)")
                LabeledTextFieldView(text: $viewModel.height, placeholder: "Enter your height", label: "Height (cm)")
            }
            LabeledTextFieldView(text: $viewModel.age, placeholder: "Enter your age", label: "Age")
            activityLevelPicker
            genderPicker
            goalPicker
        }
    }
    
    var genderPicker: some View {
        HStack {
            Text("Gender")
                .font(.headline)
                .foregroundStyle(.white)
            Picker(selection: $viewModel.gender, label: Text("Gender")) {
                ForEach(viewModel.genders, id: \.self) { gender in
                    Text(gender)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.vertical)
    }
    
    var activityLevelPicker: some View {
        HStack {
            Text("Activity")
                .font(.headline)
                .foregroundStyle(.white)
            Spacer()
            Picker(selection: $viewModel.activity, label: Text("Activity Level")) {
                ForEach(0..<viewModel.activityLevels.count, id: \.self) { index in
                    Text(viewModel.activityLevels[index])
                        .tag(Double(index) + 1.2)
                }
            }
            .pickerStyle(.automatic)
            .tint(.white)
        }
    }
    
    var calculateButton: some View {
        Button(action: {
            viewModel.calculateBMR()
            viewModel.viewBMI = true
        }) {
            Text("Calculate")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.pink)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding([.horizontal, .bottom])
    }
    
    var summaryView: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Group {
                SummaryItemView(description: "Weight", value: "\(viewModel.weight) kg")
                SummaryItemView(description: "Height", value: "\(viewModel.height) cm")
                SummaryItemView(description: "Age", value: "\(viewModel.age) years")
                SummaryItemView(description: "Activity Level", value: "\(viewModel.activityLevels[Int(viewModel.activity - 1.2)])")
                SummaryItemView(description: "Basal Metabolic Rate (BMR)", value: "\(Int(viewModel.bmr.rounded())) calories")
                BMIGraphView(bmi: viewModel.bmi)
            }
            .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.toggleViewBMI()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.backward")
                        Text("Edit Details")
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .accessibility(label: Text("Edit BMI Details"))
                }
                
                Button(action: {
                    viewModel.reset()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "trash")
                        Text("Clear All")
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
                    .accessibility(label: Text("Clear All Details"))
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }

    var body: some View {
        ScrollView {
            if viewModel.viewBMI {
                summaryView
            } else {
                personalInfoView
                    .padding()
                calculateButton
            }
        }
        .padding(.all)
        .background(.indigo.opacity(0.5))
        .navigationBarTitle(Text("Calorie Tracker")
                            ,displayMode: .large)
    }
}
