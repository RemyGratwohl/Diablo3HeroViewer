//
//  StatsViewController.h
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/30/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsViewController : UITableViewController

@property(strong,nonatomic) NSDictionary *hero;
@property (strong,nonatomic)  NSString *queryUrl;
@property(strong,nonatomic) NSDictionary *stringList;

@end
