//
//  SearchViewController.m
//  RedditWeather
//
//  Created by Mathieu Hendey on 24/06/2012.
//  Copyright (c) 2012 Mathieu Hendey. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    NSString *todayForecast;
    NSString *tomorrowForecast;
    UITableViewCell *cell;
}

@end

@implementation SearchViewController
@synthesize conditions, search, textLabel, townLabel, imageView, temperatureLabel, temperatureSetting, searchEntry, weather, forcastView;

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
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"searchcity"]) {
        townLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchcity"];
        textLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchtext"];
        temperatureSetting = [[[NSUserDefaults standardUserDefaults]objectForKey:@"temperature setting"]intValue];
        NSInteger temp = [[NSUserDefaults standardUserDefaults] integerForKey:@"searchtemperature"];
        if (temperatureSetting == 0) {
            temp = (temp * 1.8) + 32;
            temperatureLabel.text = [NSString stringWithFormat:@"%i°F", temp];
        } else {
            temperatureLabel.text = [NSString stringWithFormat: @"%iºC", temp];
        }
        imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"searchcode"]] ofType:@"png"]];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setForcastView:nil];
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
    
    [[NSUserDefaults standardUserDefaults] setObject:[location objectForKey:@"city"] forKey: @"searchcity"];
    [[NSUserDefaults standardUserDefaults] setObject:[conditions objectForKey:@"text"] forKey: @"searchtext"];
    [[NSUserDefaults standardUserDefaults] setInteger: temp forKey: @"searchtemperature"];
    [[NSUserDefaults standardUserDefaults] setObject:[conditions objectForKey:@"code"] forKey: @"searchcode"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 7;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [NSString	 stringWithFormat:@"Cell Row #%d", [indexPath row]];
    
    return cell;
}

@end
