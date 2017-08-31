//
//  ViewController.m
//  Loadingwave
//
//  Created by Antelis on 24/08/2017.
//  Copyright © 2017 shion. All rights reserved.
//

#import "ViewController.h"
#import "LoadingwaveView.h"
@interface ViewController ()
@property (nonatomic) LoadingwaveView *load;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
}
- (IBAction)showLoading:(id)sender{
    
    _load = [[LoadingwaveView alloc] initWithTitle:@"Loading..." countdown:5.5 waveColor:UIColor.purpleColor] ;
    [self.view addSubview:_load];
    
    
}

@end
