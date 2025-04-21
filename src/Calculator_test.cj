package cj_money

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*

import std.math.numeric.*

@Test
class addTest {
    // Money
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, -10000)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, 104305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, 30)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let m2: Money = Money(0.0, "JEP")
        
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let m2: Money = Money(0.0, "PHP")
        
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, 1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        
        let m: Money = calculate(m1, m2, add)
        @Expect(m.amount, -3042)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculate(m1, m2, add)
        })
    }
    // BigMoney
    @TestCase
    public func test9() {
        let m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        let m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        
        let m: BigMoney = calculate(m1, m2, add)
        @Expect(m.amount, BigInt(0))
    }
    @TestCase
    public func test10() {
        let m1: BigMoney = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        let m2: BigMoney = BigMoney("23453256443253245325145432.2342", "COP")
        
        let m: BigMoney = calculate(m1, m2, add)
        @Expect(m.amount, BigInt("-8972222947842960358202067802600"))
    }
    @TestCase
    public func test11() {
        let m1: BigMoney = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        let m2: BigMoney = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        
        let m: BigMoney = calculate(m1, m2, add)
        @Expect(m.amount, BigInt("121234144020509992800971228068"))
    }
    @TestCase
    public func test12() {
        let m1: BigMoney = BigMoney("0.0", "JEP")
        let m2: BigMoney = BigMoney("0.0", "JEP")
        
        let m: BigMoney = calculate(m1, m2, add)
        @Expect(m.amount, BigInt(0))
    }
    @TestCase
    public func test13() {
        let m1: BigMoney = BigMoney("11342144425123412444455555555555553253411342.0153545124124123444444444444413234112", "PHP")
        let m2: BigMoney = BigMoney("0.0", "PHP")
        
        let m: BigMoney = calculate(m1, m2, add)
        @Expect(m.amount, BigInt("1134214442512341244445555555555555325341134202"))
    }
    @TestCase
    public func test14() {
        let m1: BigMoney = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        let m2: BigMoney = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        
        let m: BigMoney = calculate(m1, m2, add)
        @Expect(m.amount, BigInt("-16243575867119067685449707476787963"))
    }
    @TestCase
    public func test15() {
        let m1: BigMoney = BigMoney("-22452352345432532223444444444444444444444444423452314.024555555555551243253253252325", "PHP")
        let m2: BigMoney = BigMoney("-11431455312451342144245325256476543252356.324353242452345432453253288", "TJS")
        
        @ExpectThrows[CurrencyNotSameException]({
            let m: BigMoney = calculate(m1, m2, add)
        })
    }
}

@Test
class subtractTest {
    // Money
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, -2460)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, -12462)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, 140305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, -10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let m2: Money = Money(0.0, "JEP")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(0.0, "PHP")
        let m2: Money = Money(12.012, "PHP")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, -1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        
        let m: Money = calculate(m1, m2, subtract)
        @Expect(m.amount, 236)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculate(m1, m2, subtract)
        })
    }
    // BigMoney
    @TestCase
    public func test9() {
        let m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        let m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        
        let m: BigMoney = calculate(m1, m2, subtract)
        @Expect(m.amount, BigInt("26282508262887072915331531124870684264938"))
    }
    @TestCase
    public func test10() {
        let m1: BigMoney = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        let m2: BigMoney = BigMoney("23453256443253245325145432.2342", "COP")
        
        let m: BigMoney = calculate(m1, m2, subtract)
        @Expect(m.amount, BigInt("-8976913599131611007267096889046"))
    }
    @TestCase
    public func test11() {
        let m1: BigMoney = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        let m2: BigMoney = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        
        let m: BigMoney = calculate(m1, m2, subtract)
        @Expect(m.amount, BigInt("121234506488778477849681696538"))
    }
    @TestCase
    public func test12() {
        let m1: BigMoney = BigMoney("0.0", "JEP")
        let m2: BigMoney = BigMoney("0.0", "JEP")
        
        let m: BigMoney = calculate(m1, m2, subtract)
        @Expect(m.amount, BigInt(0))
    }
    @TestCase
    public func test13() {
        let m1: BigMoney = BigMoney("11342144425123412444455555555555553253411342.0153545124124123444444444444413234112", "PHP")
        let m2: BigMoney = BigMoney("0.0", "PHP")
        
        let m: BigMoney = calculate(m1, m2, subtract)
        @Expect(m.amount, BigInt("1134214442512341244445555555555555325341134202"))
    }
    @TestCase
    public func test14() {
        let m1: BigMoney = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        let m2: BigMoney = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        
        let m: BigMoney = calculate(m1, m2, subtract)
        @Expect(m.amount, BigInt("16243329038007779217201198772097115"))
    }
    @TestCase
    public func test15() {
        let m1: BigMoney = BigMoney("-22452352345432532223444444444444444444444444423452314.024555555555551243253253252325", "PHP")
        let m2: BigMoney = BigMoney("-11431455312451342144245325256476543252356.324353242452345432453253288", "TJS")
        
        @ExpectThrows[CurrencyNotSameException]({
            let m: BigMoney = calculate(m1, m2, subtract)
        })
    }
}

@Test
class multiplyTest {
    // Money
    // round
    @TestCase
    public func test_Money_round() {
        var m1: Money = Money(-12.3, "AED")
        var m2: Money = Money(12.3, "AED")
        var m: Money = calculate(m1, m2, multiply, mode: "round")
        @Expect(m.amount, -15129)

        m1 = Money(-112.305, "COP")
        m2 = Money(12.31, "COP")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, -138254)

        m1 = Money(122.3054333, "KWD")
        m2 = Money(-18.0, "KWD")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, -2201490)

        m1 = Money(0.1, "PLN")
        m2 = Money(0.2, "PLN")
        m = calculate(m1, m2, multiply, mode: "round")
        @Expect(m.amount, 2)

        m1 = Money(0.0, "JEP")
        m2 = Money(0.0, "JEP")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, 0)

        m1 = Money(0.0, "PHP")
        m2 = Money(12.012, "PHP")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, 0)

        m1 = Money(-14.025, "TJS")
        m2 = Money(-16.388, "TJS")
        m = calculate(m1, m2, multiply, mode: "round")
        @Expect(m.amount, 22995)
    }
    // truncate
    @TestCase
    public func test_Money_truncate() {
        var m1: Money = Money(-12.3, "AED")
        var m2: Money = Money(12.3, "AED")
        var m: Money = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, -15129)

        m1 = Money(-112.305, "COP")
        m2 = Money(12.31, "COP")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, -138253)

        m1 = Money(122.3054333, "KWD")
        m2 = Money(-18.0, "KWD")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, -2201490)

        m1 = Money(0.1, "PLN")
        m2 = Money(0.2, "PLN")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, 2)

        m1 = Money(0.0, "JEP")
        m2 = Money(0.0, "JEP")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, 0)

        m1 = Money(0.0, "PHP")
        m2 = Money(12.012, "PHP")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, 0)

        m1 = Money(-14.025, "TJS")
        m2 = Money(-16.388, "TJS")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, 22995)
    }
    // ceil
    @TestCase
    public func test_Money_ceil() {
        var m1: Money = Money(-12.3, "AED")
        var m2: Money = Money(12.3, "AED")
        var m: Money = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, -15130)

        m1 = Money(-112.305, "COP")
        m2 = Money(12.31, "COP")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, -138254)

        m1 = Money(122.3054333, "KWD")
        m2 = Money(-18.0, "KWD")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, -2201491)

        m1 = Money(0.1, "PLN")
        m2 = Money(0.2, "PLN")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, 3)

        m1 = Money(0.0, "JEP")
        m2 = Money(0.0, "JEP")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, 0)

        m1 = Money(0.0, "PHP")
        m2 = Money(12.012, "PHP")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, 0)

        m1 = Money(-14.025, "TJS")
        m2 = Money(-16.388, "TJS")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, 22996)
    }
    // exception
    @TestCase
    public func test_Money_exception() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        let m3: Money = Money(-324453.432, "PHP")
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculate(m1, m2, multiply)
        })
        @ExpectThrows[IllegalArgumentException]({
            let m: Money = calculate(m1, m3, multiply, mode: "cangjie")
        })
    }

    // BigMoney
    // round
    @TestCase
    public func test_BigMoney_round() {
        var m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        var m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        var m: BigMoney = calculate(m1, m2, multiply, mode: "round")
        @Expect(m.amount, BigInt("-1726925601471818157742954212185406518843668026250390972878265272374586563440360"))

        m1 = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        m2 = BigMoney("23453256443253245325145432.2342", "COP")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, BigInt("-210482851185581836477635665284479800915983370836146670075"))

        m1 = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        m2 = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, BigInt("-21971797978002054031917875765532458497894733462543"))

        m1 = BigMoney("0.0", "JEP")
        m2 = BigMoney("0.0", "JEP")
        m = calculate(m1, m2, multiply, mode: "round")
        @Expect(m.amount, BigInt(0))

        m1 = BigMoney("11342144425123412444455555555555553253411342.0153545124124123444444444444413234112", "PHP")
        m2 = BigMoney("0.0", "PHP")
        m = calculate(m1, m2, multiply)
        @Expect(m.amount, BigInt("0"))

        m1 = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        m2 = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        m = calculate(m1, m2, multiply, mode: "round")
        @Expect(m.amount, BigInt("20046784665613598801663038482248773622429610047523647371675915"))
    }
    // truncate
    @TestCase
    public func test_BigMoney_truncate() {
        var m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        var m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        var m: BigMoney = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, BigInt("-1726925601471818157742954212185406518843668026250390972878265272374586563440359"))

        m1 = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        m2 = BigMoney("23453256443253245325145432.2342", "COP")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, BigInt("-210482851185581836477635665284479800915983370836146670075"))

        m1 = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        m2 = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, BigInt("-21971797978002054031917875765532458497894733462543"))

        m1 = BigMoney("0.0", "JEP")
        m2 = BigMoney("0.0", "JEP")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, BigInt(0))

        m1 = BigMoney("11342144425123412444455555555555553253411342.0153545124124123444444444444413234112", "PHP")
        m2 = BigMoney("0.0", "PHP")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, BigInt("0"))

        m1 = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        m2 = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        m = calculate(m1, m2, multiply, mode: "truncate")
        @Expect(m.amount, BigInt("20046784665613598801663038482248773622429610047523647371675915"))
    }
    // ceil
    @TestCase
    public func test_BigMoney_ceil() {
        var m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        var m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        var m: BigMoney = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, BigInt("-1726925601471818157742954212185406518843668026250390972878265272374586563440360"))

        m1 = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        m2 = BigMoney("23453256443253245325145432.2342", "COP")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, BigInt("-210482851185581836477635665284479800915983370836146670076"))

        m1 = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        m2 = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, BigInt("-21971797978002054031917875765532458497894733462544"))

        m1 = BigMoney("0.0", "JEP")
        m2 = BigMoney("0.0", "JEP")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, BigInt(0))

        m1 = BigMoney("11342144425123412444455555555555553253411342.0153545124124123444444444444413234112", "PHP")
        m2 = BigMoney("0.0", "PHP")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, BigInt("0"))

        m1 = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        m2 = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        m = calculate(m1, m2, multiply, mode: "ceil")
        @Expect(m.amount, BigInt("20046784665613598801663038482248773622429610047523647371675916"))
    }
    // exception
    @TestCase
    public func test_BigMoney_exception() {
        let m1: BigMoney = BigMoney("-22452352345432532223444444444444444444444444423452314.024555555555551243253253252325", "PHP")
        let m2: BigMoney = BigMoney("-11431455312451342144245325256476543252356.324353242452345432453253288", "TJS")
        let m3: BigMoney = BigMoney("2245234423452314.024555555555253253252325", "PHP")
        @ExpectThrows[CurrencyNotSameException]({
            let m: BigMoney = calculate(m1, m2, multiply)
        })
        @ExpectThrows[IllegalArgumentException]({
            let m: BigMoney = calculate(m1, m3, multiply, mode: "cangjie")
        })
    }
}

@Test
class modulusTest {
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = Money(12.3, "AED")
        
        let m: Money = calculate(m1, m2, modulus)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = Money(12.31, "COP")
        
        let m: Money = calculate(m1, m2, modulus)
        @Expect(m.amount, 1079)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = Money(-18.0, "KWD")
        
        let m: Money = calculate(m1, m2, modulus)
        @Expect(m.amount, -3695)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = Money(0.2, "PLN")
        
        let m: Money = calculate(m1, m2, modulus)
        @Expect(m.amount, 10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "PHP")
        let m2: Money = Money(12.012, "PHP")
        
        let m: Money = calculate(m1, m2, modulus)
        @Expect(m.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(-16.388, "TJS")
        
        let m: Money = calculate(m1, m2, modulus)
        @Expect(m.amount, -1403)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-14.025, "PHP")
        let m2: Money = Money(-16.388, "TJS")
        
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculate(m1, m2, modulus)
        })
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(0, "TJS")
        
        @ExpectThrows[IllegalArgumentException]({
            let m: Money = calculate(m1, m2, modulus)
        })
    }
    // BigMoney
    @TestCase
    public func test9() {
        let m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        let m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        
        let m: BigMoney = calculate(m1, m2, modulus)
        @Expect(m.amount, BigInt(0))
    }
    @TestCase
    public func test10() {
        let m1: BigMoney = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        let m2: BigMoney = BigMoney("23453256443253245325145432.2342", "COP")
        
        let m: BigMoney = calculate(m1, m2, modulus)
        @Expect(m.amount, BigInt("992967345731303198574568598"))
    }
    @TestCase
    public func test11() {  // 3
        let m1: BigMoney = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        let m2: BigMoney = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        
        let m: BigMoney = calculate(m1, m2, modulus)
        @Expect(m.amount, BigInt("-74037281521816352230127"))
    }
    @TestCase
    public func test12() {
        let m1: BigMoney = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        let m2: BigMoney = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        
        let m: BigMoney = calculate(m1, m2, modulus)
        @Expect(m.amount, BigInt("-123414555644234124254352345424"))
    }
    @TestCase
    public func test13() {
        let m1: BigMoney = BigMoney("-22452352345432532223444444444444444444444444423452314.024555555555551243253253252325", "PHP")
        let m2: BigMoney = BigMoney("-11431455312451342144245325256476543252356.324353242452345432453253288", "TJS")
        
        @ExpectThrows[CurrencyNotSameException]({
            let m: BigMoney = calculate(m1, m2, modulus)
        })
    }
}

@Test
class divideTest {
    // Money
    // round
    @TestCase
    public func test_Money_round() {
        var m1: Money = Money(-12.3, "AED")
        var m2: Money = Money(12.3, "AED")
        var m: Money = calculate(m1, m2, divide, mode: "round")
        @Expect(m.amount, -100)

        m1 = Money(-112.305, "COP")
        m2 = Money(12.31, "COP")
        m = calculate(m1, m2, divide)
        @Expect(m.amount, -912)

        m1 = Money(122.3054333, "KWD")
        m2 = Money(-18.0, "KWD")
        m = calculate(m1, m2, divide, mode: "round")
        @Expect(m.amount, -6795)

        m1 = Money(0.1, "PLN")
        m2 = Money(0.2, "PLN")
        m = calculate(m1, m2, divide)
        @Expect(m.amount, 50)

        m1 = Money(0.0, "PHP")
        m2 = Money(12.012, "PHP")
        m = calculate(m1, m2, divide)
        @Expect(m.amount, 0)

        m1 = Money(-14.025, "TJS")
        m2 = Money(-16.388, "TJS")
        m = calculate(m1, m2, divide, mode: "round")
        @Expect(m.amount, 86)
    }
    // truncate
    @TestCase
    public func test_Money_truncate() {
        var m1: Money = Money(-12.3, "AED")
        var m2: Money = Money(12.3, "AED")
        var m: Money = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, -100)

        m1 = Money(-112.305, "COP")
        m2 = Money(12.31, "COP")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, -912)

        m1 = Money(122.3054333, "KWD")
        m2 = Money(-18.0, "KWD")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, -6794)

        m1 = Money(0.1, "PLN")
        m2 = Money(0.2, "PLN")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, 50)

        m1 = Money(0.0, "PHP")
        m2 = Money(12.012, "PHP")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, 0)

        m1 = Money(-14.025, "TJS")
        m2 = Money(-16.388, "TJS")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, 85)
    }
    // ceil
    @TestCase
    public func test_Money_ceil() {
        var m1: Money = Money(-12.3, "AED")
        var m2: Money = Money(12.3, "AED")
        var m: Money = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, -101)

        m1 = Money(-112.305, "COP")
        m2 = Money(12.31, "COP")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, -913)

        m1 = Money(122.3054333, "KWD")
        m2 = Money(-18.0, "KWD")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, -6793)

        m1 = Money(0.1, "PLN")
        m2 = Money(0.2, "PLN")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, 51)

        m1 = Money(0.0, "PHP")
        m2 = Money(12.012, "PHP")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, 0)

        m1 = Money(-14.025, "TJS")
        m2 = Money(-16.388, "TJS")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, 84)
    }
    // exception
    @TestCase
    public func test_Money_exception(){
        let m1: Money = Money(-14.025, "TJS")
        let m2: Money = Money(0, "PHP")
        let m3: Money = Money(-14.025, "TJS")
        @ExpectThrows[CurrencyNotSameException]({
            let m: Money = calculate(m1, m2, divide)
        })
        @ExpectThrows[IllegalArgumentException]({
            let m: Money = calculate(m1, m3, divide)
        })
    }
    // BigMoney
    // round
    @TestCase
    public func test_BigMoney_round() {
        var m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        var m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        var m: BigMoney = calculate(m1, m2, divide, mode: "round")
        @Expect(m.amount, BigInt(-100))

        m1 = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        m2 = BigMoney("23453256443253245325145432.2342", "COP")
        m = calculate(m1, m2, divide)
        @Expect(m.amount, BigInt("-382658"))

        m1 = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        m2 = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        m = calculate(m1, m2, divide, mode: "round")
        @Expect(m.amount, BigInt("-668937591"))

        m1 = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        m2 = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        m = calculate(m1, m2, divide)
        @Expect(m.amount, BigInt(0))
    }
    // truncate
    @TestCase
    public func test_BigMoney_truncate() {
        var m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        var m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        var m: BigMoney = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, BigInt(-100))

        m1 = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        m2 = BigMoney("23453256443253245325145432.2342", "COP")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, BigInt("-382657"))

        m1 = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        m2 = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, BigInt("-668937591"))

        m1 = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        m2 = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        m = calculate(m1, m2, divide, mode: "truncate")
        @Expect(m.amount, BigInt(0))
    }
    // ceil
    @TestCase
    public func test_BigMoney_ceil() {
        var m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        var m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        var m: BigMoney = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, BigInt(-100))

        m1 = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        m2 = BigMoney("23453256443253245325145432.2342", "COP")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, BigInt("-382657"))

        m1 = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        m2 = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, BigInt("-668937591"))

        m1 = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        m2 = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        m = calculate(m1, m2, divide, mode: "ceil")
        @Expect(m.amount, BigInt(0))
    }
    // exception
    @TestCase
    public func test_BigMoney_exception() {
        let m1: BigMoney = BigMoney("-22452352345432532223444444444444444444444444423452314.024555555555551243253253252325", "PHP")
        let m2: BigMoney = BigMoney("-11431455312451342144245325256476543252356.324353242452345432453253288", "TJS")
        let m3: BigMoney = BigMoney("224523523444423452314.02455555551243253253252325", "PHP")
        @ExpectThrows[CurrencyNotSameException]({
            let m: BigMoney = calculate(m1, m2, divide)
        })
        @ExpectThrows[IllegalArgumentException]({
            let m: BigMoney = calculate(m1, m3, divide, mode: "cangjie")
        })
    }
}

@Test
class absoluteTest {
    // Money
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 1230)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 11231)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 122305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        
        let m2: Money = calculate(m1, absolute)
        @Expect(m2.amount, 1639)
    }
    // BigMoney
    @TestCase
    public func test8() {
        let m1: BigMoney = BigMoney("11345443412352344235356444444465444444413435234532532522.30541324413241234122222333", "KWD")
        
        let m2: BigMoney = calculate(m1, absolute)
        @Expect(m2.amount, BigInt("11345443412352344235356444444465444444413435234532532522305"))
    }
    @TestCase
    public func test9() {
        let m1: BigMoney = BigMoney("000000.00", "PLN")
        
        let m2: BigMoney = calculate(m1, absolute)
        @Expect(m2.amount, BigInt("0"))
    }
    @TestCase
    public func test10() {
        let m1: BigMoney = BigMoney("-794859823475872345892345823489578923458243657647.2345283975892734587328947598324", "PLN")
        
        let m2: BigMoney = calculate(m1, absolute)
        @Expect(m2.amount, BigInt("79485982347587234589234582348957892345824365764723"))
    }
}

@Test
class negativeTest {
    // Money
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, 1230)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, 11231)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, -122305)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, -10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, -1201)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        
        let m2: Money = calculate(m1, negative)
        @Expect(m2.amount, 1639)
    }
    // BigMoney
    @TestCase
    public func test8() {
        let m1: BigMoney = BigMoney("11345443412352344235356444444465444444413435234532532522.30541324413241234122222333", "KWD")
        
        let m2: BigMoney = calculate(m1, negative)
        @Expect(m2.amount, BigInt("-11345443412352344235356444444465444444413435234532532522305"))
    }
    @TestCase
    public func test9() {
        let m1: BigMoney = BigMoney("000000.00", "PLN")
        
        let m2: BigMoney = calculate(m1, negative)
        @Expect(m2.amount, BigInt("0"))
    }
    @TestCase
    public func test10() {
        let m1: BigMoney = BigMoney("-794859823475872345892345823489578923458243657647.2345283975892734587328947598324", "PLN")
        
        let m2: BigMoney = calculate(m1, negative)
        @Expect(m2.amount, BigInt("79485982347587234589234582348957892345824365764723"))
    }
}

@Test
class allocateTest {
    // Money
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        
        let m2: Money = allocate(m1, 1, 2)
        @Expect(m2.amount, -615)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        
        let m2: Money = allocate(m1, 1, 13)
        @Expect(m2.amount, -863)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        
        let m2: Money = allocate(m1, 2, 5)
        @Expect(m2.amount, 48922)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        
        let m2: Money = allocate(m1, 0, 2)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        
        let m2: Money = allocate(m1, 3, 2)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        
        let m2: Money = allocate(m1, 3, 2)
        @Expect(m2.amount, 1801)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        let m2: Money = allocate(m1, 49, 53)
        @Expect(m2.amount, -1515)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-16.388, "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let m2: Money = allocate(m1, 0, -1)
        })
    }

    @TestCase
    public func test9() {
        let m: Money = Money(-12.3, "AED")
        let ms: ArrayList<Money> = allocate(m, [1, 2])
        @Expect(ms[0].amount, -410)
        @Expect(ms[1].amount, -820)
    }
    @TestCase
    public func test10() {
        let m: Money = Money(-112.305, "COP")
        let ms: ArrayList<Money> = allocate(m, [1, 3])
        @Expect(ms[0].amount, -2808)
        @Expect(ms[1].amount, -8423)
    }
    @TestCase
    public func test11() {
        let m: Money = Money(122.3054333, "KWD")
        let ms: ArrayList<Money> = allocate(m, [2, 3, 2])
        @Expect(ms[0].amount, 34945)
        @Expect(ms[1].amount, 52416)
        @Expect(ms[2].amount, 34944)
    }
    @TestCase
    public func test12() {
        let m: Money = Money(0.1, "PLN")
        let ms: ArrayList<Money> = allocate(m, [0, 1, 2])
        @Expect(ms[0].amount, 1)
        @Expect(ms[1].amount, 3)
        @Expect(ms[2].amount, 6)
    }
    @TestCase
    public func test13() {
        let m: Money = Money(0.0, "JEP")
        let ms: ArrayList<Money> = allocate(m, [0, 1, 2])
        @Expect(ms[0].amount, 0)
        @Expect(ms[1].amount, 0)
        @Expect(ms[2].amount, 0)
    }
    @TestCase
    public func test14() {
        let m: Money = Money(12.012, "PHP")
        let ms: ArrayList<Money> = allocate(m, [1, 2, 2])
        @Expect(ms[0].amount, 241)
        @Expect(ms[1].amount, 480)
        @Expect(ms[2].amount, 480)
    }
    @TestCase
    public func test15() {
        let m: Money = Money(-16.388, "TJS")
        let ms: ArrayList<Money> = allocate(m, [2, 2])
        @Expect(ms[0].amount, -820)
        @Expect(ms[1].amount, -819)
    }
    @TestCase
    public func test16() {
        let m: Money = Money(-16.388, "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<Money> = allocate(m, [])
        })
    }
    @TestCase
    public func test17() {
        let m: Money = Money(-16.388, "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<Money> = allocate(m, [0, 9, -1])
        })
    }

    // BigMoney
    @TestCase
    public func test18() {
        let m1: BigMoney = BigMoney("248792374509827345872943578923578293472834.2432432345", "AED")
        let m2: BigMoney = allocate(m1, 1, 2)
        @Expect(m2.amount, BigInt("12439618725491367293647178946178914673641712"))
    }
    @TestCase
    public func test19() {
        let m1: BigMoney = BigMoney("-84973252498376987234863426136491238475648739568347282362843.2342532252353254325", "COP")
        let m2: BigMoney = allocate(m1, 5, 13)
        @Expect(m2.amount, BigInt("-3268202019168345662879362543711201479832643829551818552417047"))
    }
    @TestCase
    public func test20() {
        let m1: BigMoney = BigMoney("0.00", "COP")
        let m2: BigMoney = allocate(m1, 5, 13)
        @Expect(m2.amount, BigInt(0))
    }
    @TestCase
    public func test21() {
        let m1: BigMoney = BigMoney("-1324531432453256.32544234523588", "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let m2: BigMoney = allocate(m1, 0, -1)
        })
    }

    @TestCase
    public func test22() {
        let m: BigMoney = BigMoney("54328798964283462879435872328346328767328757834758347856324876578234.234523532532534322334", "KWD")
        let ms: ArrayList<BigMoney> = allocate(m, [2, 3, 2])
        @Expect(ms[0].amount, BigInt("15522513989795275108410249236670379647808216524216670816092821879495496"))
        @Expect(ms[1].amount, BigInt("23283770984692912662615373855005569471712324786325006224139232819243244"))
        @Expect(ms[2].amount, BigInt("15522513989795275108410249236670379647808216524216670816092821879495495"))
    }
    @TestCase
    public func test23() {
        let m: BigMoney = BigMoney("-724382786724386734587324578925027984328747328562347857824378.1284542345234234", "PLN")
        let ms: ArrayList<BigMoney> = allocate(m, [0, 1, 2])
        @Expect(ms[0].amount, BigInt("-1"))
        @Expect(ms[1].amount, BigInt("-24146092890812891152910819297500932810958244285411595260812604"))
        @Expect(ms[2].amount, BigInt("-48292185781625782305821638595001865621916488570823190521625208"))
    }
    @TestCase
    public func test24() {
        let m: BigMoney = BigMoney("-18724378234786234563287452345782362738972783458342765327856.323422222222222223542352388", "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<BigMoney> = allocate(m, [])
        })
    }
    @TestCase
    public func test25() {
        let m: BigMoney = BigMoney("-1423543253252354325325235334562533455463634565425325234436.423432423335634663436534535688", "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<BigMoney> = allocate(m, [0, 9, -1])
        })
    }
}

@Test
class roundTest {
    // Money
    @TestCase
    public func test1() {
        let m1: Money = Money(-12.3, "AED")
        let m2: Money = round(m1, 2)
        @Expect(m2.amount, -1200)
    }
    @TestCase
    public func test2() {
        let m1: Money = Money(-112.305, "COP")
        let m2: Money = round(m1, 1)
        @Expect(m2.amount, -11230)
    }
    @TestCase
    public func test3() {
        let m1: Money = Money(122.3054333, "KWD")
        let m2: Money = round(m1, 1)
        @Expect(m2.amount, 122310)
    }
    @TestCase
    public func test4() {
        let m1: Money = Money(0.1, "PLN")
        let m2: Money = round(m1, 1)
        @Expect(m2.amount, 10)
    }
    @TestCase
    public func test5() {
        let m1: Money = Money(0.0, "JEP")
        let m2: Money = round(m1, 1)
        @Expect(m2.amount, 0)
    }
    @TestCase
    public func test6() {
        let m1: Money = Money(12.012, "PHP")
        let m2: Money = round(m1, 1)
        @Expect(m2.amount, 1200)
    }
    @TestCase
    public func test7() {
        let m1: Money = Money(-16.388, "TJS")
        let m2: Money = round(m1, 1)
        @Expect(m2.amount, -1640)
    }
    @TestCase
    public func test8() {
        let m1: Money = Money(-16.388, "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let m2: Money = round(m1, 0)
        })
    }
    // BigMoney
    @TestCase
    public func test9() {
        let m1: BigMoney = BigMoney("-1782538723487872363268234542353253253253253252345234575634272.32345325325786783426785322", "AED")
        let m2: BigMoney = round(m1, 2)
        @Expect(m2.amount, BigInt("-178253872348787236326823454235325325325325325234523457563427200"))
    }
    @TestCase
    public func test10() {
        let m1: BigMoney = BigMoney("-167342785432785432767342785437843278734743276346832674876342643287634284312.98435235734279789437734287938794387905", "COP")
        let m2: BigMoney = round(m1, 1)
        @Expect(m2.amount, BigInt("-16734278543278543276734278543784327873474327634683267487634264328763428431300"))
    }
    @TestCase
    public func test11() {
        let m1: BigMoney = BigMoney("19243809478293582937832097328932897328973289893278932893289732853285892322.3054333", "KWD")
        let m2: BigMoney = round(m1, 1)
        @Expect(m2.amount, BigInt("19243809478293582937832097328932897328973289893278932893289732853285892322310"))
    }
}

@Test
class splitTest {
    @TestCase
    public func test1() {
        let m: Money = Money(-12.3, "AED")
        let ms: ArrayList<Money> = split(m, 3)
        @Expect(ms[0].amount, -410)
        @Expect(ms[1].amount, -410)
        @Expect(ms[2].amount, -410)
    }
    @TestCase
    public func test2() {
        let m: Money = Money(-112.305, "COP")
        let ms: ArrayList<Money> = split(m, 4)
        @Expect(ms[0].amount, -2808)
        @Expect(ms[1].amount, -2808)
        @Expect(ms[2].amount, -2808)
        @Expect(ms[3].amount, -2807)
    }
    @TestCase
    public func test3() {
        let m: Money = Money(122.3054333, "KWD")
        let ms: ArrayList<Money> = split(m, 7)
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
        let ms: ArrayList<Money> = split(m, 3)
        @Expect(ms[0].amount, 4)
        @Expect(ms[1].amount, 3)
        @Expect(ms[2].amount, 3)
    }
    @TestCase
    public func test5() {
        let m: Money = Money(0.0, "JEP")
        let ms: ArrayList<Money> = split(m, 142)
        for (i in ms) {
            @Expect(i.amount, 0)
        }
    }
    @TestCase
    public func test6() {
        let m: Money = Money(12.012, "PHP")
        let ms: ArrayList<Money> = split(m, 5)
        @Expect(ms[0].amount, 241)
        @Expect(ms[1].amount, 240)
        @Expect(ms[2].amount, 240)
        @Expect(ms[3].amount, 240)
        @Expect(ms[4].amount, 240)
    }
    @TestCase
    public func test7() {
        let m: Money = Money(-16.388, "TJS")
        let ms: ArrayList<Money> = split(m, 4)
        @Expect(ms[0].amount, -410)
        @Expect(ms[1].amount, -410)
        @Expect(ms[2].amount, -410)
        @Expect(ms[3].amount, -409)
    }
    @TestCase
    public func test8() {
        let m: Money = Money(-16.388, "TJS")
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<Money> = split(m, 0)
        })
    }
    // BigMoney
    @TestCase
    public func test9() {
        let m: BigMoney = BigMoney("-28793546872437852634532875382753212534325325235879679672.243532532532532513223", "AED")
        let ms: ArrayList<BigMoney> = split(m, 3)
        @Expect(ms[0].amount, BigInt("-959784895747928421151095846091773751144177507862655989075"))
        @Expect(ms[1].amount, BigInt("-959784895747928421151095846091773751144177507862655989075"))
        @Expect(ms[2].amount, BigInt("-959784895747928421151095846091773751144177507862655989074"))
    }
    @TestCase
    public func test10() {
        let m: BigMoney = BigMoney("278457823687232873627368726782473887258723587275437827867457878287465.1345235325325324332", "PLN")
        let ms: ArrayList<BigMoney> = split(m, 4)
        @Expect(ms[0].amount, BigInt("6961445592180821840684218169561847181468089681885945696686446957186629"))
        @Expect(ms[1].amount, BigInt("6961445592180821840684218169561847181468089681885945696686446957186628"))
        @Expect(ms[2].amount, BigInt("6961445592180821840684218169561847181468089681885945696686446957186628"))
        @Expect(ms[3].amount, BigInt("6961445592180821840684218169561847181468089681885945696686446957186628"))
    }
    @TestCase
    public func test11() {
        let m: BigMoney = BigMoney("0.0", "JEP")
        let ms: ArrayList<BigMoney> = split(m, 142)
        for (i in ms) {
            @Expect(i.amount, BigInt("0"))
        }
    }
    @TestCase
    public func test12() {
        let m: BigMoney = BigMoney("-12345325235322353223532235343425435634647666666655557423244444444444566.325342353252388", "TJS") 
        @ExpectThrows[IllegalArgumentException]({
            let ms: ArrayList<BigMoney> = split(m, 0)
        })
    }
}
