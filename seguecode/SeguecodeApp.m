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

// HACK: TODO: do proper singleton ref
static SeguecodeApp *lastInstance;

@interface SeguecodeApp ()
{
    BOOL _help;
    BOOL _version;
    BOOL _verbose;
}

@end

@implementation SeguecodeApp

- (id)init
{
    self = [super init];
    if (self)
    {
        lastInstance = self;
    }
    return self;
}

- (void)application:(DDCliApplication *)app willParseOptions:(DDGetoptLongParser *)optionsParser
{
    DDGetoptOption optionTable[] =
    {
        // Long         Short   Argument options
        {"output-dir",     'o',    DDGetoptRequiredArgument},
        
        {"const-prefix",   'p',    DDGetoptOptionalArgument},
        
        {"help",       'h',    DDGetoptNoArgument},
        {"version",    0,    DDGetoptNoArgument},
        {"verbose",   'v',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable: optionTable];
}

- (void)printUsage
{
    ddprintf(@"%@: Usage [OPTIONS] <argument> first.storyboard [second.storyboard...]\n", DDCliApp);
    ddprintf(@"  -o, --output-dir DIR         Output directory\n"
//           @"  -p, --const-prefix PREFIX    Prefix to prepend to constant names\n"
             @"  --version                    Display version and exit\n"
             @"  -v, --verbose                Display additional debugging information\n"
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

+ (BOOL)useVerboseOutput
{
    BOOL result = NO;
    if (lastInstance)
    {
        result = lastInstance->_verbose;
    }
    return result;
}

@end
