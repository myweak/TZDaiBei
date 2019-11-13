//
//  HomeFourEarningsModel.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/6.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "HomeFourEarningsModel.h"

@implementation HomeFourEarningsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"isopen" : @"data.isopen",
             @"content_four" : @"data.content_four",
             @"content_three" : @"data.content_three"
             };
}
@end
