//
//  FoodListVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit


class FoodListVC: UIViewController, WormTabStripDelegate, ProductListVCDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UIBarButtonItem!
    weak var productListVC: ProductListVC?
    var viewPager: WormTabStrip?
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblCart: UILabel!
    @IBOutlet weak var viewShowBtn: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchBorder: UILabel!
    @IBOutlet weak var searchTextF: UITextField!
    
    var tabs:[ProductListVC] = []
    var cartItems = [ProductItem]()
    
    public static var __shared : FoodListVC?
    
    var tabTitles: [String] = ["Pizza", "Combo", "Sides", "Veberage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        self.view.backgroundColor = UIColor(netHex: 0x364756)
        let logo = UIImage(named: "ic_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyBoard))
        view.addGestureRecognizer(tapGesture)
        hidekeyBoard()
        setUpTabs()
        FoodListVC.__shared = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCartItem(notification:)), name: Notification.Name("added_cart"), object: nil)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.viewShowBtn.addGestureRecognizer(gesture)

        setUpCartItems()
        
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if cartItems.count == 0 {
                   showToast(message: "No items")
               } else {
                   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   appDelegate.goToTabBarScreen(index: 3)
               }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpViewPager()
        for tab in tabs {
            tab.delegate = self
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5) {
            self.searchBorder.backgroundColor = .darkGray
        }
    }
    
    @objc func hidekeyBoard() {
        view.endEditing(true)
    }
    @IBAction func searchDisable(_ sender: Any) {
        searchView.isHidden = true
        searchTextF.text = nil
        view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        setUpCartItems()
        self.navigationController?.navigationBar.isHidden = true
        self.searchView.isHidden = true //self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func setUpCartItems() {
        cartItems = AppConstants.getCartItems()
        if cartItems.count > 0{
            viewShowBtn.isHidden =  false
        } else {
            viewShowBtn.isHidden = true
        }
        
        var sum_price = Float(0.0)
        var sum_count = 0
        for item in cartItems {
            sum_price += item.getPrice() * Float(item.getCount())
            sum_count += item.getCount()
        }
        lblCart.text = "\(sum_count) Item : $\(String(format: "%.2f", sum_price))"
        
        let orderItemData = AppConstants.getCartItems()
        if orderItemData.isEmpty == false {
        if let tabItems = tabBarController?.tabBar.items {
            
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[3]
            tabItem.badgeValue = String(sum_count)
        }
        } else {
            if let tabItems = tabBarController?.tabBar.items {
                
                // In this case we want to modify the badge number of the third tab:
                let tabItem = tabItems[3]
                tabItem.badgeValue = nil
            }
        }
    }
    
    func shouldHideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBorder.backgroundColor = UIColor(red: 0, green: 174, blue: 239)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        searchBorder.backgroundColor = .gray
        textField.text = nil
        searchView.isHidden = true
        
        UIView.animate(withDuration: 1.5) {
            self.searchBorder.backgroundColor = .darkGray
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        searchView.isHidden = false
        searchTextF.becomeFirstResponder()
        UIView.animate(withDuration: 1.5) {
            self.searchBorder.backgroundColor = .blue
        }
    }
    
    @IBAction func contactVc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: 0, width: viewMain.frame.size.width, height: viewMain.frame.size.height)
        viewPager = WormTabStrip(frame: frame)
        viewMain.addSubview(viewPager!)
        viewPager!.delegate = self
        viewPager!.eyStyle.wormStyel = .BUBBLE
        viewPager!.eyStyle.isWormEnable = false
        viewPager!.eyStyle.spacingBetweenTabs = 0
        viewPager!.eyStyle.tabItemSelectedColor = UIColor.init(red: 0, green: 174, blue: 239)
        viewPager!.eyStyle.tabItemDefaultFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)!
        viewPager!.currentTabIndex = 0
        viewPager!.buildUI()
    }
//
    func setUpTabs(){
        for i in 1...tabTitles.count {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "productListVC") as! ProductListVC
            vc.delegate = self

            //            var rect = vc.view.frame
            //            rect.width = viewMain.bounds.width
            //            rect.height = viewMain.bounds.height
            //            vc.view.frame = rect
            tabs.append(vc)
        }
    }
//
    func WTSNumberOfTabs() -> Int {
        return tabTitles.count
    }

    func WTSViewOfTab(index: Int) -> UIView {
        let view = tabs[index]
        return view.view
    }

    func WTSTitleForTab(index: Int) -> String {
        return tabTitles[index]
    }

    func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {

    }

    func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {

    }
    
    @objc func addCartItem(notification: NSNotification) {
        cartItems = AppConstants.getCartItems()
        var sum_price = Float(0.0)
        var sum_count = 0
        for item in cartItems {
            sum_price += item.getPrice() * Float(item.getCount())
            sum_count += item.getCount()
        }
        lblCart.text = "\(sum_count) Item : $\(String(format: "%.2f", sum_price))"
    }
    
    @IBAction func viewCartClicked(_ sender: Any) {
        if cartItems.count == 0 {
            showToast(message: "No items")
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.goToTabBarScreen(index: 3)
        }
    }
    
  
}
