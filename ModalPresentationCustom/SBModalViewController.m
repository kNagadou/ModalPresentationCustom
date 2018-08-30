//
//  SBModalViewController.m
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import "SBModalViewController.h"

@interface SBModalViewController ()
<
UITableViewDataSource,
UISearchBarDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerArea;
@property (nonatomic) BOOL needSetContentOffSet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *modalViewConstraintTop;
@end

@implementation SBModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search";
    self.tableView.tableHeaderView = searchBar;
    [searchBar sizeToFit];
    self.modalViewConstraintTop.constant = 44;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(self.headerArea.bounds.size.height, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    if (self.needSetContentOffSet){
        self.tableView.contentOffset = CGPointMake(0, -self.tableView.contentInset.top);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleTouchButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // do not
    }];
}

# pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
}

#pragma mark - UISearchBarDelgate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

@end
