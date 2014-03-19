 //
 // FirstViewController+Main_iPhone.m
 // Generated by seguecode

#import "FirstViewController+Main_iPhone.h"

NSString * const FromFirstForwardTo2ndSecondTo2ndSecond = @"ForwardTo2ndSecond";
NSString * const FromFirstForwardToUIVCTo = @"ForwardToUIVC";
NSString * const FromFirstForwardTo1stSecondTo1stSecond = @"ForwardTo1stSecond";

@implementation FirstViewController (Main_iPhone)
- (IBAction)goForwardTo2ndSecondTo2ndSecond
{
    [self goForwardTo2ndSecondTo2ndSecondWithInfo:nil];
}

- (void)goForwardTo2ndSecondTo2ndSecondWithInfo:(id)info
{
     [self performSegueWithIdentifier:FromFirstForwardTo2ndSecondTo2ndSecond sender:info];
}

- (IBAction)goForwardToUIVCTo
{
    [self goForwardToUIVCToWithInfo:nil];
}

- (void)goForwardToUIVCToWithInfo:(id)info
{
     [self performSegueWithIdentifier:FromFirstForwardToUIVCTo sender:info];
}

- (IBAction)goForwardTo1stSecondTo1stSecond
{
    [self goForwardTo1stSecondTo1stSecondWithInfo:nil];
}

- (void)goForwardTo1stSecondTo1stSecondWithInfo:(id)info
{
     [self performSegueWithIdentifier:FromFirstForwardTo1stSecondTo1stSecond sender:info];
}

@end
