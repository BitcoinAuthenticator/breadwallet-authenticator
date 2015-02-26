//
//  NSData+Bitcoin.h
//  BreadWallet
//
//  Created by Aaron Voisine on 10/9/13.
//  Copyright (c) 2013 Aaron Voisine <voisine@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

#define VAR_INT16_HEADER        0xfd
#define VAR_INT32_HEADER        0xfe
#define VAR_INT64_HEADER        0xff

// bitcoin script opcodes: https://en.bitcoin.it/wiki/Script#Constants
#define OP_PUSHDATA1        0x4c
#define OP_PUSHDATA2        0x4d
#define OP_PUSHDATA4        0x4e
#define OP_DUP              0x76
#define OP_EQUAL            0x87
#define OP_EQUALVERIFY      0x88
#define OP_HASH160          0xa9
#define OP_CHECKSIG         0xac
#define OP_CHECKMULTISIG    0xae

#define OP_0                0x00
#define OP_1NEGATE          0x4f
#define OP_1                0x51
#define OP_2                0x52
#define OP_3                0x53
#define OP_4                0x54
#define OP_5                0x55
#define OP_6                0x56
#define OP_7                0x57
#define OP_8                0x58
#define OP_9                0x59
#define OP_10               0x5a
#define OP_11               0x5b
#define OP_12               0x5c
#define OP_13               0x5d
#define OP_14               0x5e
#define OP_15               0x5f
#define OP_16               0x60

#define OP_INVALIDOPCODE    0xff

@interface NSData (Bitcoin)

- (uint8_t)UInt8AtOffset:(NSUInteger)offset;
- (uint16_t)UInt16AtOffset:(NSUInteger)offset;
- (uint32_t)UInt32AtOffset:(NSUInteger)offset;
- (uint64_t)UInt64AtOffset:(NSUInteger)offset;
- (uint64_t)varIntAtOffset:(NSUInteger)offset length:(NSUInteger *)length;
- (NSData *)hashAtOffset:(NSUInteger)offset;
- (NSString *)stringAtOffset:(NSUInteger)offset length:(NSUInteger *)length;
- (NSData *)dataAtOffset:(NSUInteger)offset length:(NSUInteger *)length;
- (NSArray *)scriptElements; // an array of NSNumber and NSData objects representing each script element
- (int)intValue; // returns the opcode used to store the receiver in a script (i.e. OP_PUSHDATA1)
+(uint8_t)opCodeForNumber:(int)number;

@end
