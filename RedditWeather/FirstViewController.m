//
//  FirstViewController.m
//  RedditWeather
//
//  Created by Mathieu Hendey on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "FirstViewController.h"
#import "YahooWeather.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize   townLabel, conditions, temperatureSetting,textLabel, temperatureLabel, imageView, weather;

- (void)viewWillAppear:(BOOL)animated
{
    //Gets user setting choices for Fahrenheit or Celsius
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    temperatureSetting = [[preferences valueForKey:@"temperature setting"]intValue];
    //Gets the current value of temperature from the JSON data
    NSInteger temp = [[conditions objectForKey:@"temperature"]intValue];
    //Checks the user setting to display either Fahrenheit or Celsius
    if (temperatureSetting == 0) {
        temp = (temp * 1.8) + 32;
        temperatureLabel.text = [NSString stringWithFormat:@"%i°F", temp];
    } else {
        temperatureLabel.text = [NSString stringWithFormat: @"%iºC", temp];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Sets background color for view controller
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
}

- (void)viewDidUnload
{
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

- (void)getWeather:(id)sender {
    
    weather = [[YahooWeather alloc] init];
    [weather getWeather];
    NSDictionary *temp = [weather weatherData];
    conditions = [temp objectForKey:@"condition"];
     
}
@end
