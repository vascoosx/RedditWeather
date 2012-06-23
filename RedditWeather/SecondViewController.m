//
//  SecondViewController.m
//  RedditWeather
//
//  Created by Mathieu Hendey on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize temperatureControl;
@synthesize selectedSegment;

- (IBAction)temperatureSelection:(UISegmentedControl *)sender {
    NSUserDefaults *temperaturePreference = [NSUserDefaults standardUserDefaults];
    selectedSegment = [NSUserDefaults standardUserDefaults];
    if ([sender selectedSegmentIndex] == 0) {
        [temperaturePreference setInteger:0 forKey:@"temperature setting"];
        [selectedSegment setInteger:0 forKey:@"segment setting"];
    } else if ([sender selectedSegmentIndex] == 1) {
        [temperaturePreference setInteger:1 forKey:@"temperature setting"];
        [selectedSegment setInteger:1 forKey:@"segment setting"];
    }
    [temperaturePreference synchronize];
    [selectedSegment synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger segmentValue = [[selectedSegment objectForKey:@"segment setting"]intValue];
    temperatureControl.selectedSegmentIndex = segmentValue;
    [temperatureControl setSelectedSegmentIndex:segmentValue];
}

- (void)viewDidUnload
{
    [self setTemperatureControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //iPhone set to only display in Portrait, iPad will autorotate
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

@end
