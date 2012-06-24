//
//  YahooWeather.h
//  RedditWeather
//
//  Created by Mathieu Hendey on 23/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*
Yahoo Weather Class protocol
Delegates of this class conform to the methods in the protocol declaration below.
What this means is that the class who is a delegate of this Yahoo weather class will implement the methods
below when they are told to by the Yahoo Weather class
*/
@protocol WeatherInfo <NSObject>

- (void)updateWeatherInfo;

@end

@interface YahooWeather : NSObject <CLLocationManagerDelegate> 
{
	CLGeocoder *_geocoder;
    NSDictionary *weatherData;
    NSString *placeURLString;
}

//Used to send the message to the Yahoo Weather class delegate
@property (nonatomic,weak) id<WeatherInfo> weatherDelegate;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation; // The location data.
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (strong, nonatomic) NSDictionary *weatherData;
@property (strong, nonatomic) NSString *placeURLString;

- (void) getWeather: (BOOL) searchedForLocation: (NSString *) locationSearchedFor;


@end
