//  Created by Oleg on 6/20/16.
//  Copyright © 2016 Oleg Hnidets. All rights reserved.
//

@import Foundation;
@class OHMySQLQueryContext, OHMySQLStoreCoordinator;

/// Represents a main context and store coordinator.
@interface OHMySQLContainer : NSObject

/// Shared manager.
/// @warning Will be removed in the future.
+ (nonnull OHMySQLContainer *)sharedManager;

/// Shared container
+ (nonnull OHMySQLContainer *)sharedContainer;

/// Single context that is used in the app. Context should be set by a user of this class.
@property (nonatomic, strong, nullable) OHMySQLQueryContext *mainQueryContext;

/// Single store coordinator.
@property (nonatomic, strong, readonly, nullable) OHMySQLStoreCoordinator *storeCoordinator;

@end

@compatibility_alias OHMySQLManager OHMySQLContainer;
