//
//  YDLocationViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/8/13.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import CoreLocation  //导入定位核心库

class YDLocationViewController: YDBasicViewController,AMapLocationManagerDelegate {
    let locationManager = AMapLocationManager()
    let locationManager1 = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()


        self.locationManager1.requestWhenInUseAuthorization()           //弹出用户授权对话框，使用程序期间授权（ios8后)
        self.locationManager1.requestAlwaysAuthorization()                            //始终授权
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 2
        locationManager.reGeocodeTimeout = 2
        self.locationManager.requestLocation(withReGeocode: true) { (location, regeocode, error) in
            
                                    if (error == nil){
                                print("regeocode:%@", regeocode)
//                                                self.currentCityBtn.setTitle(regeocode.city, forState: .Normal)
//
//                                                self.location = location
//
//                                                self.keyWord = regeocode.city
//
//                                                print(location.coordinate.longitude ?? 0.00)
//
//                                                print(location.coordinate.latitude ?? 0.00)
//
//                                                //MARK:根据关键词搜索周边地理位置信息
                
                                                
                
                                        }
            
                            }
    }
//        locationManager.requestLocation(withReGeocode: false, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
//
//            if let error = error {
//                let error = error as NSError
//
//                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
//                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
//                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
//                    return
//                }else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
//                    || error.code == AMapLocationErrorCode.timeOut.rawValue
//                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
//                    || error.code == AMapLocationErrorCode.badURL.rawValue
//                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
//                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
//
//                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
//                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
//                }else {
//                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
//                }
//            }
//
//            if let location = location {
//                print("location:%@", location)
//            }
//
//            if let reGeocode = reGeocode {
//                print("reGeocode:%@", reGeocode)
//            }
//        })
    }
   
    





