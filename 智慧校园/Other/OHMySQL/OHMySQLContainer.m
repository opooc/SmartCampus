//  Created by Oleg on 6/20/16.
//  Copyright © 2016 Oleg Hnidets. All rights reserved.
//

#import "OHMySQLContainer.h"
#import "OHMySQLQueryContext.h"

static OHMySQLContainer *_sharedManager = nil;

@implementation OHMySQLContainer

+ (OHMySQLContainer *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [OHMySQLContainer new];
    });
    
    return _sharedManager;
}

+ (OHMySQLContainer *)sharedContainer {
	return [self sharedManager];
}

- (OHMySQLStoreCoordinator *)storeCoordinator {
    return self.mainQueryContext.storeCoordinator;
}

@end
