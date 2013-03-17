//
//  UTHouse.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTHouse.h"
#import "UTExhibit.h"
#import "UTLevel.h"

@implementation UTHouse

- (NSArray *)sortedByZOrderLevelByAscending:(BOOL)ascending {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"z" ascending:ascending];
    NSArray *sortedLevels = [self.levels sortedArrayUsingDescriptors:@[descriptor]];
    return sortedLevels;
}

- (UTExhibit *)exibitByHashCode:(NSString *)code {
    UTExhibit *exibit = nil;
    for (int i = 0; i < self.levels.count; i++) {
        UTLevel *lvl = [self.levels objectAtIndex:i];
        for (int j = 0; j < lvl.exhibits.count; j++) {
            UTExhibit *ex = [lvl.exhibits objectAtIndex:j];
            // пока так, потом переделать на настоящие хеши
            if ([ex.hash isEqualToString:code]) {
                exibit = ex;
                break;
            }
        }
    }
    return exibit;
}

- (NSInteger)levelIndexByExhibit:(UTExhibit *)exhibit {
    for (UTLevel *l in self.levels) {
        for (UTExhibit *ex in l.exhibits) {
            if ([ex.hash isEqual:exhibit.hash]) {
                return [l.z integerValue];
            }
        }
    }
    return NSNotFound;
}

@end
