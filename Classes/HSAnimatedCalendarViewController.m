//
//  HSAnimatedCalendarViewController.m
//  HSAnimatedCalendar
//
//  Created by Hans Sjunnesson on 2010-08-26.
//  Copyright 2010 Hans Sjunnesson. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "HSAnimatedCalendarViewController.h"

#pragma mark -
#pragma mark Private interface

@interface HSAnimatedCalendarViewController (private)

- (void)setConfigurationFile:(NSString *)filename;
- (void)updateDate;
+ (CATransition*)transitionFromConfiguration:(NSDictionary*)configuration;

@end

#pragma mark -
#pragma mark Private implementation

@implementation HSAnimatedCalendarViewController (private)

- (void)setConfigurationFile:(NSString *)filename {
  // Load plist as a dictionary
  if (!filename || [filename length] == 0)
    [NSException raise:@"Exception" format:@"Invalid filename"];
  
  NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
  configuration_ = [[NSDictionary dictionaryWithContentsOfFile:path] retain];
  
  // Cache the images
  images_ = [[NSArray alloc] initWithObjects:[UIImage imageNamed:[NSString stringWithFormat:@"%@_0.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_1.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_2.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_3.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_4.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_5.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_6.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_7.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_8.png", configPrefix_]],
             [UIImage imageNamed:[NSString stringWithFormat:@"%@_9.png", configPrefix_]],
             nil];
  
  if ([images_ containsObject:nil])
    [NSException raise:@"Exception" format:@"Some image files not found."];
}

// The leftmost nth digit
int nthDigit(int x, int n) {
  while (n--)
    x /= 10;
  return x % 10;
}

- (void)updateDate {

  int thousandYears;
  int hundredYears;
  int tenYears;
  int years;
  
  int tenMonths;
  int months;
  
  int tenDays;
  int days;
  
  int tenHours;
  int hours;
  int tenMinutes;
  int minutes;
  int tenSeconds;
  int seconds;

  BOOL isCountdown = [[configuration_ objectForKey:@"Countdown"] boolValue];

  if (isCountdown) {
    NSDate *target = [configuration_ objectForKey:@"CountdownDate"];

    if (!target)
      [NSException raise:@"NullPointerException" format:@"CountdownDate not defined in %@.plist", configPrefix_];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date] toDate:target options:0];

    int year = [components year];
    int month = [components month];
    int day = [components day];
    int hour = [components hour];
    int minute = [components minute];
    int second = [components second];
    
    if (year == 0) {
      years = 0;
      tenYears = 0;
      hundredYears = 0;
      thousandYears = 0;
    } else {
      years = nthDigit(year, 0);
      tenYears = nthDigit(year, 1);
      hundredYears = nthDigit(year, 2);
      thousandYears = nthDigit(year, 3);
    }
    
    if (month == 0) {
      months = 0;
      tenMonths = 0;
    } else {
      months = nthDigit(month, 0);
      tenMonths = nthDigit(month, 1);
    }

    if (day == 0) {
      days = 0;
      tenDays = 0;
    } else {
      days = nthDigit(day, 0);
      tenDays = nthDigit(day, 1);
    }
    
    if (hour == 0) {
      hours = 0;
      tenHours = 0;
    } else {
      hours = nthDigit(hour, 0);
      tenHours = nthDigit(hour, 1);
    }

    if (minute == 0) {
      minutes = 0;
      tenMinutes = 0;
    } else {
      minutes = nthDigit(minute, 0);
      tenMinutes = nthDigit(minute, 1);
    }
    
    if (second == 0) {
      seconds = 0;
      tenSeconds = 0;
    } else {
      seconds = nthDigit(second, 0);
      tenSeconds = nthDigit(second, 1);
    }
  } else {
    // If we're not in "countdown mode" we simply update with the current date and time
    NSDate *date = [NSDate date];

    // Note that this particular NSDateFormatter shows 24-hour time.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [formatter stringFromDate:date];
    
    thousandYears = [[dateString substringWithRange:NSMakeRange(0, 1)] intValue];
    hundredYears = [[dateString substringWithRange:NSMakeRange(1, 1)] intValue];
    tenYears = [[dateString substringWithRange:NSMakeRange(2, 1)] intValue];
    years = [[dateString substringWithRange:NSMakeRange(3, 1)] intValue];
    
    tenMonths = [[dateString substringWithRange:NSMakeRange(4, 1)] intValue];
    months = [[dateString substringWithRange:NSMakeRange(5, 1)] intValue];
    
    tenDays = [[dateString substringWithRange:NSMakeRange(6, 1)] intValue];
    days = [[dateString substringWithRange:NSMakeRange(7, 1)] intValue];
    
    tenHours = [[dateString substringWithRange:NSMakeRange(8, 1)] intValue];
    hours = [[dateString substringWithRange:NSMakeRange(9, 1)] intValue];
    tenMinutes = [[dateString substringWithRange:NSMakeRange(10, 1)] intValue];
    minutes = [[dateString substringWithRange:NSMakeRange(11, 1)] intValue];
    tenSeconds = [[dateString substringWithRange:NSMakeRange(12, 1)] intValue];
    seconds = [[dateString substringWithRange:NSMakeRange(13, 1)] intValue];
  }
  
  CATransition *transition = [self calendarTransition];

  if (prevThousandYears_ != thousandYears) {
    [thousandYearsView setImage:[images_ objectAtIndex:thousandYears]];
    [thousandYearsView.layer addAnimation:transition forKey:@"Transition"];
    prevThousandYears_ = thousandYears;
  }
  
  if (prevHundredYears_ != hundredYears) {
    [hundredYearsView setImage:[images_ objectAtIndex:hundredYears]];
    [hundredYearsView.layer addAnimation:transition forKey:@"Transition"];
    prevHundredYears_ = hundredYears;
  }
  
  if (prevTenYears_ != tenYears) {
    [tenYearsView setImage:[images_ objectAtIndex:tenYears]];
    [tenYearsView.layer addAnimation:transition forKey:@"Transition"];
    prevTenYears_ = tenYears;
  }
  
  if (prevYears_ != years) {
    [yearsView setImage:[images_ objectAtIndex:years]];
    [yearsView.layer addAnimation:transition forKey:@"Transition"];
    prevYears_ = years;
  }

  if (prevTenMonths_ != tenMonths) {
    [tenMonthsView setImage:[images_ objectAtIndex:tenMonths]];
    [tenMonthsView.layer addAnimation:transition forKey:@"Transition"];
    prevTenMonths_ = tenMonths;
  }
  
  if (prevMonths_ != months) {
    [monthsView setImage:[images_ objectAtIndex:months]];
    [monthsView.layer addAnimation:transition forKey:@"Transition"];
    prevMonths_ = months;
  }

  if (prevTenDays_ != tenDays) {
    [tenDaysView setImage:[images_ objectAtIndex:tenDays]];
    [tenDaysView.layer addAnimation:transition forKey:@"Transition"];
    prevTenDays_ = tenDays;
  }
  
  if (prevDays_ != days) {
    [daysView setImage:[images_ objectAtIndex:days]];
    [daysView.layer addAnimation:transition forKey:@"Transition"];
    prevDays_ = days;
  }
  
  if (prevTenHours_ != tenHours) {
    [tenHoursView setImage:[images_ objectAtIndex:tenHours]];
    [tenHoursView.layer addAnimation:transition forKey:@"Transition"];
    prevTenHours_ = tenHours;
  }

  if (prevHours_ != hours) {
    [hoursView setImage:[images_ objectAtIndex:hours]];
    [hoursView.layer addAnimation:transition forKey:@"Transition"];
    prevHours_ = hours;
  }

  if (prevTenMinutes_ != tenMinutes) {
    [tenMinutesView setImage:[images_ objectAtIndex:tenMinutes]];
    [tenMinutesView.layer addAnimation:transition forKey:@"Transition"];
    prevTenMinutes_ = tenMinutes;
  }
  
  if (prevMinutes_ != minutes) {
    [minutesView setImage:[images_ objectAtIndex:minutes]];
    [minutesView.layer addAnimation:transition forKey:@"Transition"];
    prevMinutes_ = minutes;
  }
  
  if (prevTenSeconds_ != tenSeconds) {
    [tenSecondsView setImage:[images_ objectAtIndex:tenSeconds]];
    [tenSecondsView.layer addAnimation:transition forKey:@"Transition"];
    prevTenSeconds_ = tenSeconds;
  }

  if (prevSeconds_ != seconds) {
    [secondsView setImage:[images_ objectAtIndex:seconds]];
    [secondsView.layer addAnimation:transition forKey:@"Transition"];
    prevSeconds_= seconds;
  }
}

+ (CATransition*)transitionFromConfiguration:(NSDictionary*)configuration {
  CATransition *transition = [CATransition animation];
  
  NSString *typeString = [configuration objectForKey:@"transitionType"];
  
  if (typeString) {
    NSString *type = nil;
    
    if ([@"fade" isEqualToString:typeString])
      type = kCATransitionFade;
    else if ([@"moveIn" isEqualToString:typeString])
      type = kCATransitionMoveIn;
    else if ([@"push" isEqualToString:typeString])
      type = kCATransitionPush;
    else if ([@"reveal" isEqualToString:typeString])
      type = kCATransitionReveal;

    if (!type)
      [NSException raise:@"ConfigurationException" format:@"transitionType not properly set in plist"];

    [transition setType:type];
  } else {
    [transition setType:kCATransitionFade];
  }
  
  NSString *subTypeString = [configuration objectForKey:@"transitionSubType"];
  if (subTypeString) {
    NSString *subType = nil;
    
    if ([@"right" isEqualToString:subTypeString])
      subType = kCATransitionFromRight;
    else if ([@"left" isEqualToString:subTypeString])
      subType = kCATransitionFromLeft;
    else if ([@"top" isEqualToString:subTypeString])
      subType = kCATransitionFromTop;
    else if ([@"bottom" isEqualToString:subTypeString])
      subType = kCATransitionFromBottom;
    
    if (!subType)
      [NSException raise:@"ConfigurationException" format:@"transitionSubType not properly set in plist"];

    [transition setSubtype:subType];
  }

  NSNumber *duration = [configuration objectForKey:@"transitionDuration"];
  
  if (duration) {
    [transition setDuration:[duration floatValue]];
  } else {
    [transition setDuration:0.25];
  }
  
  return transition;
}

@end


#pragma mark -
#pragma mark Public implementation

@implementation HSAnimatedCalendarViewController

@synthesize calendarTransition = calendarTransition_;

#pragma mark -
#pragma mark Class lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    if (nibNameOrNil) {
      configPrefix_ = [nibNameOrNil copy];
      [self setConfigurationFile:nibNameOrNil];

      prevThousandYears_ = -1;
      prevHundredYears_ = -1;
      prevTenYears_ = -1;
      prevYears_ = -1;
      prevTenMonths_ = -1;
      prevMonths_ = -1;
      prevTenDays_ = -1;
      prevDays_ = -1;
      prevTenHours_ =-1;
      prevHours_ =-1;
      prevTenMinutes_ =-1;
      prevMinutes_ =-1;
      prevTenSeconds_ =-1;
      prevSeconds_ =-1;
      
      calendarTransition_ = [[[self class] transitionFromConfiguration:configuration_] retain];
      
    } else {
      [NSException raise:@"Exception" format:@"Invalid nibname"];
    }
  }
  
  return self;
}

- (void)dealloc {
  [configuration_ release];
  [images_ release];
  [configPrefix_ release];
  [calendarTransition_ release];
  
  [super dealloc];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [self startTimer];
}

- (void)viewDidUnload {
  [self stopTimer];
}

#pragma mark -
#pragma mark Timer methods

- (void)startTimer {
  if (timer_)
    [self stopTimer];
  
  timer_ = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateDate) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:timer_  forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer {
  if (timer_) {
    [timer_ invalidate];
    timer_ = nil;
  }
}

@end
