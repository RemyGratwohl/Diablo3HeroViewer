//
//  StatCell.h
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/30/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end
