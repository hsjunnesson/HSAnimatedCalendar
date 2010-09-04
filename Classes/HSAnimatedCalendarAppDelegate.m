//
//  HSAnimatedCalendarAppDelegate.m
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

#import "HSAnimatedCalendarAppDelegate.h"
#import "HSAnimatedCalendarViewController.h"

@implementation HSAnimatedCalendarAppDelegate

@synthesize window;
@synthesize scrollView;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
  
  clockController = [[HSAnimatedCalendarViewController alloc] initWithNibName:@"PanelStyle" bundle:nil];
  countdownController = [[HSAnimatedCalendarViewController alloc] initWithNibName:@"CountDown" bundle:nil];
  
  scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 2, scrollView.frame.size.width);
  
  CGRect rect = countdownController.view.frame;
  rect.origin.x += clockController.view.frame.size.width;
  
  countdownController.view.frame = rect;
  //  countdownController.view.frame.origin.x += clockController.view.frame.size.width;
  
  [scrollView addSubview:clockController.view];
  [scrollView addSubview:countdownController.view];
  
  [window makeKeyAndVisible];
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  [clockController stopTimer];
  [countdownController stopTimer];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  [clockController startTimer];
  [countdownController startTimer];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   See also applicationDidEnterBackground:.
   */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


- (void)dealloc {
  [window release];
  [super dealloc];
}

@end
