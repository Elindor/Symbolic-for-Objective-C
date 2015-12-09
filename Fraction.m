//
//  Fraction.m
//  Metodos Obj-C
//
//  Created by Gabriel Nopper on 08/04/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction


#pragma mark Init Methods
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithNumerator:(int)numerator denominator:(int)denominator {

    self = [super init];
    if (self) {
        _numerator = [NSNumber numberWithInt:numerator];
        _denominator = [NSNumber numberWithInt:denominator];
    }
    return self;
}

- (instancetype)initWithFraction:(Fraction*) fraction{
    
    self = [super init];
    if (self) {
        _numerator = [NSNumber numberWithInt:[fraction getNumerator]];
        _denominator = [NSNumber numberWithInt:[fraction getDenominator]];
    }
    return self;
}

- (instancetype) initWithDouble:(double) value withDecimalPrecision: (int) precision{
    
    if(precision < 0){
        NSLog(@"Warning: Fraction reveiced negative value in precision, and this is unnallowed. The interpreted precision was 0.");
        precision = 0;
    }
    if(precision > 16){
        NSLog(@"Warning: Fraction reveiced precision value above 16, and this is unnallowed due to precision loss at 17th decimal number on 64bit systems such as iOS devices. The interpreted precision was 16.");
        precision = 16;
    }
    
    self = [super init];
    if (self) {
        int den = 10;
        for(int i = 0; i < precision; i++) den *= 10;
        int num = (int)value;
        _numerator = [NSNumber numberWithInt:num * den];
        _denominator = [NSNumber numberWithInt:den];
        
        [self reduce];
    }
    
    return self;
}

#pragma mark I/O operations
-(void) print
{
    int n, d;
    n = [self.numerator intValue];
    d = [self.denominator intValue];
    NSLog(@"%d/%d", n, d);
    
}

-(double) convertToDouble
{
    if (self.denominator) return [self.numerator doubleValue] / [self.denominator intValue];
    else return NAN;
}

#pragma mark Setters
-(void) setNumeratorWithInt: (int) n
{
    self.numerator = [NSNumber numberWithInt:n];
}

-(void) setDenominatorWithInt: (int) d
{
    self.denominator = [NSNumber numberWithInt:d];
}

-(void) setTo: (int) n over: (int) d
{
    self.numerator = [NSNumber numberWithInt:n];
    self.denominator = [NSNumber numberWithInt:d];
}

#pragma mark Getters
-(int) getNumerator
{
    return [self.numerator intValue];
    
}

-(int) getDenominator
{
    return [self.denominator intValue];
}


#pragma mark Math Operations
-(void) add: (Fraction*) f
{
    
    self.numerator = [NSNumber numberWithInt:[self.numerator intValue] * [f.denominator intValue] + [self.denominator intValue] * [f.numerator intValue]];
    
    self.denominator = [NSNumber numberWithInt:[self.denominator intValue] * [f.denominator intValue]];
    
    [self reduce];
}


-(void) subtract: (Fraction*) f
{
    self.numerator = [NSNumber numberWithInt:[self.numerator intValue] * [f.denominator intValue] - [self.denominator intValue] * [f.numerator intValue]];
    self.denominator = [NSNumber numberWithInt:[self.denominator intValue] * [f.denominator intValue]];
    
    [self reduce];
}


-(void) multiply: (Fraction *) f
{
    self.numerator = [NSNumber numberWithInt:[self.numerator intValue] * [f.numerator intValue]];
    self.denominator = [NSNumber numberWithInt:[self.denominator intValue] * [f.denominator intValue]];
    
    [self reduce];
}


-(void) divide: (Fraction *) f
{
    self.numerator = [NSNumber numberWithInt:[self.numerator intValue] * [f.denominator intValue]];
    self.denominator = [NSNumber numberWithInt:[self.denominator intValue] * [f.numerator intValue]];
    
    [self reduce];
}


-(void) reduce
{
    int u = [self.numerator intValue];
    int v = [self.denominator intValue];
    int temp;
    
    while (v)
    {
        temp = u % v;
        u = v;
        v = temp;
    }
    int n = [self.numerator intValue];
    self.numerator =  [NSNumber numberWithInt:(n / u)];
    self.denominator = [NSNumber numberWithInt:([self.denominator intValue] / u)];
}

-(void) powerOf: (int) N{
    if(N == 0){
        [self setDenominatorWithInt:1];
        [self setNumeratorWithInt:1];
        return;
    }
    
    if(N < 0){
        NSNumber *temp = self.denominator;
        self.denominator = self.numerator;
        self.numerator = temp;
    }
    N = abs(N);
    for(int i = 0; i < N; i++){
        self.denominator = [NSNumber numberWithInteger:[self.denominator integerValue] * [self.denominator integerValue]];
        self.denominator = [NSNumber numberWithInteger:[self.numerator integerValue] * [self.numerator integerValue]];
    }
    [self reduce];
}


+(void)applyMMC:(Fraction*)frac1 Fraction2:(Fraction*) frac2{
    int m = [frac1.denominator intValue];
    int n = [frac2.denominator intValue];
    int mmc = [self mmc:m and:n];
    NSLog(@"MMC = %d", mmc);
    int num1 = [frac1.numerator intValue];
    num1 = num1 * mmc / m;
    [frac1 setTo:num1 over:mmc];
    
    int num2 = [frac2.numerator intValue];
    num2 = num2 * mmc / n;
    [frac2 setTo:num2 over:mmc];
    
}



#pragma mark Internal Processing
// Internal use only. This calculates the greatest commom multiple.
+(int)gcd:(int) m and:(int) n{
    int tmp;
    while(m) { tmp = m; m = n % m; n = tmp; }
    return n;
}
// Internal use only. This calculates the least commom multiple, or Mininum commom multiply.
+(int)mmc:(int) m and:(int) n
{
    return m / [self gcd:m and:n] * n;
}


@end