//
//  UTLevelBulder.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTLevelBulder.h"
#import "UTLevel.h"
#import "UTExhibit.h"

@implementation UTLevelBulder

- (UTLevel *)buildLevelFromDictionary:(NSDictionary *)dictionary {
    UTLevel *lvl = [[UTLevel alloc] init];
    
    lvl.imagePath = [dictionary objectForKey:@"image_path"];
    lvl.z = [dictionary objectForKey:@"z"];
    lvl.map = [dictionary objectForKey:@"map"];
    
    NSArray *exhibitsDicts = [dictionary objectForKey:@"objects"];
    NSMutableArray *exhibits = [NSMutableArray array];
    for (NSDictionary *exhibitDict in exhibitsDicts) {
        UTExhibit *exhibit = [[UTExhibit alloc] init];
        exhibit.iconPath = [exhibitDict objectForKey:@"icon_path"];
        exhibit.name = [exhibitDict objectForKey:@"name"];
        exhibit.definition = [exhibitDict objectForKey:@"description"];
        exhibit.photoPath = [exhibitDict objectForKey:@"photo_path"];
        exhibit.hash = [exhibitDict objectForKey:@"hash"];
        exhibit.selectedIconPath = [exhibitDict objectForKey:@"selected_icon_path"];
        NSDictionary *positionDict = [exhibitDict objectForKey:@"position"];
        NSInteger x = [[positionDict objectForKey:@"x"] integerValue];
        NSInteger y = [[positionDict objectForKey:@"y"] integerValue];
        exhibit.coordinate = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [exhibits addObject:exhibit];
    }
    lvl.exhibits = exhibits;
    return lvl;
}

@end
