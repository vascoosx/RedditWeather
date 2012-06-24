//
//  YahooWeather.m
//  RedditWeather
//
//  Created by Mathieu Hendey on 23/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "YahooWeather.h"

@implementation YahooWeather

@synthesize weatherDelegate = _weatherDelegate;
@synthesize locationManager, currentLocation, latitude, longitude, weatherData, placeURLString;

/* Begin searching for wather data. If they searched, searchedForLocation is YES so we don't need to get their current location.
   If they pressed the Get Weather button, searchedForLocation is NO so we do need to get their current location. */
- (void) getWeather:(BOOL)searchedForLocation :(NSString *)locationSearchedFor{

    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    if (searchedForLocation) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSLog(@"searched");
        placeURLString = locationSearchedFor;
        placeURLString = [placeURLString stringByReplacingOccurrencesOfString:@", " withString:@"+"];
        placeURLString = [placeURLString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        dispatch_async(kBgQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:placeURLString]];
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];
        });
    }
    else if (searchedForLocation == NO) {
        [locationManager startUpdatingLocation];
    }
       
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Called when new location data, such as better accuracy for a location or if the device moves.
    [locationManager stopUpdatingLocation];
    self.currentLocation = newLocation;
    latitude = currentLocation.coordinate.latitude;
    longitude = currentLocation.coordinate.longitude;
    
    // Show the spinning wheel (UIActivityIndicator) in the status bar whilst we're getting the data.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // URL for dataWithContentsOfURL.
    placeURLString = [NSString stringWithFormat:@"http://where.yahooapis.com/geocode?location=%f+%f&flags=J&gflags=r&appid=83Q_GxzV34GmB4fZFHAlkt1NOa6YN3.BJ2iyaYv.LeW8uWaUVc0jLJYEISsQdUUVIhoHGw--", latitude, longitude];
    
    // Get weather data in background queue so UI doesn't lock up.
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:placeURLString]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // Called if Core Location reports an error. This method is optional, but good habit to include.
    
    // Create and display a UIAlertView if an error occurs.
    if(error.code == kCLErrorDenied) {
        [locationManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (void)fetchedData:(NSData *)responseData {  
    
    NSLog(@"data");
    NSError *error;
    
    /* 
    Get the JSON object from Yahoo.
    JSON is basically a way of representing data. The data comes in either an array or a dictionary of objects. In this case a dictionary.
    */
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSDictionary* resultset = [json objectForKey:@"ResultSet"];
    NSArray* results = [resultset objectForKey:@"Results"];
    NSDictionary* rawPlaceData = [results objectAtIndex:0];
    
    // When we've got the data, remove the UIActivityIndicator from the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // URL for dataWithContentsOfURL.
    NSString * urlString = [NSString stringWithFormat: @"http://weather.yahooapis.com/forecastjson?u=c&w=%@", [rawPlaceData objectForKey:@"woeid"]];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    [self performSelectorOnMainThread:@selector(fetchedWeather:)
                           withObject:data 
                        waitUntilDone:YES];
}

- (void)fetchedWeather:(NSData *)responseData {
    NSLog(@"weather");
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    weatherData = json;
    [_weatherDelegate updateWeatherInfo];
}

@end