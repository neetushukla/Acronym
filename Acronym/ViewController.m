//
//  ViewController.m
//  Acronym
//
//  Created by NEETU SHUKLA on 8/13/15.
//  Copyright (c) 2015 NEETU SHUKLA. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *acrynymTextField;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.acrynymTextField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.acrynymTextField resignFirstResponder];
    [self performSegueWithIdentifier:@"segueShowResults" sender:self];
    return NO;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueShowResults"])
    {
        // Get reference to the destination view controller
        ResultsViewController *rVC = (ResultsViewController*)[segue destinationViewController];
        // Pass any objects to the view controller here, like...
        rVC.searchQuery = self.acrynymTextField.text;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
