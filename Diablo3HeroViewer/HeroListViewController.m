//
//  HeroListViewController.m
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/29/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import "HeroListViewController.h"
#import "HeroCell.h"

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
    HeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = _objects[indexPath.row];
    cell.nameLabel.text = object[@"name"];
    cell.classLabel.text = object[@"class"];
    cell.classPortrait.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.ico",object[@"class"],object[@"gender"]]];
    cell.levelLabel.text = [NSString stringWithFormat:@"%@",object[@"level"]];

    return cell;
}


-(void) getHeroListFrom: (NSString *) url{
    NSDictionary *data = [self getDataFrom:url];
    
    if(data[@"code"]){
        NSLog(@"Profile Not Found");
        //[self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:_objects];
    
    //Retrieves the heroe Dictionaries
    for(NSDictionary *item in data[@"heroes"]){
        [newArray addObject:item];
    }
    
    //Replace the model with new Objects sorted by name
    _objects = [newArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSString *firstHeroName = obj1[@"name"];
        NSString *secondHeroName = obj2[@"name"];
        return[firstHeroName compare: secondHeroName];
    }];
    
    //Reload the data
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
    }];
}


//Returns a dictionary from the retrieved JSON object
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
    }else{
        return returnData;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
