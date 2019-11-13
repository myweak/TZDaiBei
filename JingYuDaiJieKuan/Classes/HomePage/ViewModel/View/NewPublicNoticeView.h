//
//  NewPublicNoticeView.h
//  NewJingYuBao
//
//  Created by JY on 2018/6/4.
//  Copyright © 2018年 萤火虫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NoticeBlock) ();
typedef void (^NoticeDisappearBlock) ();

@interface NewPublicNoticeView : UIView

@property (copy ,nonatomic) NoticeBlock clickblock;
@property (copy ,nonatomic)NoticeDisappearBlock  noticeDisappearBlock;
-(instancetype)initWithContent:(NSString *)content;

@end
