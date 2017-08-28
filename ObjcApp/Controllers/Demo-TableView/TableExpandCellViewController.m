//
//  TableExpandCellViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/26/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "TableExpandCellViewController.h"
#import "ExpandViewCell.h"
#import "ExpandTypeTwoCell.h"

@interface TableExpandCellViewController ()

@property (nonatomic, strong) NSArray *arrArtists;

@end

@implementation TableExpandCellViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Expand cell";
    [self doSomethingWithTheJson];
    
    
    self.tblContent.rowHeight = UITableViewAutomaticDimension;
//    self.tblContent.estimatedRowHeight = 90; // TypeOne
    self.tblContent.estimatedRowHeight = 85; // TypeTwo
//    self.tblContent.rowHeight = 44;
    
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // So dong trong moi section
    return [self.arrArtists count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ExpandViewCell *cell = (ExpandViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellExpand"];
//    if (cell == nil)
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExpandViewCell" owner:self options:nil] lastObject];

    ExpandTypeTwoCell *cell = (ExpandTypeTwoCell *)[tableView dequeueReusableCellWithIdentifier:@"expandTypeTwoCell"];
    if (cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExpandTypeTwoCell" owner:self options:nil] lastObject];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *data = [self.arrArtists objectAtIndex:indexPath.row];
    
    [cell reloadCellData:data];
    
//    cell.txtTitle.text = [data objectForKey:@"name"];
//    cell.txtName.text = [data objectForKey:@"bio"];
//    
//    int count = [[data objectForKey:@"image"] intValue];
//    if (count % 2 == 0) {
//        cell.txtStatus.text = @"";
//    } else {
//        cell.txtStatus.text = [NSString stringWithFormat:@"So hinh anh = %d", count];
//    }
    
    
    //	UITableViewCellAccessoryCheckmark
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = [arrDataSources objectAtIndex:indexPath.row];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // default size
//    return 44;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Animation for select row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //	NSString *indexWord = [indexArray objectAtIndex:indexPath.section];
    //
    //	NSLog(@"Ban da chon : %@",[array objectAtIndex:indexPath.row]);
}

// specify the height of your footer section
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //allocate the view if it doesn't exist yet
    UIView* footerView  = [[UIView alloc] initWithFrame:(CGRect){0,0,SCREEN_WIDTH,10}];
    [footerView setBackgroundColor:[UIColor clearColor]];
    return footerView;
}


- (void)doSomethingWithTheJson
{
    NSDictionary *dict = [self JSONFromFile];
    
    NSArray *artists = [dict objectForKey:@"artists"];
    
    self.arrArtists = artists;
    
//    for (NSDictionary *artist in artists) {
//        NSString *name = [artist objectForKey:@"name"];
//        NSLog(@"artist name: %@", name);
//        
////        if ([name isEqualToString:@"green"]) {
////            NSArray *pictures = [colour objectForKey:@"pictures"];
////            for (NSDictionary *picture in pictures) {
////                NSString *pictureName = [picture objectForKey:@"name"];
////                NSLog(@"Picture name: %@", pictureName);
////            }
////        }
//    }
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"artists" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}




@end
