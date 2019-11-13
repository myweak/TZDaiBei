//
//  CPAutoSize.h
//  Cunpiao
//
//  Created by LXH on 2017/11/9.
//  Copyright © 2017年 cwb. All rights reserved.
//

#ifndef CPAutoSize_h
#define CPAutoSize_h

#pragma mark -- 新的比例

/** 屏幕宽度 */
#define KAutoSizeWidth  ([[UIScreen mainScreen] bounds].size.width)

/**
 * 由于4 5 6 字体大小一样  Plus上字体 +2
 * 假如设计给的图是750的图 那么应该是375的标准是1 其他的 就是屏幕宽度/375.0
 *  4、5的 比例就该是 320/375.0    plus的比例就是 414/375.0
 */

#if 0
#define KAutoSizeScaleX ((KAutoSizeWidth > 320) ? (KAutoSizeWidth / 320.0) : 1)
#else
#define KAutoSizeScaleX ((KAutoSizeWidth != 375) ? (KAutoSizeWidth / 375.0) : 1)
#endif

#define kNavBarH                (kIsPhoneX ? 88 : 64)
#define kStateBarH              (kIsPhoneX ? 44 : 20)

CG_INLINE CGFloat
KWidth(CGFloat width)    // 5,6同尺寸,7以上自动放大
{
    CGFloat autoWidth = width * KAutoSizeScaleX;
    return autoWidth;
}

#define KFontNumer(a)   ((KAutoSizeWidth > 375)? a + 2: a)
#define KFont(a)        [UIFont systemFontOfSize:KFontNumer(a)]
#define KBFont(a)       [UIFont boldSystemFontOfSize:KFontNumer(a)]
#define kMargin         20


static inline CGFloat iPhoneXDiffHeight() {
    
    if (kIsPhoneX) {
        return 24;
    }
    return 0;
}


#endif /* CPAutoSize_h */
