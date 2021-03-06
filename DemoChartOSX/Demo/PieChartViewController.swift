//
//  PieChartViewController .swift
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

open class PieChartViewController: NSViewController
{
    @IBOutlet var chartView: PieChartView!
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        view.window!.title = "Pie Chart"
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        chartView.minOffset = 0.0
        
        chartView.legend.enabled = false
        chartView.rotationEnabled = true
        chartView.rotationAngle = 270.0
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
        centerText.setAttributes([.font: NSFont(name: "HelveticaNeue-Light", size: 15.0)!,
                                  .paragraphStyle: paragraphStyle], range: NSMakeRange(0, centerText.length))
        centerText.addAttributes([.font: NSFont(name: "HelveticaNeue-Light", size: 13.0)!,
                                  .foregroundColor: NSColor.gray], range: NSMakeRange(10, centerText.length - 10))
        centerText.addAttributes([.font: NSFont(name: "HelveticaNeue-LightItalic", size: 13.0)!,
                                  .foregroundColor: NSColor(red: 51 / 255.0, green: 181 / 255.0, blue: 229 / 255.0, alpha: 1.0)], range: NSMakeRange(centerText.length - 19, 19))
        
        chartView.centerAttributedText = centerText
        chartView.chartDescription?.text = "Pie Chart"
        
        // MARK: PieChartDataEntry
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) * 100.0 }
        let yse1 = ys1.enumerated().map { x, y in return PieChartDataEntry(value: y, label: "val" + String(x)) }
        
        // MARK: PieChartDataSet
        let ds1 = PieChartDataSet(entries: yse1, label: "Hello")
        ds1.colors = ChartColorTemplates.vordiplom()
        
        // MARK: PieChartData
        let data = PieChartData(dataSet: ds1)
        chartView.data = data

    }
    
    override open func viewWillAppear()
    {
//        chartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        chartView.spin(duration: 3, fromAngle: 0, toAngle: 360.0)
    }
}
