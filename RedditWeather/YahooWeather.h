//
//  YahooWeather.h
//  RedditWeather
//
//  Created by Mathieu Hendey on 23/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol WeatherInfo <NSObject>

- (void)updateWeatherInfo;

@end

@interface YahooWeather : NSObject <CLLocationManagerDelegate> {
	CLGeocoder *_geocoder;
    NSDictionary *weatherData;
}

@property (nonatomic,weak) id<WeatherInfo> weatherDelegate; //Weather class delegate

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation; // The location data.
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (strong, nonatomic) NSDictionary *weatherData;

- (void) getWeather;


@end
