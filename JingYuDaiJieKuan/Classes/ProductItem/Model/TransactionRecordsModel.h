//
//  TransactionRecordsModel.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/3.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "TransactionRecordsListModel.h"
@interface TransactionRecordsModel : BaseModel

/**
 *  交易记录
 *  detail_type  交易类型
 *  page         分页
 */
+ (void)acquisitionRecordPath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 target:(id)target
                success:(void (^)(TransactionRecordsListModel * model))success
                      failure:(void (^)(NSError *error))failure;


/**
 *  意见反馈 -- 7224
 *  
 */
+ (void)feedbackPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(UserModel *model))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  交易记录类型数据 -- 7224
 *  token
 */
+ (void)orderGetDetailTypePath:(NSString *)path
                        params:(NSMutableDictionary *)params
                        target:(id)target
                       success:(void (^)(TransactionRecordsListModel * model))success
                       failure:(void (^)(NSError *))failure;

/**
 *  用户投资列表 -- 7224
 *  type  投资状态    3 投标中 （1-审核中|2-驳回|3-招标中|4-持有中【4-已满标|5-还款中】|6-已结清）
 *  page         分页   1（1-第一页，2-第二页）
 */
+ (void)myInvestmentPath:(NSString *)path
              params:(NSMutableDictionary *)params
              target:(id)target
             success:(void (^)(TransactionRecordsListModel *model))success
             failure:(void (^)(NSError *error))failure;


/**
 *  项目列表    7208
 *  limit      每页记录记录数 默认10条 可以不传
 *  page       页码 默认第一页 翻页必传
 */
+ (void)listOfItemsPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(TransactionRecordsListModel * model))success
                      failure:(void (^)(NSError *error))failure;


/**
 *  我的投资 列表详情    7224
 *  pinvestid      项目投资id
 **/
+ (void)investmentListDetailsPath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 target:(id)target
                success:(void (^)(TransactionRecordsListModel * model))success
                failure:(void (^)(NSError *error))failure;


/**
 *  查看明细   7224
 *  pinvestid      项目投资id
 **/
+ (void)checkTheDetailsPath:(NSString *)path
                           params:(NSMutableDictionary *)params
                           target:(id)target
                          success:(void (^)(TransactionRecordsListModel * model))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  投资记录   7208
 *  pinvestid      项目投资id
 **/
+ (void)InvestmentRecordPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(TransactionRecordsListModel * model))success
                    failure:(void (^)(NSError *error))failure;
/**
 *  投资记录   7208
 *  productId      项目id
 **/
+ (void)projectGetProductCheckDattumPath:(NSString *)path
                                  params:(NSMutableDictionary *)params
                                  target:(id)target
                                 success:(void (^)(TransactionRecordsListModel * model))success
                                 failure:(void (^)(NSError *error))failure;


@end
