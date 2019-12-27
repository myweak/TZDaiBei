//
//  TZApplyCreditCardModel.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/24.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZApplyCreditCardModel : BaseModel
@property (nonatomic, strong) NSArray *list;
@end

@interface TZApplyCreditCardListModel : NSObject
@property (nonatomic, copy) NSString * icoUrl;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * ID; // image url
@property (nonatomic, copy) NSString * title; //浏览数
@property (nonatomic, copy) NSString * introduceOne;
@property (nonatomic, copy) NSString * introduceTwo;
@property (nonatomic, copy) NSString * introduceThree;
@property (nonatomic, copy) NSString * introduceFive;
@property (nonatomic, copy) NSString * introduceFour;


@end


NS_ASSUME_NONNULL_END
