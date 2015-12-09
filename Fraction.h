//
//  AppDelegate.h
//  Metodos Obj-C
//
//  Created by Gabriel Nopper on 08/04/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 This class is a symbolic math class. It treats a number as a Fraction, with integer numerator and denominators, allowing you to calculate without floating point imprecision while trading off on more data size.
 While this is usually limited due to small number limits, this class provides a useful Math-type to handle input calculations like Wolfram, and for most math study purpuses.
 The class also provides getters and setters, efficient calculation methods, conversion to double, reducing and applying least common multiple.
 **/
@interface Fraction : NSObject

@property NSNumber *numerator, *denominator;

//Class Methods



/**
 Instances a new Fraction with Numerator and Denominator Int values.
 **/
-(instancetype)initWithNumerator:(int)numerator denominator:(int)denominator;

/**
 Instances a new fraction with a given fraction, mirroring it's values.
 **/
-(instancetype)initWithFraction:(Fraction*) fraction;

/**
 Instances a new fraction with an approximation given a double value. Since there is precision loss with double values at several architectures, this approximation considers limited decimal places. Ex.: 2.754 with precision 2 is interpreted as 2.75.
 **/
- (instancetype) initWithDouble:(double) value withDecimalPrecision: (int) precision;


/**
 Prints the fraction value in num/dem format.
 **/
-(void) print;

/**
 Converts the fraction value into a floating point double value. Mind that this process is hardly reversible, and will often offer precision loss due to floating point approximation.
 **/
-(double) convertToDouble;

/**
 Sets the Fraction numerator to n.
 **/
-(void) setNumeratorWithInt: (int) n;

/**
 Sets the Fraction denominator to d.
 **/
-(void) setDenominatorWithInt: (int) d;

/**
 Sets the Fraction numerator to n, and denominator do d.
 **/
-(void) setTo: (int) n over: (int) d;

/**
 Fetches the Fraction numerator as a Int value.
 **/
-(int) getNumerator;

/**
 Fetches the Fraction denominator as a Int value.
 **/
-(int) getDenominator;

/**
 Adds to this Fraction another one.
 **/
-(void) add: (Fraction*) f;

/**
 Subtracts to this Fraction another one.
 **/
-(void) subtract: (Fraction*) f;

/**
 Multiplies this Fraction with another one. The result is only applied on this one.
 **/
-(void) multiply: (Fraction*) f;

/**
 Divides this Fraction with another one. The result is only applied on this one.
 **/
-(void) divide: (Fraction *) f;

/**
 Reduces this Fraction to the simplest form available.
 **/
-(void) reduce;

/**
 Operates the fraction as if powered by given number.
 **/
-(void) powerOf: (int) N;

//Static Methods

/**
 This method finds the least commom multiple between two given Fractions, and transform them into same-base numbers. This effect is applied on both Fractions.
 **/
+(void)applyMMC:(Fraction*)frac1 Fraction2:(Fraction*) frac2;

@end