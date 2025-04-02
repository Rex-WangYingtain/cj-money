package cj_money

import std.unittest.*
import std.unittest.testmacro.*

@Test
class Float64ToInt64RoundTest {
    @TestCase
    public func test1() {
        @Expect(0, Float64ToInt64Round(0.0))
    }
    @TestCase
    public func test2() {
        @Expect(0, Float64ToInt64Round(0.3))
    }
    @TestCase
    public func test3() {
        @Expect(1, Float64ToInt64Round(0.5))
    }
    @TestCase
    public func test4() {
        @Expect(0, Float64ToInt64Round(-0.0))
    }
    @TestCase
    public func test5() {
        @Expect(0, Float64ToInt64Round(-0.4))
    }
    @TestCase
    public func test6() {
        @Expect(-1, Float64ToInt64Round(-0.5))
    }
    @TestCase
    public func test7() {
        @Expect(-2, Float64ToInt64Round(-1.5))
    }
    @TestCase
    public func test8() {
        @Expect(200, Float64ToInt64Round(200.0))
    }
    @TestCase
    public func test9() {
        @Expect(-200, Float64ToInt64Round(-200.0))
    }
    @TestCase
    public func test10() {
        @Expect(-970, Float64ToInt64Round(-970.0))
    }
    @TestCase
    public func test11() {
        @Expect(970, Float64ToInt64Round(970.0))
    }
    @TestCase
    public func test12() {
        @Expect(1020, Float64ToInt64Round(1020.3))
    }
    @TestCase
    public func test13() {
        @Expect(-1020, Float64ToInt64Round(-1020.3))
    }
    @TestCase
    public func test14() {
        @Expect(1021, Float64ToInt64Round(1020.5))
    }
    @TestCase
    public func test15() {
        @Expect(-1021, Float64ToInt64Round(-1020.5))
    }
}

// @Test
// class DecimalToBigIntRoundTest{
//     @TestCase
//     public func test1(){
//         @Expect(BigInt(0), DecimalToBigIntRound(Decimal(0.0)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test2(){
//         @Expect(BigInt(0), DecimalToBigIntRound(Decimal(0.3)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test3(){
//         @Expect(BigInt(1), DecimalToBigIntRound(Decimal(0.5)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test4(){
//         @Expect(BigInt(0), DecimalToBigIntRound(Decimal(-0.0)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test5(){
//         @Expect(BigInt(0), DecimalToBigIntRound(Decimal(-0.4)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test6(){
//         @Expect(BigInt(-1), DecimalToBigIntRound(Decimal(-0.5)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test7(){
//         @Expect(BigInt(-2), DecimalToBigIntRound(Decimal(-1.5)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test8(){
//         @Expect(BigInt(200), DecimalToBigIntRound(Decimal(200.0)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test9(){
//         @Expect(BigInt(-200), DecimalToBigIntRound(Decimal(-200.0)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test10(){
//         @Expect(BigInt(-970), DecimalToBigIntRound(Decimal(-970.0)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test11(){
//         @Expect(BigInt(970), DecimalToBigIntRound(Decimal(970.0)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test12(){
//         @Expect(BigInt(1020), DecimalToBigIntRound(Decimal(1020.3)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test13(){
//         @Expect(BigInt(-1020), DecimalToBigIntRound(Decimal(-1020.3)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test14(){
//         @Expect(BigInt(1021), DecimalToBigIntRound(Decimal(1020.5)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test15(){
//         @Expect(BigInt(-1021), DecimalToBigIntRound(Decimal(-1020.5)))  // 通过String创建的Decimal精度在小数点后16位？但够用了。
//     }
//     @TestCase
//     public func test16(){
//         @Expect(BigInt("-1134 1452 3534 5634 56244341435425432523452435021"), DecimalToBigIntRound(Decimal(-113414523534563456244341435425432523452435020.53123514354325326456424532513442142145312414212341235421)))
//     }
//     @TestCase
//     public func test17(){
//         @Expect(BigInt("102031245233647665876354321414253645432165444444444442651323524"), DecimalToBigIntRound(Decimal(102031245233647665876354321414253645432165444444444442651323524.431243564321345675432113456754321124354655432121324323456326342)))
//     }
// }