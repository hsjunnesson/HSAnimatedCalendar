//
//  HSAnimatedCalendarAppDelegate.h
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

@class HSAnimatedCalendarViewController;
@interface HSAnimatedCalendarAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {
  UIWindow *window;
  UIScrollView *scrollView;
  HSAnimatedCalendarViewController *clockController;
  HSAnimatedCalendarViewController *countdownController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end

