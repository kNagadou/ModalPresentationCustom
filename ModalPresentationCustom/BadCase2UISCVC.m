//
//  BadCase2UISCVC.m
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import "BadCase2UISCVC.h"

/*
 モーダルビューの表示位置を、アニメーターオブジェクトで制御するパターン
 */

@interface BadCase2UISCVC ()
<
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerArea;
@property (strong, nonatomic, nonnull) UISearchController *searchController;
@property (nonatomic) BOOL needSetContentOffSet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *modalViewConstraintTop;
@end

@implementation BadCase2UISCVC

- (nullable instancetype)initWithConstraintTop:(CGFloat)constant
{
    self = [super init];
    if (self) {
        self.modalViewConstraintTop.constant = constant;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    self.needSetContentOffSet = YES;
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

@end
