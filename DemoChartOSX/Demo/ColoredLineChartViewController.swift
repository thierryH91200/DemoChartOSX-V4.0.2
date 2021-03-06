//
//  ColoredLineChartViewController
//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Copyright © 2017 thierry Hentic.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts

import AppKit
import Charts

open class ColoredLineChartViewController: DemoBaseViewController
{
    @IBOutlet weak var chartView0: LineChartView!
    @IBOutlet weak var chartView1: LineChartView!
    @IBOutlet weak var chartView2: LineChartView!
    @IBOutlet weak var chartView3: LineChartView!
    
    var chartViews = [LineChartView]()
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Colored Line Chart"
     }
    
    override open func viewWillAppear()
    {
        chartView0.animate(xAxisDuration: 2.5)
        chartView1.animate(xAxisDuration: 2.5)
        chartView2.animate(xAxisDuration: 2.5)
        chartView3.animate(xAxisDuration: 2.5)
    }

    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        chartViews = [chartView0, chartView1, chartView2, chartView3]
        
        let colors = [#colorLiteral(red: 0.537254901960784, green: 0.901960784313725, blue: 0.317647058823529, alpha: 1.0), #colorLiteral(red: 0.941176470588235, green: 0.941176470588235, blue: 0.117647058823529, alpha: 1.0), #colorLiteral(red: 0.349019607843137, green: 0.780392156862745, blue: 0.980392156862745, alpha: 1.0), #colorLiteral(red: 0.980392156862745, green: 0.407843137254902, blue: 0.407843137254902, alpha: 1.0)]
        
        for (i, chartView) in chartViews.enumerated() {
            let data = dataWithCount(count: 36, range: 100)
            data.setValueFont ( NSFont(name: "HelveticaNeue-Light", size: CGFloat(7.0))!)
            
            setupChart(chartView, data: data, color: colors[i % colors.count])
        }
    }
    
    func setupChart(_ chart: LineChartView, data: LineChartData, color: NSColor)
    {
        // MARK: General
        chart.delegate = self
        chart.highlightPerTapEnabled = true
        chart.pinchZoomEnabled = false
        chart.dragEnabled = false
        chart.setScaleEnabled(false)
        chart.backgroundColor           = color
        chart.drawGridBackgroundEnabled = false
        chart.setViewPortOffsets( left : 10.0, top: 0.0, right: 10.0, bottom: 0.0)
        
        // MARK: xAxis
        chart.xAxis.enabled        = false

        // MARK: leftAxis
        chart.leftAxis.enabled     = false
        chart.leftAxis.spaceTop    = 0.4
        chart.leftAxis.spaceBottom = 0.4
        
        // MARK: rightAxis
        chart.rightAxis.enabled    = false
        
        // MARK: legend
        chart.legend.enabled       = false
        
        // MARK: description
        chart.chartDescription?.enabled = false
        
        let set             = data.dataSets[0] as! LineChartDataSet
        set.circleHoleColor = color
        
        chart.data                 = data
    }
    
    func dataWithCount (count: Int, range: UInt32) -> LineChartData
    {
        // MARK: ChartDataEntry
        let yVals = (0..<count).map { i -> ChartDataEntry in
            let val = Double(arc4random_uniform(range)) + 3
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        // MARK: LineChartDataSet
        let set1               = LineChartDataSet(entries: yVals, label: "DataSet 1")
        
        set1.lineWidth         = 1.75
        set1.circleRadius      = 5.0
        set1.circleHoleRadius  = 2.5
        set1.colors            = [.white]
        set1.circleColors      = [.white]
        set1.highlightColor    = .white
        set1.drawValuesEnabled = false
        
        // MARK: LineChartData
        let data = LineChartData(dataSet: set1)
        return data
    }
}

// MARK: - ChartViewDelegate
extension ColoredLineChartViewController: ChartViewDelegate
{
    public func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    public func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        chartView0.highlightValues([highlight])
        chartView1.highlightValues([highlight])
        chartView2.highlightValues([highlight])
        chartView3.highlightValues([highlight])
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("chartValueNothingSelected")
    }
}
