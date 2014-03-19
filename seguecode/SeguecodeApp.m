//
//  SeguecodeApp.m
//  seguecode
//
//  Created by Ian on 12/9/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "SeguecodeApp.h"

#import <ddcli/DDGetoptLongParser.h>
#import <ddcli/DDCliUtil.h>

#import "StoryboardFile.h"

#import "HeaderTemplate.h"

#define SegueCodeAppVersion @"1.0"

static SeguecodeApp *staticSharedDelegate;

@interface SeguecodeApp ()
{
    BOOL _separateVc;
    
    BOOL _help;
    BOOL _version;
}

@end

@implementation SeguecodeApp

+ (SeguecodeApp *)sharedDelegate
{
    return staticSharedDelegate;
}

- (void)application:(DDCliApplication *)app willParseOptions:(DDGetoptLongParser *)optionsParser
{
    staticSharedDelegate = self;
    
    DDGetoptOption optionTable[] =
    {
        // Long         Short   Argument options
        {"output-dir",     'o',    DDGetoptRequiredArgument},
        
        {"separate-vc", 's', DDGetoptNoArgument},
        
        {"const-prefix",   'p',    DDGetoptOptionalArgument},
        
        {"help",       'h',    DDGetoptNoArgument},
        {"version",    'v',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable: optionTable];
}

- (void)printUsage
{
    ddprintf(@"%@: Usage [OPTIONS] <argument> first.storyboard [second.storyboard...]\n", DDCliApp);
    ddprintf(@"  -o, --output-dir DIR         Output directory\n"
             @"  -s, --separate-vc            Store UIViewController subclass categories in individual files for each class"
//           @"  -p, --const-prefix PREFIX    Prefix to prepend to constant names\n"
             @"  -v, --version                Display version and exit\n"
             @"  -h, --help                   Display this help and exit\n");
}

- (BOOL)exportStoryboardFile:(NSString *)fileName
{
    BOOL result = NO;
    
    NSString *pathFileName;
    if ( [fileName length] > 0 && [fileName characterAtIndex:0] == '/' )
    {
        pathFileName = fileName;
    } else
    {
        NSString *path = [ [NSFileManager defaultManager] currentDirectoryPath];
        pathFileName = [NSString stringWithFormat:@"%@/%@", path, fileName];
    }

    NSString *outputPath;
    if ( [self.outputDir length] > 0 && [self.outputDir characterAtIndex:0] == '/' )
    {
        outputPath = self.outputDir;
    } else
    {
        NSString *path = [ [NSFileManager defaultManager] currentDirectoryPath];
        outputPath = [NSString stringWithFormat:@"%@/%@", path, self.outputDir];
    }
    StoryboardFile *storyboardFile = [StoryboardFile storyboardFileAtPathFileName:pathFileName];
    if (storyboardFile != nil)
    {
        storyboardFile.exportViewControllersSeparately = _separateVc;
        
        [storyboardFile exportTo:outputPath withTemplateHeader:DefaultTemplateHeader andSource:DefaultTemplateSource];
        result = YES;
    } else
    {
        result = NO;
    }
    return result;
}

- (int)application:(DDCliApplication *)app runWithArguments:(NSArray *)arguments
{
    if (_help)
    {
        [self printUsage];
        return EXIT_SUCCESS;
    }
    
    if (_version)
    {
        NSLog(@"%@ %@\n", DDCliApp, SegueCodeAppVersion);
        return EXIT_SUCCESS;
    }
    
    __block BOOL error = NO;
    [arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        if ( [obj isKindOfClass:[NSString class] ] )
        {
            if ( ![self exportStoryboardFile:(NSString *)obj] )
            {
                error = YES;
            }
        }
    }];
    
    return error;
}

@end
