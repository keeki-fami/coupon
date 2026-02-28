

import SwiftUI

struct CalendarListView: View {
    @Binding var limit:Date
    var body: some View {
        DatePicker("", selection: $limit, displayedComponents: .hourAndMinute)
            .datePickerStyle(.wheel)
            .padding()
    }
}
