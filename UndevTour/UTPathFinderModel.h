//
//  UTPathFinderModel.h
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTExhibit.h"
#import "UTBlockService.h"

@interface UTPathFinderModel : NSObject
- (id)initWithBlockService:(UTBlockService*)blockService;
- (NSArray*)findPathForObjects:(NSArray*)objects startOn:(UTExhibit*)startObject;
@end
