
Su dung DbOperationQueue va DbOperation.
Neu hoan thanh cac Task trong DbOperation trong Sub Thread thi completeBlock cua DbOperationQueue cung la Sub Thread

=> Tao ham ke thua DbOperation

#import <UIKit/UIKit.h>
#import "DbOperation.h"

@interface TestDbOperation : DbOperation

@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithUrl:(NSURL *)url;

@end

#import "TestDbOperation.h"

@implementation TestDbOperation

- (instancetype)initWithUrl:(NSURL *)url
{
    if (self = [super init]) {
        self.url = url;
//        self.name = @"Answers-Retrieval";
    }
    return self;
}


#pragma mark - Start

- (void)start
{
    // -- Call parent start --
    [super start];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:self.url
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        self.completionOperationBlock([UIImage imageWithData:data], error);
        
        // -- Set finish status --
        [self finish];        
    }];
    
    [task resume];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    
    [self finish];
}

@end

=> Su dung trong ViewController

	NSArray *arr = @[
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_322002e1141eda32974f1b03911f0977fc1f281ba663b75285e9e728179993ec.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_54a009b346444cd462e03884b8e1128d072d1a4fd03acc79c6d25b71bfec1c90.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_01f66bb4bd31f0587412dd9c2a1288f9f0aba11027e7e799e816f1ff09aabd1e.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_f94901ab333536f84c77e363e73c1be01dcaf073570dba4460639363bb59d53b.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_3bcc49b4cba9bb0e51aa297452656b3b4c4f6214b6cf7fb39165bc6ca865b0d1.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_722fcded2ad5c78f5d61896b4837e309646e18b1b37c7c2d811171e0031d60c2.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_58af8732878839e1422ffcfb1882726f3e9518258a6706c15d8021d7294afab4.jpeg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_895d0a7874f6c3d70aa6fdf04a3125e185251bde81182ababc67b0e713c3db7d.jpg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_9090171b424cee391f514778628b2e6c1098342d39ed2f869871124b83989fe4.jpg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_16e2957cea12b22d532c80d215012d8e5c049746b79c60213c433bc3b5927af4.jpg",
                     @"http://test.cdn.propzy.vn/media_test/images/diy_img_5e4874575c0964baefc0b77d021d6e9005397255ed25a5255dfe0677ebaa7ff2.jpg"
                     ];
    
    
    DbOperationQueue *queue = [[DbOperationQueue alloc] init];
    // So thread xu ly dong thoi, neu maxConcurrentOperationCount = 1 chung ta se co kieu xu ly hang doi queue
    // => maxConcurrentOperationCount = 1 then you'll have a serial queue
	// NSLog(@"default maxConcurrentOperationCount = %ld", (long)queue.maxConcurrentOperationCount); // default -1
    queue.maxConcurrentOperationCount = 4;
    
    [queue setCompletionAllOperations:^{
        NSLog(@"%@", @"Da hoan tat CompletionAllOperations");
        // -- Run background --
        // [NSThread detachNewThreadSelector:@selector(doneAllOperators) toTarget:self withObject:nil];
        // -- Run main thread --
        [self performSelectorOnMainThread:@selector(doneAllOperators) withObject:nil waitUntilDone:NO];
    }];
    
    // -- Demo 1 --
//    for (NSString *strUrl in arr) {
//        TestDbOperation *testO = [[TestDbOperation alloc] initWithUrl:[NSURL URLWithString:strUrl]];
//        testO.completionOperationBlock = ^(id result, NSError *error) {
//            NSLog(@"Hoan tat : %@", strUrl);
//        };
//        [queue addOperation:testO];
//    }
    
    // -- Demo 2 --
    // Tao moi lien he giua cac operation, chi chay completionOperation khi tat ca cac "testO" da hoan thanh
    NSBlockOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", @"Da hoanh thanh Tat ca cac dependencies operator");
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            NSLog(@"RUN MAIN THREAD : %@", @"Da hoanh thanh Tat ca cac dependencies operator");
//        }];
    }];

    for (NSString *strUrl in arr) {
        TestDbOperation *testO = [[TestDbOperation alloc] initWithUrl:[NSURL URLWithString:strUrl]];
        testO.completionOperationBlock = ^(id result, NSError *error) {
            NSLog(@"Hoan tat : %@", strUrl);
        };
        [completionOperation addDependency:testO];
    }
	
	// Tao Operation with block
	for (NSString *strUrl in arr) {
        NSBlockOperation *testO = [NSBlockOperation blockOperationWithBlock:^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
            UIImage *image = [UIImage imageWithData:data];
            NSLog(@"image.size = %@", NSStringFromCGSize(image.size));
        }];
        testO.completionBlock = ^{
            NSLog(@"Hoan tat : %@", strUrl);
        };
        [completionOperation addDependency:testO];
    }
	
    // -- Add dependencies operator --
    [queue addOperations:completionOperation.dependencies waitUntilFinished:NO];
    // -- Add completion operator --
    [queue addOperation:completionOperation]; 


- (void)doneAllOperators
{
    NSLog(@"%@", @"Da hoan tat OPERATIORS FUNCTION");
}

=> Ket qua in ra la
1. Da hoanh thanh Tat ca cac dependencies operator
2. Da hoan tat CompletionAllOperations
3. Da hoan tat OPERATIORS FUNCTION

dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_group_t groupFinish = dispatch_group_create();
                     
for (NSDictionary *diyListingItem in diyListings) {
	for (NSDictionary *itemFile in [diyListingItem objectForKey:@"photoList"]) {
                             
         NSString *link = [itemFile objectForKey:@"link"];
         NSString *linkThumb = [link stringByReplacingOccurrencesOfString:@"/images/" withString:@"/thumbnail_for_similar/"];
         
         dispatch_group_async(groupFinish,queue,^{
            // Goi Group Enter khi bat dau thread
            dispatch_group_enter(groupFinish);

             //run first NSOperation here
             NSURL *url = [NSURL URLWithString:linkThumb];
             UIImage *imgCache = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
             
			 // Child thread
             dispatch_async(queue, ^{
                 NSString *linkThumbCrop = [NSString stringWithFormat:@"%@_crop", linkThumb];
                 //                            NSLog(@"Cache linkThumbCrop = %@", linkThumbCrop);
                 UIImage *imgCacheCrop = [imgCache cropCenterToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, 185)];
                 // -- Cache --
                 [[SDImageCache sharedImageCache] storeImage:imgCacheCrop forKey:linkThumbCrop];

                // Goi Group Leave khi ket thuc thread
                dispatch_group_leave(groupFinish);
             });
             
             // -- Cache --
             [[SDImageCache sharedImageCache] storeImage:imgCache forKey:linkThumb];
         });
	 }
 }
                     
dispatch_group_notify(groupFinish,queue,^{
	NSLog(@"Final block");
	//hide progress indicator here
	dispatch_async(dispatch_get_main_queue(), ^{
		done(responseObject.data);
	});
});


dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_group_t groupFinish = dispatch_group_create();
         
dispatch_group_async(groupFinish,queue,^{
    // Goi Group Enter khi bat dau thread
    dispatch_group_enter(groupFinish);

	// Goi service 1
	 syncRequestJsonWithUrl

    // Goi Group Leave khi ket thuc thread
    dispatch_group_leave(groupFinish);
});
 
dispatch_group_async(groupFinish,queue,^{
    // Goi Group Enter khi bat dau thread
    dispatch_group_enter(groupFinish);

	 // Goi service 2
	 syncRequestJsonWithUrl

    // Goi Group Leave khi ket thuc thread
    dispatch_group_leave(groupFinish);
});
                     
dispatch_group_notify(groupFinish,queue,^{
	NSLog(@"Final block");
	//hide progress indicator here
	dispatch_async(dispatch_get_main_queue(), ^{
		done(responseObject.data);
	});
});














