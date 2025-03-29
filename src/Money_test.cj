package cj_money

import std.unittest.*
import std.unittest.testmacro.*

@Test
class initTest{
    @TestCase
    public func test1(){
        let m1: Money = Money(1, "EUR")
        @Expect(1, m1.amount)
        @Expect(".", m1.currency.decimal)
        @Expect(",", m1.currency.thousand)
        @Expect("EUR", m1.currency.code)
        @Expect(2, m1.currency.fraction)
        @Expect("978", m1.currency.numericCode)
        @Expect("\u{20ac}", m1.currency.grapheme)
        @Expect("$1", m1.currency.template)

        let m2: Money = Money(-100, "EUR")
        @Expect(-100, m2.amount)
        @Expect(".", m2.currency.decimal)
        @Expect(",", m2.currency.thousand)
        @Expect("EUR", m2.currency.code)
        @Expect(2, m2.currency.fraction)
        @Expect("978", m2.currency.numericCode)
        @Expect("\u{20ac}", m2.currency.grapheme)
        @Expect("$1", m2.currency.template)
    }
    @TestCase
    public func test2(){
        let m1: Money = Money(-10.333, "HKD")
        @Expect(-1033, m1.amount)
        @Expect(".", m1.currency.decimal)
        @Expect(",", m1.currency.thousand)
        @Expect("HKD", m1.currency.code)
        @Expect(2, m1.currency.fraction)
        @Expect("344", m1.currency.numericCode)
        @Expect("$", m1.currency.grapheme)
        @Expect("$1", m1.currency.template)

        let m2: Money = Money(-100.555, "HKD")
        @Expect(-10056, m2.amount)
        @Expect(".", m2.currency.decimal)
        @Expect(",", m2.currency.thousand)
        @Expect("HKD", m2.currency.code)
        @Expect(2, m2.currency.fraction)
        @Expect("344", m2.currency.numericCode)
        @Expect("$", m2.currency.grapheme)
        @Expect("$1", m2.currency.template)

        let m3: Money = Money(20.4444, "HKD")
        @Expect(2044, m3.amount)
        @Expect(".", m3.currency.decimal)
        @Expect(",", m3.currency.thousand)
        @Expect("HKD", m3.currency.code)
        @Expect(2, m3.currency.fraction)
        @Expect("344", m3.currency.numericCode)
        @Expect("$", m3.currency.grapheme)
        @Expect("$1", m3.currency.template)

        let m4: Money = Money(200.66666, "HKD")
        @Expect(20067, m4.amount)
        @Expect(".", m4.currency.decimal)
        @Expect(",", m4.currency.thousand)
        @Expect("HKD", m4.currency.code)
        @Expect(2, m4.currency.fraction)
        @Expect("344", m4.currency.numericCode)
        @Expect("$", m4.currency.grapheme)
        @Expect("$1", m4.currency.template)
    }
    @TestCase
    public func test3(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let m :Money = Money(0, currency)

        @Expect(0, m.amount)
        @Expect(".", m.currency.decimal)
        @Expect(",", m.currency.thousand)
        @Expect("KYD", m.currency.code)
        @Expect("136", m.currency.numericCode)
        @Expect("$", m.currency.grapheme)
        @Expect("$1", m.currency.template)
    }
    @TestCase
    public func test4(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let m :Money = Money(-0.0, currency)

        @Expect(0, m.amount)
        @Expect(".", m.currency.decimal)
        @Expect(",", m.currency.thousand)
        @Expect("KYD", m.currency.code)
        @Expect("136", m.currency.numericCode)
        @Expect("$", m.currency.grapheme)
        @Expect("$1", m.currency.template)
    }
}

@Test
class sameCurrencyTest{
    @TestCase
    public func test(){
        let m1: Money = Money(12, "CLP")
        let m2: Money = Money(-123, "CLP")
        let m3: Money = Money(0.4, "DZD")

        @Expect(true, m1.sameCurrency(m2))
        @Expect(false, m1.sameCurrency(m3))
        @Expect(false, m2.sameCurrency(m3))
        @Expect(true, m2.sameCurrency(m1))
        @Expect(false, m3.sameCurrency(m1))
        @Expect(false, m3.sameCurrency(m2))
    }
}

@Test
class compareAmountTest{
    @TestCase
    public func test1(){
        let m1: Money = Money(12000, "JOD")
        let m2: Money = Money(1.2, "JOD")
        let m3: Money = Money(0, "JOD")
        let m4: Money = Money(0.0, "JOD")
        let m5: Money = Money(-10, "JOD")

        @Expect(m1.compareAmount(m1), 0)
        @Expect(m1.compareAmount(m2), 1)
        @Expect(m1.compareAmount(m3), 1)
        @Expect(m1.compareAmount(m4), 1)
        @Expect(m1.compareAmount(m5), 1)

        @Expect(m2.compareAmount(m1), -1)
        @Expect(m2.compareAmount(m2), 0)
        @Expect(m2.compareAmount(m3), 1)
        @Expect(m2.compareAmount(m4), 1)
        @Expect(m2.compareAmount(m5), 1)

        @Expect(m3.compareAmount(m1), -1)
        @Expect(m3.compareAmount(m2), -1)
        @Expect(m3.compareAmount(m3), 0)
        @Expect(m3.compareAmount(m4), 0)
        @Expect(m3.compareAmount(m5), 1)

        @Expect(m4.compareAmount(m1), -1)
        @Expect(m4.compareAmount(m2), -1)
        @Expect(m4.compareAmount(m3), 0)
        @Expect(m4.compareAmount(m4), 0)
        @Expect(m4.compareAmount(m5), 1)

        @Expect(m5.compareAmount(m1), -1)
        @Expect(m5.compareAmount(m2), -1)
        @Expect(m5.compareAmount(m3), -1)
        @Expect(m5.compareAmount(m4), -1)
        @Expect(m5.compareAmount(m5), 0)
    }
    @TestCase
    public func test2(){
        let m1: Money = Money(12000, "NZD")
        let m2: Money = Money(1.2, "SVC")
        @ExpectThrows[CurrencyNotSameException]({
            m1.compareAmount(m2)
        })
    }
}

@Test
class greaterThanTest{
    @TestCase
    public func test(){
        let m1: Money = Money(99999, "SHP")
        let m2: Money = Money(56.8912, "SHP")
        let m3: Money = Money(1200, "SHP")
        let m4: Money = Money(12.0000, "SHP")
        let m5: Money = Money(-8848, "SHP")

        @Expect(m1.greaterThan(m1), false)
        @Expect(m1.greaterThan(m2), true)
        @Expect(m1.greaterThan(m3), true)
        @Expect(m1.greaterThan(m4), true)
        @Expect(m1.greaterThan(m5), true)

        @Expect(m2.greaterThan(m1), false)
        @Expect(m2.greaterThan(m2), false)
        @Expect(m2.greaterThan(m3), true)
        @Expect(m2.greaterThan(m4), true)
        @Expect(m2.greaterThan(m5), true)

        @Expect(m3.greaterThan(m1), false)
        @Expect(m3.greaterThan(m2), false)
        @Expect(m3.greaterThan(m3), false)
        @Expect(m3.greaterThan(m4), false)
        @Expect(m3.greaterThan(m5), true)

        @Expect(m4.greaterThan(m1), false)
        @Expect(m4.greaterThan(m2), false)
        @Expect(m4.greaterThan(m3), false)
        @Expect(m4.greaterThan(m4), false)
        @Expect(m4.greaterThan(m5), true)

        @Expect(m5.greaterThan(m1), false)
        @Expect(m5.greaterThan(m2), false)
        @Expect(m5.greaterThan(m3), false)
        @Expect(m5.greaterThan(m4), false)
        @Expect(m5.greaterThan(m5), false)
    }
}

@Test
class greaterThanOrEqualTest{
    @TestCase
    public func test(){
        let m1: Money = Money(81234341, "XPF")
        let m2: Money = Money(13232.89, "XPF")
        let m3: Money = Money(-13, "XPF")
        let m4: Money = Money(-13.00000000001, "XPF")
        let m5: Money = Money(-898, "XPF")

        @Expect(m1.greaterThanOrEqual(m1), true)
        @Expect(m1.greaterThanOrEqual(m2), true)
        @Expect(m1.greaterThanOrEqual(m3), true)
        @Expect(m1.greaterThanOrEqual(m4), true)
        @Expect(m1.greaterThanOrEqual(m5), true)

        @Expect(m2.greaterThanOrEqual(m1), false)
        @Expect(m2.greaterThanOrEqual(m2), true)
        @Expect(m2.greaterThanOrEqual(m3), true)
        @Expect(m2.greaterThanOrEqual(m4), true)
        @Expect(m2.greaterThanOrEqual(m5), true)

        @Expect(m3.greaterThanOrEqual(m1), false)
        @Expect(m3.greaterThanOrEqual(m2), false)
        @Expect(m3.greaterThanOrEqual(m3), true)
        @Expect(m3.greaterThanOrEqual(m4), true)
        @Expect(m3.greaterThanOrEqual(m5), true)

        @Expect(m4.greaterThanOrEqual(m1), false)
        @Expect(m4.greaterThanOrEqual(m2), false)
        @Expect(m4.greaterThanOrEqual(m3), true)
        @Expect(m4.greaterThanOrEqual(m4), true)
        @Expect(m4.greaterThanOrEqual(m5), true)

        @Expect(m5.greaterThanOrEqual(m1), false)
        @Expect(m5.greaterThanOrEqual(m2), false)
        @Expect(m5.greaterThanOrEqual(m3), false)
        @Expect(m5.greaterThanOrEqual(m4), false)
        @Expect(m5.greaterThanOrEqual(m5), true)
    }
}

@Test
class lessThanTest{
    @TestCase
    public func test(){
        let m1: Money = Money(14532523.46, "SDG")
        let m2: Money = Money(9436, "SDG")
        let m3: Money = Money(-783, "SDG")
        let m4: Money = Money(-7.83000000, "SDG")
        let m5: Money = Money(-1324, "SDG")

        @Expect(m1.lessThan(m1), false)
        @Expect(m1.lessThan(m2), false)
        @Expect(m1.lessThan(m3), false)
        @Expect(m1.lessThan(m4), false)
        @Expect(m1.lessThan(m5), false)

        @Expect(m2.lessThan(m1), true)
        @Expect(m2.lessThan(m2), false)
        @Expect(m2.lessThan(m3), false)
        @Expect(m2.lessThan(m4), false)
        @Expect(m2.lessThan(m5), false)

        @Expect(m3.lessThan(m1), true)
        @Expect(m3.lessThan(m2), true)
        @Expect(m3.lessThan(m3), false)
        @Expect(m3.lessThan(m4), false)
        @Expect(m3.lessThan(m5), false)

        @Expect(m4.lessThan(m1), true)
        @Expect(m4.lessThan(m2), true)
        @Expect(m4.lessThan(m3), false)
        @Expect(m4.lessThan(m4), false)
        @Expect(m4.lessThan(m5), false)

        @Expect(m5.lessThan(m1), true)
        @Expect(m5.lessThan(m2), true)
        @Expect(m5.lessThan(m3), true)
        @Expect(m5.lessThan(m4), true)
        @Expect(m5.lessThan(m5), false)
    }
}

@Test
class lessThanOrEqualTest{
    @TestCase
    public func test(){
        let m1: Money = Money(1546587131, "UAH")
        let m2: Money = Money(54645, "UAH")
        let m3: Money = Money(13413, "UAH")
        let m4: Money = Money(134.13, "UAH")
        let m5: Money = Money(-5346.12341, "UAH")

        @Expect(m1.lessThanOrEqual(m1), true)
        @Expect(m1.lessThanOrEqual(m2), false)
        @Expect(m1.lessThanOrEqual(m3), false)
        @Expect(m1.lessThanOrEqual(m4), false)
        @Expect(m1.lessThanOrEqual(m5), false)

        @Expect(m2.lessThanOrEqual(m1), true)
        @Expect(m2.lessThanOrEqual(m2), true)
        @Expect(m2.lessThanOrEqual(m3), false)
        @Expect(m2.lessThanOrEqual(m4), false)
        @Expect(m2.lessThanOrEqual(m5), false)

        @Expect(m3.lessThanOrEqual(m1), true)
        @Expect(m3.lessThanOrEqual(m2), true)
        @Expect(m3.lessThanOrEqual(m3), true)
        @Expect(m3.lessThanOrEqual(m4), true)
        @Expect(m3.lessThanOrEqual(m5), false)

        @Expect(m4.lessThanOrEqual(m1), true)
        @Expect(m4.lessThanOrEqual(m2), true)
        @Expect(m4.lessThanOrEqual(m3), true)
        @Expect(m4.lessThanOrEqual(m4), true)
        @Expect(m4.lessThanOrEqual(m5), false)

        @Expect(m5.lessThanOrEqual(m1), true)
        @Expect(m5.lessThanOrEqual(m2), true)
        @Expect(m5.lessThanOrEqual(m3), true)
        @Expect(m5.lessThanOrEqual(m4), true)
        @Expect(m5.lessThanOrEqual(m5), true)
    }
}

@Test
class equalsTest{
    @TestCase
    public func test(){
        let m1: Money = Money(12999, "ZAR")
        let m2: Money = Money(-123, "ZAR")
        let m3: Money = Money(129.99, "ZAR")

        @Expect(false, m1.equals(m2))
        @Expect(true, m1.equals(m3))
        @Expect(false, m2.equals(m3))
        @Expect(false, m2.equals(m1))
        @Expect(true, m3.equals(m1))
        @Expect(false, m3.equals(m2))
    }
}

@Test
class judgmentOnSelf{
    let m1: Money = Money(123, "WST")
    let m2: Money = Money(132.12, "SCR")
    let m3: Money = Money(0, "LAK")
    let m4: Money = Money(0.0, "GTQ")
    let m5: Money = Money(-12, "IMP")
    let m6: Money = Money(-1.435123, "CAD")
    @TestCase
    public func isZeroTest(){
        @Expect(m1.isZero(), false)
        @Expect(m2.isZero(), false)
        @Expect(m3.isZero(), true)
        @Expect(m4.isZero(), true)
        @Expect(m5.isZero(), false)
        @Expect(m6.isZero(), false)
    }

    @TestCase
    public func isPositiveTest(){
        @Expect(m1.isPositive(), true)
        @Expect(m2.isPositive(), true)
        @Expect(m3.isPositive(), false)
        @Expect(m4.isPositive(), false)
        @Expect(m5.isPositive(), false)
        @Expect(m6.isPositive(), false)
    }

    @TestCase
    public func isNegativeTest(){
        @Expect(m1.isNegative(), false)
        @Expect(m2.isNegative(), false)
        @Expect(m3.isNegative(), false)
        @Expect(m4.isNegative(), false)
        @Expect(m5.isNegative(), true)
        @Expect(m6.isNegative(), true)
    }
}

@Test
class operationOnSelf{
    @TestCase
    public func absoluteTest(){
        let m1: Money = Money(123, "WST")
        let m2: Money = Money(132.12, "SCR")
        let m3: Money = Money(0, "LAK")
        let m4: Money = Money(0.0, "GTQ")
        let m5: Money = Money(-12, "IMP")
        let m6: Money = Money(-1.435123, "CAD")
        m1.absolute()
        m2.absolute()
        m3.absolute()
        m4.absolute()
        m5.absolute()
        m6.absolute()
        @Expect(m1.amount, 123)
        @Expect(m2.amount, 13212)
        @Expect(m3.amount, 0)
        @Expect(m4.amount, 0)
        @Expect(m5.amount, 12)
        @Expect(m6.amount, 144)
    }
    @TestCase
    public func negativeTest(){
        let m1: Money = Money(123, "WST")
        let m2: Money = Money(132.12, "SCR")
        let m3: Money = Money(0, "LAK")
        let m4: Money = Money(0.0, "GTQ")
        let m5: Money = Money(-12, "IMP")
        let m6: Money = Money(-1.435123, "CAD")
        m1.negative()
        m2.negative()
        m3.negative()
        m4.negative()
        m5.negative()
        m6.negative()
        @Expect(m1.amount, -123)
        @Expect(m2.amount, -13212)
        @Expect(m3.amount, 0)
        @Expect(m4.amount, 0)
        @Expect(m5.amount, 12)
        @Expect(m6.amount, 144)
    }
}

@Test
class displayTest{
    @TestCase
    public func test1(){
        let m: Money = Money(146, "AWG")
        @Expect("1.46\u{0192}", m.display())
    }
    @TestCase
    public func test2(){
        let m: Money = Money(14.6, "GNF")
        @Expect("15 FG", m.display())
    }
    @TestCase
    public func test3(){
        let m: Money = Money(-1313423, "MUR")
        @Expect("-\u{20a8}13,134.23", m.display())
    }
    @TestCase
    public func test4(){
        let m: Money = Money(-131.3423, "VEF")
        @Expect("-Bs131.34", m.display())
    }
    @TestCase
    public func test5(){
        let m: Money = Money(0, "ZWL")
        @Expect("Z$0.00", m.display())
    }
    @TestCase
    public func test6(){
        let m: Money = Money(-0.0, "KYD")
        @Expect("$0.00", m.display())
    }
}

@Test
class asMajorUnitsTest {
    @TestCase
    public func test1(){
        let m: Money = Money(146, "AWG")
        @Expect(1.46, m.asMajorUnits())
    }
    @TestCase
    public func test2(){
        let m: Money = Money(14.6, "GNF")
        @Expect(15.0, m.asMajorUnits())
    }
    @TestCase
    public func test3(){
        let m: Money = Money(-1313423, "MUR")
        @Expect(-13134.23, m.asMajorUnits())
    }
    @TestCase
    public func test4(){
        let m: Money = Money(-131.3423, "VEF")
        @Expect(-131.34, m.asMajorUnits())
    }
    @TestCase
    public func test5(){
        let m: Money = Money(0, "ZWL")
        @Expect(0.0, m.asMajorUnits())
    }
    @TestCase
    public func test6(){
        let m: Money = Money(-0.0, "KYD")
        @Expect(0.0, m.asMajorUnits())
    }
}
