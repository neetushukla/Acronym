//
//  AcronymService.m
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//
#import "AcronymService.h"
@implementation AcronymService
#pragma mark - Initilization
+ (instancetype)sharedService
{
    // BaseURL - default is empty
    NSString *urlStr = @"";
    NSURL *baseURL = [NSURL URLWithString:urlStr];
    
    static AcronymService *sharedService = nil;
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        sharedService = [[self alloc] initWithBaseURL:baseURL];
    });
    
    return sharedService;
}
- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    return self;
}
#pragma mark - Services
- (void)requestService:(id)searchQuery success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self configRequest:request type:searchQuery];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.operationQueue addOperation:operation];
}
#pragma mark - Config request
- (void)configRequest:(NSMutableURLRequest *)request type:(id)searchQuery
{
    NSString *urlString = [@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=" stringByAppendingString:searchQuery];
    NSURL *url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
}
@end
