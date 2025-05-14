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
