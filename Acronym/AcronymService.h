//
//  AcronymService.h
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AcronymService : AFHTTPRequestOperationManager

+ (instancetype)sharedService;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)requestService:(id)type
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
