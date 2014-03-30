//
//  StatCell.m
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/30/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import "StatCell.h"

@implementation StatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
