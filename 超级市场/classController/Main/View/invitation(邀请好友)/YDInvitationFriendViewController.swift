//
//  YDInvitationFriendViewController.swift
//  超级市场
//
//  Created by 王林峰 on 2019/12/7.
//  Copyright © 2019 王林峰. All rights reserved.
//

import UIKit
import LTScrollView
enum LDShareType {
    case Session, Timeline, Favorite/*会话, 朋友圈, 收藏*/
}
class YDInvitationFriendViewController: YDBasicViewController {
    private lazy var headerView:YDInvitationHeaderView = {
        let view = YDInvitationHeaderView.init(frame: CGRect(x:0, y:0, width:LBFMScreenWidth, height:472))
        view.backgroundColor = UIColor.white
        view.delegate = self
        return view
    }()
    
    private let oneVc = YDInvitationRecordViewController()
    private let twoVc = YDSucceedInvitationViewController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc]
    }()
    
    private lazy var titles: [String] = {
        return ["邀请记录", "已成功邀请"]
    }()
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.isNeedScale = false
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 153, g: 153, b: 153)
        layout.titleSelectColor = YDLabelColor
        layout.bottomLineColor = YDLabelColor
        layout.sliderHeight = 44
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y:LBFMNavBarHeight, width: LBFMScreenWidth, height: LBFMScreenHeight + LBFMNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        advancedManager.hoverY = 0
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "邀请有礼"
        requestSearchGoodsDate()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }
    lazy var invitationFriendModel: YDInvitationFriendViewModel = {
        return YDInvitationFriendViewModel()
    }()
    func requestSearchGoodsDate(){
        // 加载数据
        invitationFriendModel.updateDataBlock = { [unowned self] in
            self.headerView.invitePresentModel = self.invitationFriendModel.inviteHeaderInfoModel
        }
        invitationFriendModel.refreshInvitationFriendList(token: UserDefaults.LoginInfo.string(forKey: .token)!, memberPhone: UserDefaults.LoginInfo.string(forKey: .phone)!)
    }
    func shareURL(to scene: LDShareType) {
//        Data(contentsOf: URL(string:invitationFriendModel.inviteHeaderInfoModel?.image ?? "")
        let message = WXMediaMessage()
        message.title = invitationFriendModel.inviteHeaderInfoModel?.title ?? ""
        message.description = invitationFriendModel.inviteHeaderInfoModel?.content ?? ""
        let url = URL(string:invitationFriendModel.inviteHeaderInfoModel?.image ?? "")
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)!
            message.setThumbImage(image)
        }catch let error as NSError {
            print(error)
        }
        let obj = WXWebpageObject()
        obj.webpageUrl = invitationFriendModel.inviteHeaderInfoModel?.shareUrl ?? ""
        message.mediaObject = obj
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        
        switch scene {
        case .Session:
            req.scene = Int32(WXSceneSession.rawValue)
        case .Timeline:
            req.scene = Int32(WXSceneTimeline.rawValue)
        case .Favorite:
            req.scene = Int32(WXSceneFavorite.rawValue)
        }
        
        WXApi.send(req)
    }
    
}

extension YDInvitationFriendViewController : YDInvitationHeaderViewDelegate{
//    邀请好友
    func selectInvitationFriendHeaderView() {
       shareURL(to: LDShareType.Session)
    }
//    分享到朋友圈
    func selectInvitationCircleFriendHeaderView() {
        shareURL(to: LDShareType.Timeline)
    }
    
    func selectInvitationFriendCodeHeaderView() {
        let weChatVc = YDInvitationCodeViewController()
        weChatVc.imageCode = invitationFriendModel.inviteLinkmanModel?.qrcode ?? ""
        weChatVc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        if #available(iOS 13.0, *) {
            weChatVc.modalPresentationStyle = .custom
        } else {
                                                                                            // Fallback on earlier versions
        }
        weChatVc.modalTransitionStyle = .crossDissolve
        self.present(weChatVc,animated:true,completion:nil)
    }
    
    
}
extension YDInvitationFriendViewController : LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
}
