//
//  cxray.h
//  cxray
//
//  Created by Jiang on 2024/3/7.
//

#import <Foundation/Foundation.h>

//! Project version number for cxray.
FOUNDATION_EXPORT double cxrayVersionNumber;

//! Project version string for cxray.
FOUNDATION_EXPORT const unsigned char cxrayVersionString[];

#include <stdint.h>

void InternalStartXray(NSString *configDirectory);

void StartTunnel(NSString *config);
void StopTunnel(void);

// In this header, you should import all the public headers of your framework using statements like #import <cxray/PublicHeader.h>


