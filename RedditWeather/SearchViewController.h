//
//  SearchViewController.h
//  RedditWeather
//
//  Created by Mathieu Hendey on 24/06/2012.
//  Copyright (c) 2012 Mathieu Hendey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YahooWeather.h"
@interface SearchViewController : UIViewController <UISearchBarDelegate, WeatherInfo> {
    __weak UILabel *_townLabel;
    __weak UILabel *_textLabel;
    __weak UILabel *_temperatureLabel;
    __weak UIImageView *__imageView;
    YahooWeather *weather;
}

@property (nonatomic) NSDictionary *conditions; 
@property (nonatomic) NSInteger temperatureSetting;
@property (nonatomic) NSString *searchEntry;
@property (nonatomic,retain) YahooWeather *weather;
@property (weak, nonatomic) IBOutlet UILabel *townLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISearchBar *search;

- (void)updateWeatherInfo;

@end
