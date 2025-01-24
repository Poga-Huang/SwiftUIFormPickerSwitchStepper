//
//  ContentView.swift
//  SwiftUIFormPickerSwitchStepper
//
//  Created by 黃柏嘉 on 2025/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var count: Int = 1
    @State var table: String = ""
    @State var date: Date = Date()
    @State var notifi: Bool = false
    
    var tables = ["圓桌", "方桌", "吧台"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("個人資料") {
                    PersonalData(input: $name,
                                 title: "姓名",
                                 placholder: "請輸入預約名字")
                    
                    PersonalData(input: $phoneNumber,
                                 title: "電話",
                                 placholder: "請輸入電話")
                }
                
                Section("預約資料") {
                    HStack {
                        Text("時間")
                        
                        Spacer()
                        
                        Text(date.toString("yyyy/MM/dd"))
                            .lineLimit(1)
                    }
                    
                    DatePicker("", selection: $date)
                        .datePickerStyle(.compact)
                    
                    Picker("桌型", selection: $table) {
                        ForEach(tables, id: \.self) { table in
                            Text(table)
                        }
                    }.pickerStyle(.navigationLink)
                    
                    Stepper("人數 \(count) 位") {
                        count += 1
                    } onDecrement: {
                        if count > 1 {
                            count -= 1
                        }
                    }
                    
                    
                    Toggle("通知", isOn: $notifi)
                }
            }
            .navigationTitle("預約")
        }
    }
}

#Preview {
    ContentView()
}
//個人資料
struct PersonalData: View {
    
    @Binding var input: String
    var title: String
    var placholder: String
    
    var body: some View {
        HStack(spacing: 16) {
            Text(title)
            
            TextField(text: $input) {
                Text(placholder)
            }
        }
    }
}

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
