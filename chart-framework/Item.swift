//
//  SamplePieChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//
import Charts
import Foundation



struct Item: Identifiable {
    enum Category: String {
        case university, college
    }
    var category: Category
    var value:Double
    var label:String
    var id : String{
        label
    }
    static func entriesForItems(_ items: [Item], category: Category) -> [PieChartDataEntry]{
        let requestedItems = items.filter{$0.category == category}
        return requestedItems.map{PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    static var allItems:[Item] {
        [
            Item(category: .university, value: 540000,  label: "جامعة الإمام"),
            Item(category: .university, value: 40000,  label: "جامعة الملك سعود"),
            Item(category: .university, value: 20000,  label: "جامعة الملك فهد"),
            Item(category: .university, value: 30000,  label: "جامعة الأمير سطام"),
            Item(category: .university, value: 30005, label: "جامعة الملك عبدالعزيز"),
            Item(category: .university, value: 20000, label: "جامعة القصيم"),
            Item(category: .university, value: 20000,  label: "جامعة الملك خالد"),
            Item(category: .university, value: 50000,  label: "جامعة جازان"),
            Item(category: .college,  value: 4000,  label: "كلية علوم الحاسب"),
            Item(category: .college,  value: 3000,  label: "كلية الطب"),
            Item(category: .college,  value: 2000,  label: "كلية هندسة البرمجيات"),
            Item(category: .college,  value: 2500,  label: "كلية القانون"),
            Item(category: .college,  value: 1000,  label: "كلية الإقتصاد"),
            Item(category: .college,  value: 1500, label: "كلية العلوم الطبيعية"),
            Item(category: .college,  value: 1200, label: "كلية العلوم الإنسانية")
        ]
    }
}

