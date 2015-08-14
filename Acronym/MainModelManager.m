//
//  MainModelManager.m
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//

#import "MainModelManager.h"

@implementation MainModelManager

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    
}

#pragma mark - NSCopying
-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
