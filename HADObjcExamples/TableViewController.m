//
//  TableViewController.m
//  HADObjCExample
//
//  Created by Mihael Isaev on 29/06/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

#import "TableViewController.h"
#import "AdCell.h"

@interface TableViewController () <HADBannerViewDelegate>

@end

@implementation TableViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 20 == 0) {
        static NSString *cellIdentifier = @"AD";
        ADCell *cell = (ADCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        [cell.bannerView loadAdWithPlacementId:@"5b3QbMRQ" bannerSize:HADBannerSizeHeight50 delegate:self];
        
        return cell;
    } else {
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        return cell;
    }
}

#pragma mark - HADBannerViewDelegate

-(void)HADViewDidLoadWithView:(HADBannerView *)view {
    NSLog(@"HADViewDidLoad");
}

-(void)HADViewWithView:(HADBannerView *)view didFailWithError:(NSError *)error {
    NSLog(@"HADViewDidFai:l %@", error);
}

-(void)HADViewDidClickWithView:(HADBannerView *)view {
    NSLog(@"HADViewDidClick");
}

@end
