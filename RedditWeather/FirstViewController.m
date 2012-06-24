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
@synthesize townLabel, conditions, temperatureSetting, searchEntry, textLabel, temperatureLabel, imageView, weather, search;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Sets background color for view controller
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    weather = [[YahooWeather alloc] init];
}

- (void)viewDidUnload
{
    [self setSearch:nil];
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

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar 
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar 
{
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchEntry = [NSString stringWithFormat:@"http://where.yahooapis.com/geocode?location="];
    searchEntry = [searchEntry stringByAppendingString:searchBar.text];
    searchEntry = [searchEntry stringByAppendingFormat:@"&flags=J"];
    [searchBar resignFirstResponder];
    self.weather.weatherDelegate = self;
    [weather getWeather:YES :searchEntry];
}

- (void)getWeather:(id)sender 
{
    self.weather.weatherDelegate = self;
    [weather getWeather:NO :nil];
}

//Implmentation of the delegated method from the Yahoo Weather Class
- (void)updateWeatherInfo
{
    NSLog(@"updated");
    conditions = [[weather weatherData] objectForKey:@"condition"];
    NSDictionary *location = [[weather weatherData] objectForKey:@"location"];
    townLabel.text = [location objectForKey:@"city"];
    textLabel.text = [conditions objectForKey:@"text"];
    NSInteger temp = [[conditions objectForKey:@"temperature"]intValue];
    temperatureSetting = [[[NSUserDefaults standardUserDefaults]objectForKey:@"temperature setting"]intValue];
    //Checks the user setting to display either Fahrenheit or Celsius
    if (temperatureSetting == 0) {
        temp = (temp * 1.8) + 32;
        temperatureLabel.text = [NSString stringWithFormat:@"%i°F", temp];
    } else {
        temperatureLabel.text = [NSString stringWithFormat: @"%iºC", temp];
    }
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [conditions objectForKey:@"code"]] ofType:@"png"]];    
}

@end
