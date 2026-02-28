

import SwiftUI

struct CalendarView: View {
    @Binding var limit:Date
    var body: some View {
        DatePicker("", selection: $limit, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .padding()
    }
}
