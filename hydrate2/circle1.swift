import SwiftUI

struct Circle1: View {
    @State private var currentIntake: Double = 0.0  // كمية الماء المستهلكة.
    @Binding var userGoal: Double  // الهدف اليومي للماء.

    private var centerPhoto: String {
        let percentage = (currentIntake / userGoal) * 100
        switch percentage {
        case 0..<20: return "zzz"
        case 20..<60: return "tortoise.fill"
        case 60..<90: return "hare.fill"
        case 90...100: return "hands.clap.fill"
        default: return "hands.clap.fill"
        }
    }

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Today's Water Intake")
                    .font(.footnote)
                    .foregroundColor(.gray)

                Text("\(currentIntake, specifier: "%.1f") liter / \(userGoal, specifier: "%.1f") liter")
                    .font(.title3)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 25)

                Circle()
                    .trim(from: 0.0, to: min(currentIntake / userGoal, 1.0))
                    .stroke(myColors.babyBlue, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .rotationEffect(.degrees(-90))

                Image(systemName: centerPhoto)
                    .foregroundColor(.yellow)
                    .font(.system(size: 40))
            }
            .frame(width: 250, height: 250)

            // وضع النص والـ Stepper في وسط الشاشة مع محاذاة عمودية.
            VStack(spacing: 10) {
                // نص يعرض كمية الماء.
                Text("\(currentIntake, specifier: "%.1f") L")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)  // محاذاة النص في المنتصف.

                // Stepper مباشرة أسفل النص بنفس المحاذاة.
                Stepper(value: $currentIntake, in: 0...userGoal, step: 0.2) {
                    EmptyView()
                }
                .frame(width: 130)  // عرض الـ Stepper.
                .padding(.leading,0)  // إضافة حافة لليسار لتحريك الـ Stepper.

            }
            .frame(maxWidth: .infinity, alignment: .center)  // محاذاة المحتويات في المركز.
        }
        .padding()
    }
}

struct Circle1_Previews: PreviewProvider {
    static var previews: some View {
        Circle1(userGoal: .constant(2.0))
    }
}
