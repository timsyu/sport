//
//  ChartsViewController.swift
//  Athletes
//
//  Created by Gina on 2017/12/29.
//  Copyright © 2017年 ChiaYu. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    
    
    var Athletes = [[String:String]]()
    var ballType: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String.init(format: "%.2f%%", value);
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pieChartView.noDataText = "暫時無數據";
        pieChartView.noDataTextColor = UIColor.black;
        pieChartView.noDataFont = UIFont.boldSystemFont(ofSize: 14);
        
        ballType = ["1B", "2B", "3B", "SS", "P", "C", "RF", "CF", "LF", "DH", "其它"] //43521
        var times = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("Athletes.txt")
        let array = NSArray(contentsOf: url!)
        
        
        if array != nil {
            Athletes = array as! [[String:String]]
            for i in 0..<Athletes.count {
                switch Athletes[i]["sportImg"] {
                case "b4"?:
                    times[0] = times[0] + 1
                case "b3"?:
                    times[1] = times[1] + 1
                case "b5"?:
                    times[2] = times[2] + 1
                case "b2"?:
                    times[3] = times[3] + 1
                case "b1"?:
                    times[4] = times[4] + 1
                case "b6"?:
                    times[5] = times[5] + 1
                case "b7"?:
                    times[6] = times[6] + 1
                case "b8"?:
                    times[7] = times[7] + 1
                case "b9"?:
                    times[8] = times[8] + 1
                case "b10"?:
                    times[9] = times[9] + 1
                default:
                    times[10] = times[10] + 1
                }
            }
            for j in (0...10).reversed() {
                if(times[j] == 0.0){
                    times.remove(at: j)
                    ballType.remove(at: j)
                }
            }
            
        }
        
        if(Athletes.count>0){
            pieChartView.usePercentValuesEnabled = true
            pieChartView.drawEntryLabelsEnabled = true
            pieChartView.chartDescription?.text = "" //描述的文字
            pieChartView.drawSlicesUnderHoleEnabled = true
            pieChartView.drawHoleEnabled = true //中間的圓
            pieChartView.holeRadiusPercent = 0.25//半徑
            pieChartView.holeColor = UIColor.white//圓的顏色
            pieChartView.transparentCircleRadiusPercent = 0.3
            
            pieChartView.legend.maxSizePercent = 1
            pieChartView.legend.form = .circle //圖示
            pieChartView.legend.formSize = 17//大小

            pieChartView.legend.formToTextSpace = 5//文字間區隔
            pieChartView.legend.font = UIFont (name: "Hannotate TC", size: 17)!
            pieChartView.legend.textColor = UIColor.black
            pieChartView.legend.horizontalAlignment = .left
            pieChartView.legend.verticalAlignment = .bottom
            var yVals = [PieChartDataEntry]()
            for i in 0..<ballType.count {
                let entry = PieChartDataEntry.init(value: Double(times[i]), label: ballType[i])
                yVals.append(entry)
            }
            let dataSet = PieChartDataSet.init(values: yVals, label: "")
            dataSet.colors = [UIColor(netHex:0xD7D7D7), UIColor(netHex:0xFFC0CB), UIColor(netHex:0xFF8080), UIColor(netHex:0xFFBC80), UIColor(netHex:0xF7FF80), UIColor(netHex:0x80FFA2), UIColor(netHex:0x63C563), UIColor(netHex:0x80EBFF), UIColor(netHex:0x80ABFF), UIColor(netHex:0xC7B6FF), UIColor(netHex:0xA4A4A4)]
        
            dataSet.xValuePosition = .insideSlice
            dataSet.sliceSpace = 0;//相鄰區塊距離
            dataSet.selectionShift = 6;//點選放大半徑
            
            let data = PieChartData.init(dataSets: [dataSet])
            data.setValueFormatter(DigitValueFormatter())
            data.setValueFont(UIFont (name: "Hannotate TC", size: 10)!)
            data.setValueTextColor(UIColor.black)
            pieChartView.data = data
            pieChartView.delegate = self
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ChartsViewController : ChartViewDelegate {
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    //点击饼状图上的事件
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let al = UIAlertController(title: nil, message: "\(ballType[Int(highlight.x)])項目的運動員：\(Int(highlight.y))位", preferredStyle: UIAlertControllerStyle.alert)
        
        let message  = "\(ballType[Int(highlight.x)])項目的運動員：\(Int(highlight.y))位"
        var messageMutableString = NSMutableAttributedString()
        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSFontAttributeName:UIFont(name: "Hannotate TC", size: 18.0)!])
         al.setValue(messageMutableString, forKey: "attributedMessage")
        
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        al.addAction(cancel)
        self.present(al, animated: true, completion: nil)
    }
    

    
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
class DigitValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueWithoutDecimalPart = String(format: "%.f%%", value)
        return valueWithoutDecimalPart
        
    }
}
