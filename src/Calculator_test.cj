package cj_money

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*

@Test
class addTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, -10000)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, 104305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, 30)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let m2: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let m2: Money = Money(0.0, "PHP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, 1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, add)
        @Expect(m.amount, -3042)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculator.calculate(m1, m2, add)
        })
    }
}

@Test
class subtractTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, -2460)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, -12462)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, 140305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, -10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let m2: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(0.0, "PHP")
        let m2: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, -1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, subtract)
        @Expect(m.amount, 236)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculator.calculate(m1, m2, subtract)
        })
    }
}

@Test
class multiplyTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, -15129)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, -138254)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, -2201490)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, 2)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let m2: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(0.0, "PHP")
        let m2: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, multiply)
        @Expect(m.amount, 22995)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculator.calculate(m1, m2, multiply)
        })
    }
}

@Test
class modulusTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, modulus)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, modulus)
        @Expect(m.amount, 1079)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, modulus)
        @Expect(m.amount, -3695)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, modulus)
        @Expect(m.amount, 10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "PHP")
        let m2: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, modulus)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, modulus)
        @Expect(m.amount, -1403)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculator.calculate(m1, m2, modulus)
        })
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(0, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let m: Money = calculator.calculate(m1, m2, modulus)
        })
    }
}

@Test
class divideTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, divide)
        @Expect(m.amount, -100)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, divide)
        @Expect(m.amount, -912)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, divide)
        @Expect(m.amount, -6795)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, divide)
        @Expect(m.amount, 50)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "PHP")
        let m2: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, divide)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m: Money = calculator.calculate(m1, m2, divide)
        @Expect(m.amount, 86)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculator.calculate(m1, m2, divide)
        })
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(0, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let m: Money = calculator.calculate(m1, m2, divide)
        })
    }
}

@Test
class absoluteTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 1230)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 11231)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 122305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, absolute)
        @Expect(m2.amount, 1639)
    }
}

@Test
class negativeTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, 1230)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, 11231)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, -122305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, -10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, -1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.calculate(m1, negative)
        @Expect(m2.amount, 1639)
    }
}

@Test
class allocateTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 1, 2)
        @Expect(m2.amount, -615)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 1, 13)
        @Expect(m2.amount, -863)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 2, 5)
        @Expect(m2.amount, 48922)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 0, 2)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 3, 2)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 3, 2)
        @Expect(m2.amount, 1801)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.allocate(m1, 49, 53)
        @Expect(m2.amount, -1515)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let m2: Money = calculator.allocate(m1, 0, -1)
        })
    }

    @TestCase
    public func test9() {
        let m: Money = Money(-12.3, "AED")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [1, 2])
        @Expect(ms[0].amount, -410)
        @Expect(ms[1].amount, -820)
    }
    @TestCase
    public func test10() {
        let m: Money = Money(-112.305, "COP")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [1, 3])
        @Expect(ms[0].amount, -2808)
        @Expect(ms[1].amount, -8423)
    }
    @TestCase
    public func test11() {
        let m: Money = Money(122.3054333, "KWD")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [2, 3, 2])
        @Expect(ms[0].amount, 34945)
        @Expect(ms[1].amount, 52416)
        @Expect(ms[2].amount, 34944)
    }
    @TestCase
    public func test12() {
        let m: Money = Money(0.1, "PLN")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [0, 1, 2])
        @Expect(ms[0].amount, 1)
        @Expect(ms[1].amount, 3)
        @Expect(ms[2].amount, 6)
    }
    @TestCase
    public func test13() {
        let m: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [0, 1, 2])
        @Expect(ms[0].amount, 0)
        @Expect(ms[1].amount, 0)
        @Expect(ms[2].amount, 0)
    }
    @TestCase
    public func test14() {
        let m: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [1, 2, 2])
        @Expect(ms[0].amount, 241)
        @Expect(ms[1].amount, 480)
        @Expect(ms[2].amount, 480)
    }
    @TestCase
    public func test15() {
        let m: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.allocate(m, [2, 2])
        @Expect(ms[0].amount, -820)
        @Expect(ms[1].amount, -819)
    }
    @TestCase
    public func test16() {
        let m: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<Money> = calculator.allocate(m, [])
        })
    }
    @TestCase
    public func test17() {
        let m: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<Money> = calculator.allocate(m, [0, 9, -1])
        })
    }
}

@Test
class roundTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 2)
        @Expect(m2.amount, -1200)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 1)
        @Expect(m2.amount, -11230)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 1)
        @Expect(m2.amount, 122310)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        println(m1.amount)
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 1)
        @Expect(m2.amount, 10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 1)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 1)
        @Expect(m2.amount, 1200)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let m2: Money = calculator.round(m1, 1)
        @Expect(m2.amount, -1640)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let m2: Money = calculator.round(m1, 0)
        })
    }
}

@Test
class splitTest {
    @TestCase
    public func test1() {
        let m: Money = Money(-12.3, "AED")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 3)
        @Expect(ms[0].amount, -410)
        @Expect(ms[1].amount, -410)
        @Expect(ms[2].amount, -410)
    }
    @TestCase
    public func test2() {
        let m: Money = Money(-112.305, "COP")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 4)
        @Expect(ms[0].amount, -2808)
        @Expect(ms[1].amount, -2808)
        @Expect(ms[2].amount, -2808)
        @Expect(ms[3].amount, -2807)
    }
    @TestCase
    public func test3() {
        let m: Money = Money(122.3054333, "KWD")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 7)
        @Expect(ms[0].amount, 17473)
        @Expect(ms[1].amount, 17472)
        @Expect(ms[2].amount, 17472)
        @Expect(ms[3].amount, 17472)
        @Expect(ms[1].amount, 17472)
        @Expect(ms[2].amount, 17472)
        @Expect(ms[3].amount, 17472)
    }
    @TestCase
    public func test4() {
        let m: Money = Money(0.1, "PLN")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 3)
        @Expect(ms[0].amount, 4)
        @Expect(ms[1].amount, 3)
        @Expect(ms[2].amount, 3)
    }
    @TestCase
    public func test5() {
        let m: Money = Money(0.0, "JEP")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 142)
        for (i in ms) {
            @Expect(i.amount, 0)
        }
    }
    @TestCase
    public func test6() {
        let m: Money = Money(12.012, "PHP")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 5)
        @Expect(ms[0].amount, 241)
        @Expect(ms[1].amount, 240)
        @Expect(ms[2].amount, 240)
        @Expect(ms[3].amount, 240)
        @Expect(ms[4].amount, 240)
    }
    @TestCase
    public func test7() {
        let m: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        let ms: ArrayList<Money> = calculator.split(m, 4)
        @Expect(ms[0].amount, -410)
        @Expect(ms[1].amount, -410)
        @Expect(ms[2].amount, -410)
        @Expect(ms[3].amount, -409)
    }
    @TestCase
    public func test8() {
        let m: Money = Money(-16.388, "TJS")
        let calculator: Calculator = Calculator()
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<Money> = calculator.split(m, 0)
        })
    }
}
