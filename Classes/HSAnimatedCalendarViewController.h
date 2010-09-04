//
//  HSAnimatedCalendarViewController.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HSAnimatedCalendarViewController : UIViewController {
 @protected
  NSDictionary *configuration_;
  NSArray *images_;
  NSString *configPrefix_;
  NSTimer *timer_;
  CATransition *calendarTransition_;
  
  // The date components of the previous timer update
  int prevThousandYears_;
  int prevHundredYears_;
  int prevTenYears_;
  int prevYears_;
  int prevTenMonths_;
  int prevMonths_;
  int prevTenDays_;
  int prevDays_;
  int prevTenHours_;
  int prevHours_;
  int prevTenMinutes_;
  int prevMinutes_;
  int prevTenSeconds_;
  int prevSeconds_;

  // The UIImageViews for the specific date components
  IBOutlet UIImageView *thousandYearsView;
  IBOutlet UIImageView *hundredYearsView;
  IBOutlet UIImageView *tenYearsView;
  IBOutlet UIImageView *yearsView;
  IBOutlet UIImageView *tenMonthsView;
  IBOutlet UIImageView *monthsView;
  IBOutlet UIImageView *tenDaysView;
  IBOutlet UIImageView *daysView;
  IBOutlet UIImageView *tenHoursView;
  IBOutlet UIImageView *hoursView;
  IBOutlet UIImageView *tenMinutesView;
  IBOutlet UIImageView *minutesView;
  IBOutlet UIImageView *tenSecondsView;
  IBOutlet UIImageView *secondsView;
}

// Starts the animating timer
- (void)startTimer;

// Stops the animating timer
- (void)stopTimer;

// Returns the specific CATtransition we use to transition between images.
@property (readonly) CATransition *calendarTransition;

@end
