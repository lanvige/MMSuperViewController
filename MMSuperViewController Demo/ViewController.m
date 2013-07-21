//
//  ViewController.m
//  MMSuperViewController Demo
//
//  Created by Lanvige Jiang on 7/21/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "ViewController.h"
#import "MMFullTableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) MMListViewController *listViewController;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"Full Tableview";
            break;
        }
        case 1: {
            cell.textLabel.text = @"Header only";
            break;
        }
        case 2: {
            cell.textLabel.text = @"Footer only";
            break;
        }
        case 3: {
            cell.textLabel.text = @"Null Data";
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            self.listViewController = [[MMFullTableViewController alloc] init];
            [self.navigationController pushViewController:self.listViewController animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
