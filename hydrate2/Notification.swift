import SwiftUI
import UserNotifications
struct Notification: View {
    @State private var startHour: String = "3:00"  // متغير حالة لتخزين الساعة التي تبدأ فيها الإشعارات.
    @State private var startPeriod: String = "AM"  // متغير حالة لتخزين الفترة (صباحًا أو مساءً) لساعة البدء.
    @State private var endHour: String = "3:00"  // متغير حالة لتخزين الساعة التي تنتهي فيها الإشعارات.
    @State private var endPeriod: String = "PM"  // متغير حالة لتخزين الفترة (صباحًا أو مساءً) لساعة الانتهاء.
    @State private var selectedInterval: String = ""  // متغير حالة لتخزين الفاصل الزمني المحدد للإشعارات.
    @Binding var liters: Double  // ربط المتغير مع الكمية المطلوبة من الماء.
    
    let intervals = ["15 Mins", "30 Mins", "60 Mins", "90 Mins", "2 Hours", "3 Hours", "4 Hours", "5 Hours"]  // خيارات الفواصل الزمنية.

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Notification Preferences")
                    .font(.system(size: 24, weight: .bold))  // تحديد حجم ونوع الخط.
                    .padding(.top)  // إضافة حواف علوية.

                // قسم اختيار ساعة البداية والانتهاء.
                VStack(alignment: .leading, spacing: 8) {
                    Text("The start and End hour")
                        .font(.headline)  // عنوان فرعي.
                    Text("Specify the start and end date to receive the notifications")
                        .font(.subheadline)  // نص فرعي.
                        .foregroundColor(.gray)  // تغيير لون النص إلى رمادي.
                }

                // منطقة اختيار الوقت.
                VStack(spacing: 16) {
                    // مكون مخصص لاختيار الوقت لساعات البدء والانتهاء.
                    TimePickerRow(label: "Start hour", time: $startHour, period: $startPeriod)
                    Divider()  // فاصل بين الوقتين.
                    TimePickerRow(label: "End hour", time: $endHour, period: $endPeriod)
                }
                .padding()  // إضافة حواف داخلية.
                .background(Color.gray.opacity(0.1))  // خلفية بلون رمادي فاتح.
                .cornerRadius(12)  // زوايا دائرية.

                // قسم اختيار الفاصل الزمني للإشعارات.
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notification interval")
                        .font(.headline)  // عنوان فرعي.
                    Text("How often would you like to receive notifications within the specified time interval")
                        .font(.subheadline)  // نص فرعي.
                        .foregroundColor(.gray)  // تغيير لون النص إلى رمادي.
                }

                // شبكة اختيار الفواصل الزمنية.
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                    ForEach(intervals, id: \.self) { interval in
                        // زر لاختيار الفاصل الزمني.
                        Button(action: {
                            selectedInterval = interval  // تحديث الفاصل الزمني المحدد.
                        }) {
                            Text(interval)  // نص الزر.
                                .font(.system(size: 16, weight: .medium))  // حجم الخط.
                                .frame(width: 77, height: 70)  // تحديد حجم الزر.
                                .background(selectedInterval == interval ? myColors.babyBlue : Color.gray.opacity(0.2))  // تغيير لون الخلفية بناءً على الاختيار.
                                .foregroundColor(selectedInterval == interval ? .white : .black)  // تغيير لون النص بناءً على الاختيار.
                                .cornerRadius(10)  // زوايا دائرية للزر.
                        }
                    }
                }
                Spacer()  // إضافة مسافة فارغة.
                // زر البدء مع رابط للتنقل إلى الشاشة التالية.
                NavigationLink(destination: Circle1(userGoal: $liters)) {
                    Text("Start")  // نص الزر.
                        .bold()  // النص بخط عريض.
                        .frame(maxWidth: .infinity)  // تمديد النص ليشغل العرض بالكامل.
                        .padding()  // إضافة حواف داخلية.
                        .foregroundColor(.white)  // لون النص أبيض.
                        .background(myColors.babyBlue)  // خلفية بلون أزرق.
                        .cornerRadius(12)  // زوايا دائرية للزر.
                }
                .frame(height: 50)  // تحديد ارتفاع الزر.
            }
            .padding()  // إضافة حواف داخلية حول محتويات VStack.
            .frame(maxWidth: .infinity, maxHeight: .infinity)  // توسيع المحتوى ليملأ الشاشة.
            .background(Color.white)  // خلفية بيضاء للشاشة.
        }
    }
}

// مكون مخصص لصف اختيار الوقت.
struct TimePickerRow: View {
    let label: String  // نص العنوان.
    @Binding var time: String  // ربط حقل الوقت.
    @Binding var period: String  // ربط حقل الفترة (AM/PM).

    var body: some View {
        HStack {
            Text(label)  // عرض عنوان الوقت.
                .font(.system(size: 16))  // حجم الخط.
            Spacer()  // مسافة فارغة بين النص وحقل الإدخال.
            TextField("", text: $time)  // حقل إدخال للوقت.
                .textFieldStyle(RoundedBorderTextFieldStyle())  // نمط حقل الإدخال.
                .frame(width: 80)  // تحديد عرض حقل الإدخال.
            Picker(selection: $period, label: Text("")) {  // حقل اختيار للفترة (AM/PM).
                Text("AM").tag("AM")  // خيار AM.
                Text("PM").tag("PM")  // خيار PM.
            }
            .pickerStyle(SegmentedPickerStyle())  // نمط اختيار مقسم.
            .frame(width: 100)  // تحديد عرض حقل الاختيار.
        }
    }
}

#Preview {
    Notification(liters: .constant(2.7))  // عرض معاينة للواجهة مع كمية الماء المحددة.
}
