//
//  LoadControllerViewController.m
//  MMSuperViewController Demo
//
//  Created by Lanvige Jiang on 3/10/15.
//  Copyright (c) 2015 Lanvige Jiang. All rights reserved.
//

#import "LoadControllerViewController.h"
#import "MMListEmptyDefaultView.h"
#import "MMLoadingDefaultView.h"

@interface LoadControllerViewController ()

@property (nonatomic, assign) BOOL isEmpty;

@end

@implementation LoadControllerViewController


- (id)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.placeholderView = [[MMListEmptyDefaultView alloc] initWithFrame:CGRectZero];
        self.loadingView = [[MMLoadingDefaultView alloc] initWithFrame:self.view.bounds];
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.isEmpty = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark Internal Methods

- (BOOL)empty
{
    return self.isEmpty;
}


- (void)loadData
{
    [super load];
    
    [self performSelector:@selector(loadCompleted)
               withObject:nil
               afterDelay:5.0];
}

- (void)loadCompleted
{
    [super loadCompleted];
    self.isEmpty = false;
}





@end
