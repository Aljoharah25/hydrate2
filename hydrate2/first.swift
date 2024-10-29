import SwiftUI

struct First: View {
    @State private var weight: String = ""  // متغير حالة لتخزين وزن المستخدم.
    @State private var WaterIntake: Double = 0.0  // متغير حالة لحساب كمية الماء المطلوبة.

    var body: some View {
        // إحاطة واجهة المستخدم بـ NavigationStack لتمكين التنقل  بين الشاشات.
        NavigationStack {
            VStack {
                Spacer()  // مسافة فارغة في الأعلى.

                VStack(alignment:.leading, spacing: 25) {
                    // أيقونة تمثل قطرة ماء مع لون مخصص.
                    Image(systemName: "drop.fill")
                        .frame(width: 50, height: 80, alignment: .leading)  // تحديد حجم الأيقونة.
                        .font(.system(size: 100))  // حجم الخط المستخدم للأيقونة.
                        .foregroundStyle(myColors.babyBlue)  // تطبيق لون مخصص.

                    
                    Text("Hydrate")
                        .bold()  // النص بخط عريض.
                        .font(.headline)  // حجم النص.

                    
                    Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                        .foregroundColor(myColors.gray)  // لون النص بالرمادي.

                    // حاوية أفقية (HStack) تحتوي على النص، حقل الإدخال، وزر مسح.
                    HStack {
                        Text("Body weight")  // نص لتوضيح حقل الوزن.
                            .font(.body)  // حجم النص.

                        Spacer()  // مسافة بين النص وحقل الإدخال.

                        // حقل إدخال لتسجيل وزن المستخدم.
                        TextField("Value", text: $weight)
                            .keyboardType(.decimalPad)  // تعيين نوع لوحة المفاتيح للأرقام.
                            .onChange(of: weight) { newValue in Calculate() }  // حساب الماء عند تغيير الوزن.
                            .frame(width: 80)  // تحديد عرض الحقل.

                        // زر لمسح حقل الإدخال.
                        Button(action: {
                            weight = ""  // مسح النص من الحقل.
                        }) {
                            Image(systemName: "xmark.circle.fill")  // أيقونة الحذف.
                                .foregroundColor(.gray)  // لون الأيقونة بالرمادي.
                        }
                    }
                    .padding()  // إضافة حواف داخلية حول الحاوية.
                    .background(Color(UIColor.systemGray6))  // خلفية بلون رمادي فاتح.
                    .cornerRadius(8)  // زوايا دائرية للحاوية.

                    // رابط تنقل إلى صفحة Notification.
                    NavigationLink(destination: Notification(liters: $WaterIntake)) {
                        Text("Start")
                            .bold()  // النص بخط عريض.
                            .frame(maxWidth: .infinity)  // تمديد النص ليشغل العرض بالكامل.
                            .padding()  // إضافة حواف داخلية.
                            .foregroundColor(.white)  // لون النص أبيض.
                            .background(myColors.babyBlue)  // خلفية بلون أزرق.
                            .cornerRadius(12)  // زوايا دائرية.
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)  // وضع الرابط أسفل الشاشة.
                }
                .padding()  // إضافة حواف داخلية حول محتويات VStack.
                
                Spacer()  // مسافة إضافية فارغة.
                Spacer()  // مسافة إضافية في الأسفل.
            }
        }
    }

    // دالة حساب كمية الماء المطلوبة بناءً على الوزن.
    func Calculate() {
        if let weight = Double(weight) {  // التحقق من أن الوزن المدخل رقم صالح.
            WaterIntake = weight * 0.033  // حساب كمية الماء باللترات.
        } else {
            WaterIntake = 0.0  // إذا كان الإدخال غير صالح، تعيين القيمة إلى 0.
        }
    }
}

#Preview {
    First()  // عرض معاينة للواجهة.
}
