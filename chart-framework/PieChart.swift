//
//  PieChart.swift
//  PieChart
//
//  Created by Abdullah Alnutayfi on 21/07/2021.
//

import SwiftUI
import Charts

struct PieChart: UIViewRepresentable {
    
    var entries: [PieChartDataEntry]
    @Binding var category: Item.Category
    let pieChart = PieChartView()
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = ChartColorTemplates.colorful()
       // dataSet.colors = [.red,.brown,.yellow,.orange,.green]
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        configureChart(uiView)
        formatCenter(uiView)
        formatDescription(uiView.chartDescription)
        formatLegend(uiView.legend)
        formatDataSet(dataSet)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChart
        init(parent: PieChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let labelText = entry.value(forKey: "label")! as! String
            let num = Int(entry.value(forKey: "value")! as! Double)
            parent.pieChart.centerText = """
                \(labelText)
                \(num)
                """
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func configureChart( _ pieChart: PieChartView) {
        
        pieChart.rotationEnabled = true
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
    }
    
    func formatCenter(_ pieChart: PieChartView) {

        var StrCat : String{
            switch category{
            case .university:
                return "عدد الطلاب حسب الجامعة"
            case .college:
                return "عدد الطلاب حسب الكلية"
            
            }
        }
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerText = StrCat
        pieChart.centerTextRadiusPercent = 0.95
    }
    
    func formatDescription( _ description: Description) {
        var StrCat : String{
            switch category{
            case .university:
                return "عدد الطلاب حسب الجامعة"
            case .college:
                return "عدد الطلاب حسب الكلية"
            
            }
        }
        description.text = StrCat
        description.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func formatLegend(_ legend: Legend) {
        legend.enabled = false
    }
    
    func formatDataSet(_ dataSet: ChartDataSet) {
        dataSet.drawValuesEnabled = false
    }
}

struct PieChart_Previews : PreviewProvider {
    static var previews: some View {
        PieChart(entries: Item.entriesForItems(Item.allItems, category: .university),
                 category: .constant(.university))
            .frame(height: 400)
            .padding()
    }
}
