//
//  HeroListViewController.m
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/29/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import "HeroListViewController.h"
#import "HeroCell.h"
#import "StatsViewController.h"

@interface HeroListViewController (){
    NSArray *_objects;
}
@end

@implementation HeroListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the StringList
    NSString *fname = [[NSBundle mainBundle] pathForResource:@"classNames" ofType:@"strings"];
    self.stringList = [NSDictionary dictionaryWithContentsOfFile:fname];
    
    // Fetch The Data on background thread
    [NSThread detachNewThreadSelector:@selector(getHeroListFrom:) toTarget:self withObject:self.queryUrl];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Initialize the Cell
    HeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *object = _objects[indexPath.row];
    cell.nameLabel.text = object[@"name"];
    cell.classLabel.text = [self.stringList objectForKey: object[@"class"]];
    cell.classPortrait.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.ico",object[@"class"],object[@"gender"]]];
    cell.levelLabel.text = [NSString stringWithFormat:@"%@",object[@"level"]];

    return cell;
}


-(void) getHeroListFrom: (NSString *) url{
    
    // Retrieve the data
    NSDictionary *data = [self getDataFrom:url];
    
    // Validate the data
    if(data[@"code"] || data == nil){
        NSLog(@"Profile Not Found");
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.navBar.title = @"Profile Not Found";
        }];
        return;
    }
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:_objects];
    
    // Retrieve the hero Dictionaries and add them to the new Array
    for(NSDictionary *item in data[@"heroes"]){
        [newArray addObject:item];
    }
    
    // Replace the tableview's model with new objects sorted by name
    _objects = [newArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSString *firstHeroName = obj1[@"name"];
        NSString *secondHeroName = obj2[@"name"];
        return[firstHeroName compare: secondHeroName];
    }];
    
    // Reload the tableview on main thread when finished
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
    }];
}


// eturns a dictionary from the retrieved JSON object
-(NSDictionary*) getDataFrom:(NSString *)url{
    
    // Created the request and responseCode
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    NSHTTPURLResponse *responseCode = nil;
    
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    // Check is the response is invalid (ie. 404)
    if([responseCode statusCode] != 200){
        NSLog(@"Error retrieving %@, HTTP status code is %i",url,[responseCode statusCode]);
        return nil;
    }
    
    NSError *jError;
    NSDictionary *returnData = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jError];
    
    // Check for JSON errors
    if(jError){
        NSLog(@"JSON Error");
        return nil;
    }
    
    return returnData;
}

#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"loadStats"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = _objects[indexPath.row];
        [[segue destinationViewController] setHero:object];
        [[segue destinationViewController] setQueryUrl:self.queryUrl];
    }
}

@end
