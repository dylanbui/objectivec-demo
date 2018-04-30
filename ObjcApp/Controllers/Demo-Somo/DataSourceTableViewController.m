////
//  TableViewSkeletonController.m
//  SomoDemo
//
//  Created by 向小辉 on 2017/11/25.
//  Copyright © 2017年 KINX. All rights reserved.
//

#import "DataSourceTableViewController.h"
#import "DataSourceTableViewCell.h"
#import "OtherTableViewCell.h"
#import "Somo.h"

@interface DataSourceTableViewController ()

@property (strong, nonatomic) NSMutableArray<NSNumber *> * dataSource;

@property (strong, nonatomic) SomoDataSourceProvider * provider;

@end

@implementation DataSourceTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	 
	[self.tableView registerNib:[UINib nibWithNibName:@"DataSourceTableViewCell" bundle:nil] forCellReuseIdentifier:@"id"];
	[self.tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"oid"];
	 
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
	self.navigationItem.titleView.contentMode = UIViewContentModeScaleAspectFit;
	
	#pragma mark - provider
//	将tableview的datasource指向SomoDataSourceProvider
//	当数据加载完成后，将tableview的datasource指向self
	self.provider = [[SomoDataSourceProvider alloc] initWithTableViewCellBlock:^UITableViewCell<SomoSkeletonLayoutProtocol> *(UITableView *tableView, NSIndexPath *indexPath) {
		if(indexPath.row%2 == 0){
			return [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
		}else{
			return [tableView dequeueReusableCellWithIdentifier:@"oid" forIndexPath:indexPath];
		} 
	} heightBlock:^CGFloat(UITableView *tableview, NSIndexPath *indexPath) {
		if(indexPath.row%2 == 0){
			return 120;
		}else{
			return 80;
		}
	}];
	self.tableView.dataSource = self.provider;
	self.tableView.delegate = self.provider;
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	//随便写一个代表网络请求3秒
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	__weak typeof(self) weakSelf = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		__strong typeof(weakSelf) strongSelf = weakSelf;
		[strongSelf load];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	});
}

- (void)load{
	
	for (NSInteger i = 0; i < 20; i++) {
		self.dataSource[i] = @(1);
	}
	#pragma mark -
	//==================================================
	self.tableView.dataSource = self;
	self.tableView.delegate = self; 
	[self.tableView reloadData];
	//==================================================
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(indexPath.row%2 == 0){
		return 120;
	}else{
		return 80;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.row%2 == 0){
		return [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
	}else{
		return [tableView dequeueReusableCellWithIdentifier:@"oid" forIndexPath:indexPath];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 在这里必调用 endSomo
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	[cell endSomo];
}

- (NSMutableArray<NSNumber *> *)dataSource{
	if (!_dataSource) {
		_dataSource = [NSMutableArray array];
	}
	return _dataSource;
}

@end
