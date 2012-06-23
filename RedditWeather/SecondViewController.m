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

@synthesize temperatureControl, selectedSegment;

- (IBAction)temperatureSelection:(UISegmentedControl *)sender {
    //Instance of user defaults. Used to save settings
    NSUserDefaults *temperaturePreference = [NSUserDefaults standardUserDefaults];
    //Checks for which segment is pressed and saves the value it holds and remembers which one is pressed
    if ([sender selectedSegmentIndex] == 0) {
        [temperaturePreference setInteger:0 forKey:@"temperature setting"];
        [selectedSegment setInteger:0 forKey:@"segment setting"];
    } else if ([sender selectedSegmentIndex] == 1) {
        [temperaturePreference setInteger:1 forKey:@"temperature setting"];
        [selectedSegment setInteger:1 forKey:@"segment setting"];
    }
    //Insures the settings are saved
    [temperaturePreference synchronize];
    [selectedSegment synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Sets background color for view controller
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]]];
    selectedSegment = [NSUserDefaults standardUserDefaults];
    //Gets value stored from which segment was pressed 
    NSInteger segmentValue = [[selectedSegment objectForKey:@"segment setting"]intValue];
    //Sets the last one pressed as the current value highlighted
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
