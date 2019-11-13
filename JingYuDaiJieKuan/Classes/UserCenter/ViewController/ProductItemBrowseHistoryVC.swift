//
//  ProductItemBrowseHistoryVC.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//  浏览记录

import UIKit
import CoreData

class ProductItemBrowseHistoryVC: SuperVC {
    
    var productItemHistoryList = [BrowseHistory]()
    
    lazy var tableView: UITableView = {
        let tableView = InsertTableView(nil, CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: view.frame.height), self, self, .plain, .singleLine)
        tableView?.backgroundColor = UIColor.white
        tableView?.register(UINib(nibName: "ProductItemBrowseCell", bundle: nil), forCellReuseIdentifier: "ProductItemBrowseCell")
        tableView?.emptyDataSetSource = self
        return tableView!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "浏览的商户"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
      
        queryHistory()
    }
    
    //查询搜索历史
    func queryHistory(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BrowseHistory")
        
        //按时间戳降序,越后面的时间越早
        let sort = NSSortDescriptor(key: "timeStamp", ascending: false)
        // @[sort];//数组中可以放置多个sort，一般就用一个
        request.sortDescriptors = [sort]
                
        if let result = try? CoreDataManager.default()?.managedContext.fetch(request) as? [BrowseHistory]{
            productItemHistoryList = (result ?? nil)!;
        }
        tableView.reloadData()
    }

    func deleteHistory() {
        
    }
}


extension ProductItemBrowseHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productItemHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemBrowseCell", for: indexPath) as! ProductItemBrowseCell
        
        cell.model = productItemHistoryList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 * SuitParm
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转到web
        let webView = AdWebViewController()
        let model = productItemHistoryList[indexPath.row]
        let path = "/mch/\(model.merchartid)"
        UserViewModel.checkMchStatusPath(path, params: nil, target: nil, success: { (result) in
          
            if result?.code == 200 {
                //如果接口返回判定为下线的商户,那么删除这条记录
                if result?.status == 1 {
                    //点击埋点
                    SensorsAnalyticsSDKHelper.merchantClick(mchId: "\(model.merchartid)", mchName: model.name ?? "", position: "浏览记录", sort: "\(indexPath.row+1)")
                
                    webView.showWeb(withURL: model.url ?? ""
                        , andProductIcon: model.icon ?? ""
                        , andProductMaxAmount: "\(model.maxAmount)"
                        , andProductMerchartid: "\(model.merchartid)"
                        , andProductName: model.name ?? ""
                        , andProductTags: model.tags ?? ""
                        , andProductTitle: model.title ?? ""
                        , andProductUrl: model.url ?? ""
                        , andFromPosition: "\(indexPath.row+1)F"
                        , andIsNeedSaveHistory: false
                        , withSuperController: self)
                } else {
                    //提示信息
                    ZXAlertView.share()?.showMessage(result?.toast)
                    //删除记录
                    CoreDataManager.default()?.managedContext.delete(model)
                    do {
                        try CoreDataManager.default()?.managedContext.save()
                        //刷新数据
                        self.queryHistory()
                    } catch let error as NSError {
                        //删除失败不用刷新
                    }
                    
                }
            }
            
           
        }, failure: nil)
        
        
    }
}


extension ProductItemBrowseHistoryVC: DZNEmptyDataSetSource{
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        return NSAttributedString(string: "暂无数据")
    }
    
    
    //显示的图案
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "noData")
    }
    
}
