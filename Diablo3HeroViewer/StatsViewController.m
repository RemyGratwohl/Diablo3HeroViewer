//
//  StatsViewController.m
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/30/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import "StatsViewController.h"
#import "HeroStat.h"
#import "StatCell.h"

@interface StatsViewController (){
    NSArray *_objects;
}
@end

@implementation StatsViewController

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
    
    // Initialize StringList
    NSString *fname = [[NSBundle mainBundle] pathForResource:@"statNames" ofType:@"strings"];
    self.stringList = [NSDictionary dictionaryWithContentsOfFile:fname];
    
    // Fetch The Data in Background
    [NSThread detachNewThreadSelector:@selector(getHeroStatisticsFor:) toTarget:self withObject:self.hero];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatsCell";
    StatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    HeroStat *object = _objects[indexPath.row];
    cell.nameLabel.text= [self.stringList objectForKey:[object name]];
    cell.valueLabel.text = [NSString stringWithFormat:@"%@",[object value]];
    return cell;
}

// Takes a Hero Dictionary and retrieves/adds the statistics to the table
-(void) getHeroStatisticsFor: (NSDictionary*) Hero{
    
    NSString *heroURL = [NSString stringWithFormat:@"%@hero/%@",self.queryUrl,self.hero[@"id"]];
    NSDictionary *data = [self getDataFrom:heroURL];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:_objects];
    
    // Retrieves and add the Hero Statistics
    for(id key in data[@"stats"]){
        HeroStat *newStat = [[HeroStat alloc] init];
        [newStat setName:key];
        [newStat setValue: [data[@"stats"] objectForKey:key]];
        [newArray addObject:newStat];
    }
    
    // Sort and then Update the model
    _objects = [newArray sortedArrayUsingComparator:^NSComparisonResult(HeroStat *obj1, HeroStat *obj2){
        NSString *firstHeroName  = [obj1 name];
        NSString *secondHeroName = [obj2 name];
        return[firstHeroName compare: secondHeroName];
    }];
    
    // Update the tableview
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
    }];
}


// Fetch the data and return a dictionary of parsed JSON
-(NSDictionary*) getDataFrom:(NSString *)url{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSHTTPURLResponse *responseCode = nil;
    
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    //Check is the response is invalid (ie. 404)
    if([responseCode statusCode] != 200){
        NSLog(@"Error retrieving %@, HTTP status code is %i",url,[responseCode statusCode]);
        return nil;
    }
    
    NSError *jError;
    NSDictionary *returnData = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jError];
    
    //Check for JSON errors
    if(jError){
        NSLog(@"JSON Error");
        return nil;
    }
    
    return returnData;
}

@end
