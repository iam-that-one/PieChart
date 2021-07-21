//
//  ContentView.swift
//  chart-framework
//
//  Created by Abdullah Alnutayfi on 21/07/2021.
//
import Charts
import SwiftUI

struct ContentView: View {

    @State var itemLable = ""
    @State var itemValue = 0.0
    @State var items = Item.allItems
    @State var showPieChart = false
    @State private var pieChartEntries: [PieChartDataEntry] = []
    @State private var category: Item.Category = .university
        var body: some View {
            NavigationView{
            VStack {
                List{
                    Button(action:{
                        showPieChart.toggle()
                    }){
                        HStack{
                          Image(systemName: "chevron.left")
                            .foregroundColor(Color(.systemGray))
                            Spacer()
                            Text("عرض ")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                +
                            Text("الرسم ")
                                .foregroundColor(.yellow)
                                .fontWeight(.bold)
                            +
                            Text("البياني ")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }.foregroundColor(Color.black)
                    }
                    Section(
                    header:
                        HStack{
                            Spacer()
                            Text("عدد الطلاب حسب الجامعة")
                        }
                        ){
                        ForEach(items){item in
                            if item.category == .university{
                            HStack{
                            
                                Text("\(Int(item.value))")
                                Spacer()
                                Text(item.label)
                            }.foregroundColor(Color.gray)
                        }
                        }
                    }
                    Section(
                    header:
                        HStack{
                            Spacer()
                            Text("عدد الطلاب حسب الكلية")
                        }
                        ){
                        ForEach(items){item in
                            if item.category == .college{
                            HStack{
                            
                                Text("\(Int(item.value))")
                                Spacer()
                                Text(item.label)
                            }.foregroundColor(Color.gray)
                        }
                        }
                    }
                  
               
                }.listStyle(InsetGroupedListStyle())
            }.ignoresSafeArea()
            .fullScreenCover(isPresented: $showPieChart, content: {
                NavigationView{
                VStack{
                    PieChart(entries: Item.entriesForWines(items,
                                                           category: category),
                             category: $category)
                        .frame(height: 400)
                        .padding()
                    Picker(selection: $category, label: Text("Category")) {
                        Text("عدد الطلاب حسب الجامعة").tag(Item.Category.university)
                        Text("عدد الطلاب حسب الكلية").tag(Item.Category.college)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }.padding()
                .toolbar{
                    ToolbarItem(placement:.principal){
                        Text("عدد الطلاب(عشوائي)")
                            .font(.largeTitle)
                    }
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button(action:{
                            showPieChart = false
                        }){
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
            
            }
            })
            .toolbar{
                ToolbarItem(placement:.principal){
                    Text("عدد الطلاب(عشوائي)")
                        .font(.largeTitle)
                }
            }
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    Button(action:{
                        items.append(Item(category: .university, value: 50000, label: "dqed"))
                    }){
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
          
    }
}
