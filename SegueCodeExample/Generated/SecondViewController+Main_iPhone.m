 //
 // SecondViewController+Main_iPhone.m
 // Generated by seguecode

#import "SecondViewController+Main_iPhone.h"

NSString * const From1stSecondBackToFirstFrom1stSecondToFirst = @"BackToFirstFrom1stSecond";
NSString * const From2ndSecondBackToFirstFrom2ndSecondToFirst = @"BackToFirstFrom2ndSecond";

@implementation SecondViewController (Main_iPhone)
- (IBAction)goBackToFirstFrom1stSecondToFirst
{
    [self goBackToFirstFrom1stSecondToFirstWithInfo:nil];
}

- (void)goBackToFirstFrom1stSecondToFirstWithInfo:(id)info
{
     [self performSegueWithIdentifier:From1stSecondBackToFirstFrom1stSecondToFirst sender:info];
}

- (IBAction)goBackToFirstFrom2ndSecondToFirst
{
    [self goBackToFirstFrom2ndSecondToFirstWithInfo:nil];
}

- (void)goBackToFirstFrom2ndSecondToFirstWithInfo:(id)info
{
     [self performSegueWithIdentifier:From2ndSecondBackToFirstFrom2ndSecondToFirst sender:info];
}

@end
