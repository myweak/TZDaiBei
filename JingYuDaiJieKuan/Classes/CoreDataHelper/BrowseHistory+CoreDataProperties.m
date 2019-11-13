//
//  BrowseHistory+CoreDataProperties.m
//  
//
//  Created by Dason on 2019/8/30.
//
//

#import "BrowseHistory+CoreDataProperties.h"

@implementation BrowseHistory (CoreDataProperties)

+ (NSFetchRequest<BrowseHistory *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"BrowseHistory"];
}

@dynamic icon;
@dynamic maxAmount;
@dynamic merchartid;
@dynamic name;
@dynamic tags;
@dynamic timeStamp;
@dynamic title;
@dynamic url;
@dynamic userId;

@end
