//
//  ViewController.m
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/29/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import "ViewController.h"
#import "HeroListViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Close keyboard when user presses outside of it
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"HeroListViewSegue"]){
        HeroListViewController *controller = [segue destinationViewController];

        //Send the Url
        NSString *temporaryURL = [NSString stringWithFormat:@"http://us.battle.net/api/d3/profile/%@-%@/",self.nameTextBox.text,self.idTextBox.text];
        controller.queryUrl = temporaryURL;
        
        //Clear textFields
        [self.nameTextBox setText:@""];
        [self.idTextBox setText:@""];
    }
}
@end
