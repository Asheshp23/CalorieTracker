import Foundation

class CalorieTrackerViewModel: ObservableObject {
    @Published var weight: String = "113"
    @Published var height: String = "180"
    @Published var age: String = "29"
    @Published var activity: Double = 1.2
    @Published var gender: String = "Male"
    @Published var bmr: Double = 0.0
    @Published var bmi: Double = 0.0
    @Published var viewBMI: Bool = false
    @Published var selectedGoal: WeightGoal = .maintain
    
    let activityLevels = ["Sedentary", "Lightly Active", "Moderately Active", "Very Active", "Extra Active"]
    let genders = ["Female", "Male"]
    
    func calculateBMI(weightKg: Double, heightMeters: Double) -> Double {
        // Calculate BMI using the formula
        let bmi = weightKg / (heightMeters * heightMeters)
        return bmi
    }
    
    func calculateBMR() {
        guard let weight = Double(weight), weight > 0 else {
            // Show alert or error message for invalid weight
            return
        }
        guard let height = Double(height), height > 0 else {
            // Show alert or error message for invalid height
            return
        }
        guard let age = Int(age), age > 0 else {
            // Show alert or error message for invalid age
            return
        }
        
        let cmToM = height / 100.0
        var formula: Double
        
        if gender == "Female" {
            formula = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * Double(age))
        } else {
            formula = 66.5 + (13.75 * weight) + (5.003 * height) - (6.755 * Double(age))
        }
        
        let bmrWithoutActivity = formula
        
        // Adjust BMR based on the activity level
        let activityFactors: [Double] = [1.2, 1.375, 1.55, 1.725, 1.9] // Activity factors for sedentary, lightly active, moderately active, very active, and extra active
        let selectedActivityFactor = activityFactors[Int(activity - 1.2)]
        bmr = bmrWithoutActivity * selectedActivityFactor
        
        // Adjust BMR based on the selected goal
        switch selectedGoal {
        case .maintain:
            // No adjustment needed for weight maintenance
            break
        case .lose:
            // Subtract a certain percentage of calories for weight loss
            bmr *= 0.85 // For example, reduce BMR by 15% for weight loss
        case .gain:
            // Add a certain percentage of calories for weight gain
            bmr *= 1.1 // For example, increase BMR by 10% for weight gain
        }
        
        bmi = weight / (cmToM * cmToM)
    }

    func reset() {
        weight = ""
        height = ""
        age = ""
        activity = 0.0
        bmr = 0.0
        bmi = 0.0
        viewBMI = false
    }
    
    func toggleViewBMI() {
        viewBMI.toggle()
    }
}
