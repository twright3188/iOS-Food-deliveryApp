//
//  OrderPlacingVC.swift
//  DeliveryApp
//
//  Created by kh on 8/14/19.
//  Copyright © 2019 dbug-mac. All rights reserved.
//

import UIKit

class OrderPlacingVC: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSelectSize: UILabel!
    @IBOutlet weak var barSelectSize: UIView!
    @IBOutlet weak var lblSelectCrust: UILabel!
    @IBOutlet weak var barSelectCrust: UIView!
    @IBOutlet weak var lblSelectTopics: UILabel!
    @IBOutlet weak var barSelectTopics: UIView!
    
    @IBOutlet weak var largePriceView: UIView!
    @IBOutlet weak var mediumPriceView: UIView!
    @IBOutlet weak var smallPriceView: UIView!
    @IBOutlet weak var lblMedium: UILabel!
    @IBOutlet weak var lblMediumPrice: UILabel!
    @IBOutlet weak var lblLarge: UILabel!
    @IBOutlet weak var lblLargePrice: UILabel!
    @IBOutlet weak var lblSmall: UILabel!
    @IBOutlet weak var lblSmallPrice: UILabel!
    @IBOutlet weak var lblCart: UILabel!
    
    @IBOutlet weak var selectSizeView: UIStackView!
    
    @IBOutlet weak var topicCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cartPriceView: UIView!
    @IBOutlet weak var cartPriceBottomConstraint: NSLayoutConstraint!
    
    
    var count = 1
    var price = 5.99
    var select_type = 0
    var select_price = 1
    var selectedProduct: ProductItem!
    var cartItems = [ProductItem]()
    var selectCrust = ["Cheesy", "Normal", "Saussage","Italian"]
    var selecttopics = ["Tomato", "Corn", "Jalapenos", "Pineapple", "Pepperoni"]
    var cellText:[String] = [""]
    var topicRateText:[Double] = [2.99,5.67,7.43,10.99,1.90]
    let CrustRateText = [9.99,5.67,3.49,8.99]
    var CrustRate:Double = 0
    var TopicsRate:Double = 0
    var index:IndexPath?
    var index2:IndexPath?
    var selectedIndex:Int?
    var cellIndex = [IndexPath]()
    var xDictionaryList: [Int:Int] = [:]
    var totalPrice: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = true
        topicCollectionView.isHidden = true
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        lblCount.text = "\(count)"
        setUpCartPrice(price: 5.99*Float(count))
                
        updateSelctViews()
        updateSelectPriceViews()
        setUpCartItems()
    }
    
    private func setUpCartItems() {
        cartItems = AppConstants.getCartItems()
        var sum_price = Float(0.0)
        var sum_count = 0
        for item in cartItems {
            sum_price += item.getPrice() * Float(item.getCount())
            sum_count += item.getCount()
        }
        lblCart.text = "\(sum_count) Item : $\(String(format: "%.2f", sum_price))"
        
        let cartHeight = sum_price == 0 ? 65 : 0
        self.cartPriceView.isHidden = cartHeight != 0
        self.cartPriceBottomConstraint.constant = CGFloat(cartHeight)
    }
    
    private func setUpCartPrice(price: Float) {
        lblPrice.text = "$" + String(format: "%.2f", price)
        totalPrice = price
       
    }

    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSizePressed(_ sender: Any) {
        collectionView.isHidden = true
        topicCollectionView.isHidden = true
        select_type = 0
        updateSelctViews()
    }
    
    @IBAction func selectCrustPressed(_ sender: Any) {
        collectionView.isHidden = false
        topicCollectionView.isHidden = true
        cellText = selectCrust
        select_type = 1
        updateSelctViews()
        //collectionView.reloadData()
    }
    
    @IBAction func selectTopicsPressed(_ sender: Any) {
        collectionView.isHidden = true
        topicCollectionView.isHidden = false
        cellText = selecttopics
        select_type = 2
        updateSelctViews()
        //collectionView.reloadData()
    }
    
    @IBAction func increasePressed(_ sender: Any) {
        count += 1
        selectedProduct.setCount(count: count)
        lblCount.text = "\(count)"
        let totalPrice = (price + TopicsRate + CrustRate)
        setUpCartPrice(price: Float(totalPrice)*Float(count))
    }
    
    @IBAction func decreasePressed(_ sender: Any) {
        if count > 1 {
            count -= 1
            selectedProduct.setCount(count: count)
            lblCount.text = "0" //"\(count)"
            let totalPrice = (price + TopicsRate + CrustRate)
            setUpCartPrice(price: Float(totalPrice)*Float(count))
            
        }
        
        
    }
    
    @IBAction func mediumPricePressed(_ sender: Any) {
        selectedProduct.size = 1
        select_price = 1
        updateSelectPriceViews()
        price = 5.99
        selectedProduct.setPrice(price: Float(price))
        let totalRate = Float(price + TopicsRate + CrustRate)
        setUpCartPrice(price: totalRate)

    }
    
    @IBAction func largePricePressed(_ sender: Any) {
        selectedProduct.size = 2
        select_price = 2
        updateSelectPriceViews()
        price = 7.99
        selectedProduct.setPrice(price: Float(price))
        let totalRate = Float(price + TopicsRate + CrustRate)
        setUpCartPrice(price: totalRate)
    }
    
    @IBAction func smallPricePressed(_ sender: Any) {
        selectedProduct.size = 0
        select_price = 0
        updateSelectPriceViews()
        price = 4.99
        selectedProduct.setPrice(price: Float(price))
        let totalRate = Float(price + TopicsRate + CrustRate)
        setUpCartPrice(price: totalRate)
    }
    
    func showTost(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-150, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
       
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        
        if CrustRate == 0 {
            print("select your crust rate & topicsRate")
            showTost(message: "Select Your Crust")
            
        } else if TopicsRate == 0 {
           showTost(message: "Select Your Topics")
        } else {
            var cartItems: [ProductItem] = []
            selectedProduct.price = Float(price + TopicsRate + CrustRate)
            selectedProduct.setCount(count: count)
            
            var isUpdated = false
            for item in AppConstants.getCartItems() {
                if item.itemID == selectedProduct.itemID && item.size == selectedProduct.size && item.crust == selectedProduct.crust && item.topic == selectedProduct.topic {
                    let newItem = item
                    newItem.count = item.count + selectedProduct.count
                    cartItems.append(newItem)
                    isUpdated = true
                } else {
                    cartItems.append(item)
                }
            }
            if !isUpdated {
                cartItems.append(selectedProduct)
            }
                    
            var jsonDict = [[String: Any]]()
            for child in cartItems {
                child.setDate(date: Date())
                jsonDict.append(child.toDictionary())
            }
        
            LocalStorage[SAVED_CARTS] = jsonDict

            var sum_price = Float(0.0)
            var sum_count = 0
            for item in cartItems {
                sum_price += item.getPrice() * Float(item.getCount())
                sum_count += item.getCount()
            }
            lblCart.text = "\(sum_count) Item : $\(String(format: "%.2f", sum_price))"
            
            let cartHeight = sum_price == 0 ? 65 : 0
            self.cartPriceView.isHidden = cartHeight != 0
            UIView.animate(withDuration: 0.5) {
                self.cartPriceBottomConstraint.constant = CGFloat(cartHeight)
                self.view.layoutIfNeeded()
            }

            if let tabItems = tabBarController?.tabBar.items {
                       // In this case we want to modify the badge number of the third tab:
                       let tabItem = tabItems[3]
                       tabItem.badgeValue = String(sum_count)
                   }
            showToast(message: "Added to cart")
          
        }
        
    }
    
    @IBAction func viewCartClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goToTabBarScreen(index: 3)
    }
    
    
    private func updateSelctViews() {
        switch select_type {
        case 0:
            lblSelectSize.textColor = UIColor.init(red: 0, green: 174, blue: 239)
            selectSizeView.isHidden = false
            lblSelectCrust.textColor = UIColor.black
            lblSelectTopics.textColor = UIColor.black
            lblSelectSize.font = UIFont.boldSystemFont(ofSize: 16.0)
            lblSelectCrust.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectTopics.font = UIFont.systemFont(ofSize: 16.0)
            barSelectSize.isHidden = false
            barSelectCrust.isHidden = true
            barSelectTopics.isHidden = true
            break
        case 1:
            selectSizeView.isHidden = true
            lblSelectSize.textColor = UIColor.black
            lblSelectCrust.textColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSelectTopics.textColor = UIColor.black
            lblSelectSize.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectCrust.font = UIFont.boldSystemFont(ofSize: 16.0)
            lblSelectTopics.font = UIFont.systemFont(ofSize: 16.0)
            barSelectSize.isHidden = true
            barSelectCrust.isHidden = false
            barSelectTopics.isHidden = true
            break
        case 2:
            selectSizeView.isHidden = true
            lblSelectSize.textColor = UIColor.black
            lblSelectCrust.textColor = UIColor.black
            lblSelectTopics.textColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSelectSize.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectCrust.font = UIFont.systemFont(ofSize: 16.0)
            lblSelectTopics.font = UIFont.boldSystemFont(ofSize: 16.0)
            barSelectSize.isHidden = true
            barSelectCrust.isHidden = true
            barSelectTopics.isHidden = false
            break
        default:
            break
        }
    }
    
    private func updateSelectPriceViews() {
        switch select_price {
        case 0:
            smallPriceView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            mediumPriceView.backgroundColor = UIColor.white
            largePriceView.backgroundColor = UIColor.white
            lblSmall.textColor = UIColor.white
            lblMedium.textColor = UIColor.black
            lblLarge.textColor = UIColor.black
            lblSmallPrice.textColor = UIColor.white
            lblMediumPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblLargePrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            break
        case 1:
            smallPriceView.backgroundColor = UIColor.white
            mediumPriceView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            largePriceView.backgroundColor = UIColor.white
            lblSmall.textColor = UIColor.black
            lblMedium.textColor = UIColor.white
            lblLarge.textColor = UIColor.black
            lblSmallPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblMediumPrice.textColor = UIColor.white
            lblLargePrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            break
        case 2:
            smallPriceView.backgroundColor = UIColor.white
            mediumPriceView.backgroundColor = UIColor.white
            largePriceView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            lblSmall.textColor = UIColor.black
            lblMedium.textColor = UIColor.black
            lblLarge.textColor = UIColor.white
            lblSmallPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblMediumPrice.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            lblLargePrice.textColor = UIColor.white
            break
        default:
            break
        }
    }
}

extension OrderPlacingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topicCollectionView {
            return selecttopics.count
        }
        return selectCrust.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        index2 = index
        if collectionView == topicCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? OrderPlacingCellTwo
        cell?.cellTextLabel.text = selecttopics[indexPath.row]
        cell!.cellRateLabel.text = "$\(topicRateText[indexPath.row])"
        //cell?.cellView.backgroundColor = UIColor.white
        //cell?.cellRateLabel.textColor = UIColor.init(red: 38, green: 181, blue: 15)
        //cell?.cellTextLabel.textColor = .black
       cell?.cellWidthConstraintLayout.constant = collectionView.frame.size.width / 3.0 - 10

        return cell!
        }
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OrderPlacingVCCell
         cell?.cellTextLabel.text = selectCrust[indexPath.row]
         cell!.cellPriceLabel.text = "$\(CrustRateText[indexPath.row])"
         cell?.cellView.backgroundColor = UIColor.white
         cell?.cellPriceLabel.textColor = UIColor.init(red: 38, green: 181, blue: 15)
         cell?.cellTextLabel.textColor = .black
        cell?.cellWidthConstraintLayout.constant = collectionView.frame.size.width / 3.0 - 10
        cell?.layoutIfNeeded()
        
         return cell!
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? OrderPlacingCellTwo {
            
            cell.cellXLabel.isHidden = true

            if select_type == 2 {
                
                if cellIndex.contains(indexPath) && (xDictionaryList[indexPath.row] == 2) {
                    cell.cellView.backgroundColor = .white
                    cell.cellRateLabel.textColor = UIColor.init(red: 38, green: 181, blue: 15)
                    cell.cellTextLabel.textColor = .black
                    let index = cellIndex.index(of: indexPath)
                    TopicsRate = TopicsRate - topicRateText[indexPath.row]
                    let roundValue = price + TopicsRate + CrustRate
                    setUpCartPrice(price: Float(roundValue))
                    cellIndex.remove(at: index!)
                    xDictionaryList.removeValue(forKey: indexPath.row)
                    
                    var newTopic = selectedProduct.topic
                    newTopic[indexPath.row] = 0
                    selectedProduct.topic = newTopic
                } else {
                        
                    cell.cellView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
                    cell.cellRateLabel.textColor = .white
                    cell.cellTextLabel.textColor = .white
                    cell.cellXLabel.textColor = .white
                    cell.cellXLabel.isHidden = false

                    cellIndex = []
                    cellIndex.append(indexPath)
                    TopicsRate = TopicsRate + topicRateText[indexPath.row]
                    let roundValue = price + TopicsRate + CrustRate
                    setUpCartPrice(price: Float(roundValue))

                    var xValue: Int = xDictionaryList[indexPath.row] ?? 0
                    xValue += 1
                    xDictionaryList[indexPath.row] = xValue
                    
                    cell.cellXLabel.text = "(X\(xValue))"
                    
                    var newTopic = selectedProduct.topic
                    newTopic[indexPath.row] = xValue
                    selectedProduct.topic = newTopic
                }
                
            }
            
        }
       
        if let cell = collectionView.cellForItem(at: indexPath) as? OrderPlacingVCCell {
            
            cell.cellView.backgroundColor = UIColor.init(red: 0, green: 174, blue: 239)
            cell.cellPriceLabel.textColor = .white
            cell.cellTextLabel.textColor = .white
                CrustRate = CrustRateText[indexPath.row]
            let roundValue = price + TopicsRate + CrustRate
            setUpCartPrice(price: Float(roundValue))
            selectedProduct.crust = indexPath.row
        }
        print("click")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? OrderPlacingCellTwo {
//            cell.cellView.backgroundColor = .white
//            cell.cellRateLabel.textColor = UIColor.init(red: 38, green: 181, blue: 15)
//            cell.cellTextLabel.textColor = .black
//        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? OrderPlacingVCCell {
            cell.cellView.backgroundColor = .white
            cell.cellPriceLabel.textColor = UIColor.init(red: 38, green: 181, blue: 15)
            cell.cellTextLabel.textColor = .black
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3.0, height: collectionView.frame.size.height)
    }
}
