//
//  AcronymModelManager.h
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//

#import "MainModelManager.h"

@interface AcronymModelManager : MainModelManager
@property (nonatomic, strong) NSMutableArray *acronymArray;
+ (instancetype)sharedManager;
+ (void)loadModel:(id)type withBlock:(void (^)(id model, NSError *error))block;

@end
