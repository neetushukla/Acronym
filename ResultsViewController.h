//
//  ResultsViewController.h
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UIViewController
@property(strong,nonatomic) NSString *searchQuery;
@property(strong,nonatomic) NSMutableArray *acronymArray;
@end
