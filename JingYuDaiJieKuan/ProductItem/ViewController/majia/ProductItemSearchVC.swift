//
//  ProductItemSearchVC.swift
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//


import UIKit

class ProductItemSearchVC: UIViewController {
    
    let cellW = ((SCREEN_WIDTH - 20)/3) - 20
    let cellH: CGFloat = 38
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //整个中间搜索控件部分底部颜色视图
    lazy var searchBGView: UIView = {
        let view = UIView()
        //切圆角
        view.layer.cornerRadius = 15.5
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0).withAlphaComponent(0.7)
        return view
    }()
    
    //搜索框放大镜
    lazy var searchImg: UIImageView = {
        let view = UIImageView(image: UIImage(named: "search"))
        return view
    }()
    
    //搜索框文字
    lazy var searchTxt: UITextField = {
        let txt = UITextField()
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        txt.attributedPlaceholder = NSAttributedString(string: "搜索商户名称", attributes: placeholserAttributes)
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.isUserInteractionEnabled = true
        txt.becomeFirstResponder()
        txt.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        return txt
    }()
    
    //取消按钮
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnEvent(_:)), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = InsertTableView(nil, CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: view.frame.height), self, self, .plain, .singleLine)
        tableView?.mj_header = PigMJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(reloadData))
        tableView?.backgroundColor = UIColor.white
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.emptyDataSetSource = self
        return tableView!
    }()
    
    /// 一个collectionView
    private lazy var collctionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellW, height: cellH)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = .zero
        flowLayout.headerReferenceSize = CGSize(width: 100, height: 48)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ProductItemSearchCell.self, forCellWithReuseIdentifier: "ProductItemSearchCell")
        collectionView.register(ProductItemSearchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductItemSearchHeader")
        return collectionView
    }()
    
    // 页码
    var pageIndex = 1
    var productItemList = [ProductItemModel]()
    var productItemHotList = ProductItemHistoryListModel()
    var productItemHistoryList = ProductItemHistoryListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        setupSubview()
        view.backgroundColor = UIColor.white
        getHistory()
        
        self.getProductItemHotPath()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //商户隐藏模块的功能,所以每次都需要加载新数据
        if let text = searchTxt.text, !text.isEmpty {
            tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
            reloadData()
        }
        
        //因为浏览历史数据可能更新,所以每次都需要刷新控件
        collctionView.reloadData()
    }
    
    // MARK: - 自定义方法
    //添加控件
    private func setupSubview() {
        
        //搜索控件包裹视图
        view.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: TD_NaviHeight)
        
        //中间搜索控件包含的所有控件
        contentView.addSubview(searchBGView)
        searchBGView.frame = CGRect(x: 20, y: TD_NaviHeight - 44 + 6, width: contentView.bounds.width - cancelBtn.bounds.width - 20 - 20, height: 30)
        
        contentView.addSubview(searchImg)
        searchImg.frame = CGRect(x: searchBGView.frame.minX + 15, y: 0, width: 15, height: 15)
        searchImg.center.y = searchBGView.center.y
        
        contentView.addSubview(searchTxt)
        searchTxt.frame = CGRect(x: searchImg.frame.maxX + 13, y: 0, width: contentView.bounds.width - searchImg.frame.maxX - 15, height: searchBGView.bounds.height)
        searchTxt.center.y = searchBGView.center.y
        
        contentView.addSubview(cancelBtn)
        cancelBtn.frame = CGRect(x: searchBGView.frame.maxX, y: 0, width: SCREEN_WIDTH - searchBGView.frame.maxX, height: cancelBtn.bounds.height)
        cancelBtn.center.y = searchBGView.center.y
        
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: contentView.frame.maxY, width: tableView.bounds.width, height: tableView.bounds.height)
        view.addSubview(collctionView)
        collctionView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView)
            make.left.equalTo(self.view).offset(12)
            make.right.equalTo(self.view).offset(-12)
            make.bottom.equalTo(tableView)
        }
        //        collctionView.frame = CGRect(x: 0, y: contentView.frame.maxY, width: tableView.bounds.width, height: tableView.bounds.height)
        
    }
    
    // MARK: - event
    /// 右按钮事件
    @objc func cancelBtnEvent(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 输入字符
    @objc func editingChanged(_ sender: UITextField) {
        guard let text = searchTxt.text else { return }
        if text.isEmpty {
            ///刷新历史
            getProductItemHotPath()
            tableView.isHidden = true
            collctionView.isHidden = false
        } else {
            /// 根据输入查数据
            reloadData()
            tableView.isHidden = false
            collctionView.isHidden = true
        }
    }
    
    // MARK: - 数据
    /// 刷新数据
    @objc func reloadData() {
        pageIndex = 1
        getProductItemList()
    }
    
    /// 加载更多数据
    @objc func getMoreData() {
        pageIndex = pageIndex + 1
        getProductItemList()
    }
    
    /// 贷款大全
    @objc func getProductItemList() {
        guard let text = searchTxt.text else { return }
        
        let params = ["pageNo": pageIndex,
                      "name": text] as [String : Any]
        let paramsDic = params as NSDictionary
        let paramsMDic = NSMutableDictionary(dictionary: paramsDic)
        ProductItemViewModel.productItemListPath(productItemListPath, params: paramsMDic, target: self, success: { (model) in
            if model.code == 200 {
                //埋点
                SensorsAnalyticsSDKHelper.searchEvent(searchCount: model.totalCount, searchContent: text)
                
                if self.pageIndex == 1 {
                    self.productItemList = model.result as! [ProductItemModel]
                    self.tableView.mj_header.endRefreshing()
                    self.tableView.reloadData()
                } else {
                    if model.result.count == 0 {
                        self.tableView.mj_footer.state = .noMoreData
                    } else {
                        self.productItemList += model.result as! [ProductItemModel]
                        self.tableView.mj_footer.endRefreshing()
                    }
                }
            }
        }) { (error) in
            
        }
    }
    
    /// 热门搜索
    @objc func getProductItemHotPath() {
        ProductItemViewModel.productItemHotPath(productItemHotPath, params: NSMutableDictionary(), target: self, success: { (modelList) in
            if modelList.code == 200 {
                self.productItemHotList = modelList
                self.collctionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    /// 获取浏览记录
    func getHistory() {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path += "/productItemHistoryList.plist"
        if let list = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? ProductItemHistoryListModel {
            productItemHistoryList = list
        }
    }
    
    /// 删除浏览记录
    func deleteHistory() {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path += "/productItemHistoryList.plist"
        
        if FileManager.default.fileExists(atPath: path){
            productItemHistoryList = ProductItemHistoryListModel()
            collctionView.reloadData()
            try? FileManager.default.removeItem(atPath: path)
        }
        
    }
    
    /// 删除某条记录
    func deleteHistory(_ mchId: String) {
        var tempProductItemHistoryList = ProductItemHistoryListModel()
        //剔除这条记录
        for model in productItemHistoryList.list {
            if let model = model as? ProductItemHistoryModel{
                if model.mchId == mchId{
                    continue
                } else {
                    tempProductItemHistoryList.list.append(model)
                }
            }
        }
        productItemHistoryList = tempProductItemHistoryList
        //保存数据
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path+="/productItemHistoryList.plist"
        print("路径："+path);
        
        NSKeyedArchiver.archiveRootObject(productItemHistoryList, toFile: path)
        
    }
}


extension ProductItemSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        let model = self.productItemList[indexPath.row]
        cell.textLabel?.text = model.name
        cell.imageView?.image = UIImage(named: "search")
        return cell;
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * SuitParm
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转到web
        let webView = AdWebViewController()
        let model = productItemList[indexPath.row]
        
        
        SensorsAnalyticsSDKHelper.merchantClick(mchId: model.merchartid, mchName: model.name, position: "搜索-列表", sort: "\(indexPath.row + 1)")
        
        webView.showWeb(withURL: model.url
            , andProductIcon: model.icon
            , andProductMaxAmount: model.maxAmount
            , andProductMerchartid: model.merchartid
            , andProductName: model.name
            , andProductTags: model.tags
            , andProductTitle: model.title
            , andProductUrl: model.url
            , andFromPosition: "贷款大全-搜索\(indexPath.row+1)"
            , andIsNeedSaveHistory: true
            , withSuperController: self)
        
        
        //保存这个id到本地
        let productItemModel = productItemList[indexPath.row];
        //判断不重复添加
        for model in productItemHistoryList.list {
            if let model = model as? ProductItemHistoryModel{
                if model.mchId == productItemModel.merchartid{
                    return//重复了就不保存了
                }
            }
        }
        
        let historyModel = ProductItemHistoryModel()
        historyModel.searchKey = productItemModel.name
        historyModel.mchId = productItemModel.merchartid
        historyModel.mchName = productItemModel.name
        historyModel.rate = ""
        historyModel.maxAmount = productItemModel.maxAmount
        historyModel.referType = ""
        historyModel.minAmount = ""
        historyModel.recommendReason = ""
        historyModel.rateType = ""
        historyModel.icon = productItemModel.icon
        historyModel.url = productItemModel.url
        
        productItemHistoryList.list.append(historyModel)
        
        //保存数据
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path+="/productItemHistoryList.plist"
        print("路径："+path);
        
        NSKeyedArchiver.archiveRootObject(productItemHistoryList, toFile: path)
        
    }
}

extension ProductItemSearchVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if productItemHistoryList.list.count == 0{
            return 1
        } else {
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return productItemHotList.list.count
        } else if section == 1 {
            return productItemHistoryList.list.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemSearchCell", for: indexPath) as! ProductItemSearchCell
        
        if indexPath.section == 0 {
            let model = productItemHotList.list[indexPath.item] as! ProductItemHistoryModel
            cell.titleLbl.text = model.searchKey
        } else if indexPath.section == 1 {
            let model = productItemHistoryList.list[indexPath.item] as! ProductItemHistoryModel
            cell.titleLbl.text = model.searchKey
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductItemSearchHeader", for: indexPath) as! ProductItemSearchHeader
        if indexPath.section == 0 {
            header.isHiddenCloseBtn = true
            header.titleLbl.text = "热门搜索"
        } else if indexPath.section == 1 {
            header.isHiddenCloseBtn = false
            header.titleLbl.text = "搜索历史"
            header.deleteClosure = {
                self.deleteHistory()
            }
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var model = ProductItemHistoryModel()
        var clickPosition = ""
        var position = ""
        if indexPath.section == 0 {
            model = productItemHotList.list[indexPath.item] as! ProductItemHistoryModel
            //点击热搜需要保存记录
            //保存这个id到本地
            //判断不重复添加
            var needAppend = true
            for historyModel in productItemHistoryList.list {
                if let historyModel = historyModel as? ProductItemHistoryModel{
                    if historyModel.searchKey == model.searchKey &&
                        historyModel.mchId == model.mchId &&
                        historyModel.url == model.url{
                        needAppend = false
                        break//重复了就不保存了
                    }
                }
            }
            
            if needAppend {
                productItemHistoryList.list.append(model)
            }
            
            //保存数据
            var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            path+="/productItemHistoryList.plist"
            print("路径："+path);
            
            NSKeyedArchiver.archiveRootObject(productItemHistoryList, toFile: path)
            
            //点击埋点位置
            clickPosition = "热门搜索";
            
            //记录加载完成埋点位置
            position = "贷款大全-热搜\(indexPath.item+1)"
            
            //神策点击埋点
            if model.mchId != "" && model.mchName != "" {
                SensorsAnalyticsSDKHelper.merchantClick(mchId: model.mchId, mchName: model.mchName, position: clickPosition, sort: "\(indexPath.item + 1)")
            }
            
            let webView = AdWebViewController()
            webView.showWeb(withURL: model.url
                , andProductIcon: model.icon
                , andProductMaxAmount: model.maxAmount
                , andProductMerchartid: model.mchId
                , andProductName: model.mchName
                , andProductTags: ""
                , andProductTitle: ""
                , andProductUrl: model.url
                , andFromPosition: position
                , andIsNeedSaveHistory: false
                , withSuperController: self)
            
            
        } else if indexPath.section == 1 {
            model = productItemHistoryList.list[indexPath.item] as! ProductItemHistoryModel
            
            let path = "/mch/\(model.mchId)"
            UserViewModel.checkMchStatusPath(path, params: nil, target: nil, success: { (result) in
                if result?.code == 200 {
                    //如果接口返回判定为下线的商户,那么删除这条记录
                    if result?.status == 1 {
                        //没有下线
                    } else {
                        //已下线,提示信息
                        ZXAlertView.share()?.showMessage(result?.toast)
                        
                        //删除记录
                        self.deleteHistory(model.mchId)
                        //刷新
                        self.collctionView.reloadData()
                        return
                    }
                }
                //点击埋点位置
                clickPosition = "搜索历史";
                
                //记录加载完成埋点位置
                position = "贷款大全-搜索历史\(indexPath.item+1)"
                
                //神策点击埋点
                if model.mchId != "" && model.mchName != "" {
                    SensorsAnalyticsSDKHelper.merchantClick(mchId: model.mchId, mchName: model.mchName, position: clickPosition, sort: "\(indexPath.item + 1)")
                }
                
                let webView = AdWebViewController()
                webView.showWeb(withURL: model.url
                    , andProductIcon: model.icon
                    , andProductMaxAmount: model.maxAmount
                    , andProductMerchartid: model.mchId
                    , andProductName: model.mchName
                    , andProductTags: ""
                    , andProductTitle: ""
                    , andProductUrl: model.url
                    , andFromPosition: position
                    , andIsNeedSaveHistory: false
                    , withSuperController: self)
                
            }, failure: { (error) in
                return
            })
        }
        
       
    }
    
}

extension ProductItemSearchVC: DZNEmptyDataSetSource{
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        return NSAttributedString(string: "暂无相关产品")
    }
    
    
    //显示的图案
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "noData")
    }
    
}
