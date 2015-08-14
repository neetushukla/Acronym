//
//  AcronymModelManager.m
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//

#import "Acronym.h"
#import "AcronymService.h"
#import "AcronymModelManager.h"
@implementation AcronymModelManager
#pragma mark - initialization
- (id)init
{
    if (self = [super init]) {
        // Init default properties here
    }
    return self;
}
+ (instancetype)sharedManager
{
    static AcronymModelManager *sharedManager = nil;
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
#pragma mark - Load and Update model
+ (void)loadModel:(id)searchQuery withBlock:(void (^)(id model, NSError *error))block
{
    [[AcronymService sharedService] requestService:searchQuery
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               
                                               // Serialize model
                                               [[AcronymModelManager sharedManager] serializeModel:responseObject];
                                               
                                               // Callback to caller
                                               if (block) {
                                                   block([AcronymModelManager sharedManager].acronymArray, nil);
                                               }
                                           }
                                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                               // Callback to caller
                                               if (block) {
                                                   block(nil, error);
                                               }
                                           }];
}
#pragma mark - Serialization model
- (void)serializeModel:(id)data
{
    @try {
        NSArray *allDataArray = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:NSJSONReadingMutableLeaves
                                 error:nil];
        NSDictionary *rootDict=[allDataArray objectAtIndex:0];
        NSArray *dataArray = [rootDict objectForKey:@"lfs"];
        NSMutableArray *localAcronymArray = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < [dataArray count]; i++) {
            Acronym *objAcronym = [[Acronym alloc] init];
            objAcronym.lf = [[dataArray objectAtIndex:i] objectForKey:@"lf"];
            objAcronym.frequency =  [[[dataArray objectAtIndex:i] objectForKey:@"freq"] stringValue];
            
            objAcronym.since = [[[dataArray objectAtIndex:i] objectForKey:@"since"] stringValue];
            [localAcronymArray addObject:objAcronym];
        }
        self.acronymArray = localAcronymArray;
        
    }
    @catch (NSException *exception) {
        NSMutableArray *localAcronymArray = [[NSMutableArray alloc] init];
        self.acronymArray = localAcronymArray;
    }
}
@end
