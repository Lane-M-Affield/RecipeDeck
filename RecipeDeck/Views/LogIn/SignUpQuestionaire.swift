import SwiftUI

@MainActor
final class SetupModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func updateProfile(profileName: String, tags: [String], experiencelvl: String, budget: Int) async throws {
        guard let user else { return }
        let updatedUser = DBUser(
            userId: user.userId,
            email: user.email,
            photoURL: user.photoURL,
            date: user.date,
            profileName: profileName,
            tags: tags,
            experiencelvl: experiencelvl,
            budget: budget,
            isProfileComplete: true
        )
        try await UserManager.shared.updateUserProfile(user: updatedUser)
        self.user = try await UserManager.shared.getUser(userId: user.userId)
    }
}

struct ProfileSetupForm: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var setupModel = SetupModel()
    @State private var profileName: String = ""
    @State private var selectedMealTypes: Set<String> = []
    @State private var cookingExperience: String = "Beginner"
    @State private var budget: Double = 20.0
    @State private var isMealPreferencesExpanded: Bool = false

    let mealTypes = ["Breakfast", "Lunch", "Dinner", "Snacks", "Desserts"]
    let experienceLevels = ["Beginner", "Intermediate", "Expert"]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                ProfileNameSection(profileName: $profileName)
                MealPreferencesSection(
                    mealTypes: mealTypes,
                    selectedMealTypes: $selectedMealTypes,
                    isExpanded: $isMealPreferencesExpanded
                )
                CookingExperienceSection(
                    experienceLevels: experienceLevels,
                    cookingExperience: $cookingExperience
                )
                BudgetSection(budget: $budget)

                SaveButton {
                    Task {
                        try await setupModel.updateProfile(
                            profileName: profileName,
                            tags: Array(selectedMealTypes),
                            experiencelvl: cookingExperience,
                            budget: Int(budget)
                        )
                        dismiss()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .navigationTitle("Profile Setup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile Setup")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .task {
                do {
                    try await setupModel.loadCurrentUser()
                    if let user = setupModel.user {
                        profileName = user.profileName ?? ""
                        selectedMealTypes = Set(user.tags ?? [])
                        cookingExperience = user.experiencelvl ?? "Beginner"
                        budget = Double(user.budget ?? 20)
                    }
                } catch {
                    print("Failed to load user: \(error)")
                }
            }
        }
    }
}
struct ProfileNameSection: View {
    @Binding var profileName: String

    var body: some View {
        Section {
            Text("Profile Name")
                .font(.headline)
                .foregroundColor(.black)
            TextField("Enter your profile name", text: $profileName)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.black),
                    alignment: .bottom
                )
                .autocapitalization(.none)
        }
    }
}

struct MealPreferencesSection: View {
    let mealTypes: [String]
    @Binding var selectedMealTypes: Set<String>
    @Binding var isExpanded: Bool

    var body: some View {
        Section {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Meal Preferences")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 5)

            if isExpanded {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 80), spacing: 10)],
                    spacing: 5
                ) {
                    ForEach(mealTypes, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .background(selectedMealTypes.contains(tag) ? Color.black : Color.white)
                            .foregroundColor(selectedMealTypes.contains(tag) ? Color.white : Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .onTapGesture {
                                if selectedMealTypes.contains(tag) {
                                    selectedMealTypes.remove(tag)
                                } else {
                                    selectedMealTypes.insert(tag)
                                }
                            }
                    }
                }
                .padding(.top, 5)
            }
        }
    }
}

struct CookingExperienceSection: View {
    let experienceLevels: [String]
    @Binding var cookingExperience: String

    var body: some View {
        Section {
            Text("Cooking Experience Level")
                .font(.headline)
                .foregroundColor(.black)
            Picker("Experience Level", selection: $cookingExperience) {
                ForEach(experienceLevels, id: \.self) { level in
                    Text(level)
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct BudgetSection: View {
    @Binding var budget: Double

    var body: some View {
        Section {
            Text("Weekly Meal Budget")
                .font(.headline)
                .foregroundColor(.black)
            VStack {
                Slider(value: $budget, in: 10...100, step: 5)
                    .accentColor(.black)
                Text("$\(Int(budget))")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
    }
}

struct SaveButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Save Profile")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(20)
        }
        .padding(.top, 30)
    }
}

struct ProfileSetupForm_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetupForm()
    }
}
