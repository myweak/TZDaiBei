//
//  HomeMchHistory+CoreDataProperties.m
//  
//
//  Created by Dason on 2019/8/30.
//
//

#import "HomeMchHistory+CoreDataProperties.h"

@implementation HomeMchHistory (CoreDataProperties)

+ (NSFetchRequest<HomeMchHistory *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"HomeMchHistory"];
}

@dynamic merchartid;
@dynamic name;
@dynamic timeStamp;
@dynamic userId;

@end
