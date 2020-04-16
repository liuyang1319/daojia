//
//  YDCollectGoodsListModel.swift
//  超级市场
//
//  Created by 王林峰 on 2019/9/9.
//  Copyright © 2019 王林峰. All rights reserved.
//

import Foundation
import HandyJSON
struct YDCollectGoodsListModel: HandyJSON {
    var id:String?
    var name:String?
    var title:String?
    var salePrice:Double?
    var formalPrice:Double?
    var imageUrl:String?
    var status:String?
    var code:String?
    var goodsId:String?
    var isSelect:Bool?
    var isShow:Bool?
}
struct YDOrderGoodsListModel: HandyJSON {
    var supplierImg:String?
    var status:String?
    var countsum:Double?
    var orderNum:String?
    var type:String?
    var creatAt:String?
    var supplierName:String?
    var count:String?
    var imageUrl:String?
    var name:String?
    var memberId:String?
    var payType:String?
    var refundStatus:String?
}
struct YDOrderAllGoodsListModel : HandyJSON{
    var list:[YDOrderGoodsListModel]?
    var creatAt:String?
    var status:String?
    var orderNum:String?
    var memberId:String?
    var payType:String?
}

struct YDOrderGoodsInfoModel: HandyJSON {
    var orderDetails:YDOrderorderDetailsModel?
    var orderDetailGoods:[YDorderDetailGoodsModel]?
}



struct YDOrderorderDetailsModel: HandyJSON {
    var addressRegion:String?
    var deliveryName:String?
    var userContent:String?
    var addressName:String?
    var creatAt:String?
    var sendPrice:Double?
    var status:String?
    var supplierImg:String?
    var expectedTime:String?
    var packPrice:Double?
    var addressPhone:String?
    var supplierName:String?
    var countSum:Double?
    var invoicePayable:String?
    var count:String?
    var deliveryPhone:String?
    var orderNum:String?
    var weightPrice:Double?
    var goodsImage:String?
    var addressId:String?
    var street:String?
    var doorNumber:String?
    var expectTime:String?
    var cheapPrice:Double?
    var couponPrice:Double?
    var refundStatus:String?
    var cancelReason:String?
    var completeReason :String?
}
struct YDorderDetailGoodsModel: HandyJSON {
    var imageUrl:String?
    var goodsName:String?
    var weight:String?
    var salePrice:Double?
    var unitName:String?
    var goodsCode:String?
    var count:Int?
    var isSelectGoods:Bool?
    var isShow:Bool?
    var refundStatus:String?
    var goodsId:String?
}
struct YDCouponDetailGoodsModel: HandyJSON {
    var type:String? //1.满减券2.代金券3.免邮券
    var price:String?
    var minOrderPrice:String?
    var startTime:String?
    var endTime:String?
    var status:String?
    var imageUrl:String?
    var cornerLabel:String?
    var couponId:String?
    
}
struct YDIntegralListGoodsModel: HandyJSON {
    var count:String?
    var integralList:[YDIntegralGoodsModel]?
}
struct YDIntegralGoodsModel: HandyJSON {
    var status:String?
    var memberId:String?
    var score:String?
    var creatTime:String?
}

struct YDCommentListGoodsModel: HandyJSON {
    var driverAble:[YDDriverAbleCommentModel]?
    var goodsLists:[YDGoodsListCommentModel]?
    var goodsAble:[YDGoodsAbleCommentModel]?
    var driverInfo:YDDriverInfoCommentModel?
    
}
struct YDDriverAbleCommentModel: HandyJSON {
    var name:String?
    var creatAt:String?
    var id:String?
    var goodsCode:String?
    var tr:String?
    var type:String?
    var estimateName:String?
    var ts:String?
    var level:String?
}
struct YDGoodsListCommentModel: HandyJSON {
    var goodsCode:String?
    var creatAt:String?
    var devel:String?
    var goodsImage:String?
    var goodsName:String?
}
struct YDGoodsAbleCommentModel: HandyJSON {
    var name:String?
    var id:String?
    var creatAt:String?
    var goodsCode:String?
    var tr:String?
    var type:String?
    var estimateName:String?
    var ts:String?
    var level:String?
    var isSelectLab: Bool = true
}

struct YDDriverInfoCommentModel: HandyJSON {
    var deliveryName:String?
    var headImg:String?
    var sendTime:String?
}
//添加评论
struct YDAddGoodsComment:HandyJSON{
    var orderNum:String?
    var level:String?
    var able:String?
    var estimateList:[YDSelectUpudatComment]?
}
//  评论内容
struct YDSelectUpudatComment:HandyJSON{
     var goodsDevel:String?
     var estimateId:String?
     var goodsContent:String?
     var goodsImage:String?
     var goodsCode:String?
}

//退款流程详情
struct YDGoodsRefundInfo:HandyJSON{
    var orderInfo:YDGoodsPayRefundInfo?
    var aliRefundRecordInfo:[YDGoodsAliRefundRecordInfoModel]?
}

struct YDGoodsPayRefundInfo:HandyJSON{
    var ts:String?
    var creatAt:String?
    var refundReason:String?
    var refundPrice:Double?
    var orderStatus:String?
    var orderNum:String?
    var completeTime:String?
}
struct YDGoodsAliRefundRecordInfoModel:HandyJSON{
    var name:String?
    var salePrice:Double?
    var imageUrl:String?
    var orderNum:String?
    var weight:String?
    var count:String?
}
//客服
struct YDServiceLinkmanModel:HandyJSON{
    var helpInfo:[YDServiceHelpInfoModel]?
    var siteInfo:YDServiceSiteInfoModel?
}
struct YDServiceSiteInfoModel:HandyJSON{
    var supplierId:String?
    var siteName:String?
    var siteImg:String?
    var addressList:String?
    var address:String?
    var tell:String?
    var wechatQrcode:String?
    var latitude:String?
    var longitude:String?
}
struct YDServiceHelpInfoModel:HandyJSON{
    var icon:String?
    var isShow:Bool = false
    var `Type`:String?
    var list:[YDServiceHelplistInfoModel]?
}
struct YDServiceHelplistInfoModel:HandyJSON{
    var type:String?
    var problem:String?
    var answer:String?
}
//邀请有礼
struct YDInvitePresentLinkmanModel:HandyJSON{
    var inviteInfo:YDInvitePresentInfoModel?
    var inviteLog:[YDInviteLoglistInfoModel]?
    var inviteLogs:[YDInviteLogsSucceedInfoModel]?
    var qrcode:String?//邀请码
}
struct YDInvitePresentInfoModel:HandyJSON{
    var type:String?//1.满减券  2.代金券  3.免邮券
    var price:Double?//满减金额
    var minOrderPrice:Double?//满多少减
    var ruleUrl:String?//规则路径
    var title:String?//分享标题
    var content:String?//分享内容
    var image:String?//分享图片
    var shareUrl:String?//分享路径
    var uiUrl:String?//ui路径
}
struct YDInviteLoglistInfoModel:HandyJSON{
    var name:String?//昵称
    var headImg:String?//头像
    var phone:String?//手机号
    var status:String?//下单状态  1.下单  0.未下单
    var inviteTime:String?
    var creatAt:String?//创建时间
    var nickname:String?
}
struct YDInviteLogsSucceedInfoModel:HandyJSON{
    var name:String?//昵称
    var headImg:String?//头像
    var phone:String?//手机号
    var creatAt:String?//创建时间
    var inviteTime:String?
}
