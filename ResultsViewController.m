//
//  ResultsViewController.m
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//
#import "MBProgressHUD.h"
#import "ResultsTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "Acronym.h"
#import "ResultsViewController.h"
#import "AcronymModelManager.h"
@interface ResultsViewController ()<MBProgressHUDDelegate, UITableViewDataSource,UITableViewDelegate>{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end
@implementation ResultsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.resultsTableView.dataSource=self;
    self.resultsTableView.delegate=self;
    [self loadModel];
}
-(void) loadModel
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.userInteractionEnabled = NO;
    [HUD showAnimated:YES whileExecutingBlock:^{
        [AcronymModelManager loadModel:self.searchQuery withBlock:^(id model, NSError *error) {
            if (!error) {
                self.acronymArray =[AcronymModelManager sharedManager].acronymArray;
                if (self.acronymArray.count>0) {
                    [self.resultsTableView reloadData];
                }
            }else
            {
                NSLog(@"Error = %@",error);
            }
        }];
    }completionBlock:^{
        [HUD removeFromSuperview];
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.acronymArray.count == 0) {
        //no separator
        self.resultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }else
    {
        self.resultsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //number of sections in this table
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.acronymArray.count==0 ) {
        return 0;
    }else
    {
        return [self.acronymArray count]+1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //first row. Header Cell.
        NSString *strHeaderCell = @"HeaderCell";
        HeaderTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:strHeaderCell];
        if (cell == nil) {
            cell = [[HeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strHeaderCell];
        }
        cell.headerLabel.text = self.searchQuery;
        
        return cell;
    }else
    {
        NSString *strResultsCell = @"ResultsCell";
        ResultsTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:strResultsCell];
        if (cell == nil) {
            cell = [[ResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strResultsCell];
        }
        NSString *strLF =( (Acronym *)[self.acronymArray objectAtIndex:indexPath.row-1]).lf;
        NSString *strFrequency = (NSString *)( (Acronym *)[self.acronymArray objectAtIndex:indexPath.row-1] ).frequency;
        NSString *strSince =( (Acronym *)[self.acronymArray objectAtIndex:indexPath.row-1] ).since;
        cell.lfLabel.text = strLF;
        cell.freqSinceLabel.text =  [[[@"Frequency: " stringByAppendingString: strFrequency] stringByAppendingString:@". Since: "] stringByAppendingString:strSince];
        return cell;
    }
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //header row height
        return 50;
    }else
    {
        return 75;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.acronymArray removeAllObjects];
    [self.resultsTableView reloadData];
}
#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
