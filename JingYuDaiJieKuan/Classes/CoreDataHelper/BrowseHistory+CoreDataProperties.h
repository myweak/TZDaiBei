//
//  BrowseHistory+CoreDataProperties.h
//  
//
//  Created by Dason on 2019/8/30.
//
//

#import "BrowseHistory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BrowseHistory (CoreDataProperties)

+ (NSFetchRequest<BrowseHistory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *icon;
@property (nonatomic) int32_t maxAmount;
@property (nonatomic) int32_t merchartid;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *tags;
@property (nullable, nonatomic, copy) NSString *timeStamp;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
