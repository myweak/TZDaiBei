//
//  HomeMchHistory+CoreDataProperties.h
//  
//
//  Created by Dason on 2019/8/30.
//
//

#import "HomeMchHistory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HomeMchHistory (CoreDataProperties)

+ (NSFetchRequest<HomeMchHistory *> *)fetchRequest;

@property (nonatomic) int32_t merchartid;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *timeStamp;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
