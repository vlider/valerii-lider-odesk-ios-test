//
//  ViewController.m
//  BuggyProject
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import "ViewController.h"
#import "SomeClass.h"
#import "CoreDataHelpers.h"

#import "ModelsEntity.h"
#import "OwnerEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstBug:(id)sender {
	[SomeClass printTextInMain:@"Bug 1"];
}

- (IBAction)secondBug:(id)sender {
	__block NSInteger x = 123;
	void (^printX)() = ^() {
		NSLog(@"%li", (long)x);
	};
	x++;
	printX();
}

- (IBAction)thirdBug:(id)sender {
	[CoreDataHelpers fillUnsortedData];
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
	NSLog(@"%@", models);
}

- (IBAction)fourthBug:(id)sender {
	static NSInteger count = 1;
	if (count>1) {
		[CoreDataHelpers cleanData];
        [CoreDataHelpers fillUnsortedData];
	}
	
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
	NSLog(@"%@", models);
	
	count++;
}

- (IBAction)fifthBug:(id)sender {
	[CoreDataHelpers fillUnsortedData];
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
    models = [models sortedArrayUsingComparator:^NSComparisonResult(ModelsEntity *obj1, ModelsEntity *obj2) {
        
        NSComparisonResult result = [obj1.modelName compare:obj2.modelName];
        if (NSOrderedSame == result) {
            result = [obj1.owner.ownerName compare:obj2.owner.ownerName];
        }
        
        return result;
    }];
    
	NSLog(@"%@", models);
}

@end
