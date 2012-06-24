//
//  SearchViewController.m
//  RedditWeather
//
//  Created by Mathieu Hendey on 24/06/2012.
//  Copyright (c) 2012 Mathieu Hendey. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize conditions, search, textLabel, townLabel, imageView, temperatureLabel, temperatureSetting, searchEntry, weather;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    weather = [[YahooWeather alloc] init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
