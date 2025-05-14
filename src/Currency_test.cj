package cj_money

import std.unittest.*
import std.unittest.testmacro.*

@Test
class currencyByCodeTest{
    @TestCase
    public func test1() {
        let currencies : Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("EUR")) {
            case None => throw NoneValueException("没有找到code为EUR的Currency")
            case Some(v) => v
        }

        @Expect(".", currency.decimal)
        @Expect(",", currency.thousand)
        @Expect("EUR", currency.code)
        @Expect(2, currency.fraction)
        @Expect("978", currency.numericCode)
        @Expect("\u{20ac}", currency.grapheme)
        @Expect("$1", currency.template)
    }
    @TestCase
    public func test2() {
        let currencies : Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("SDG")) {
            case None => throw NoneValueException("没有找到code为SDG的Currency")
            case Some(v) => v
        }

        @Expect(".", currency.decimal)
        @Expect(",", currency.thousand)
        @Expect("SDG", currency.code)
        @Expect(2, currency.fraction)
        @Expect("938", currency.numericCode)
        @Expect("\u{00a3}", currency.grapheme)
        @Expect("$1", currency.template)
    }
    @TestCase
    public func test3() {
        let currencies : Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("ALL")) {
            case None => throw NoneValueException("没有找到code为ALL的Currency")
            case Some(v) => v
        }

        @Expect(".", currency.decimal)
        @Expect(",", currency.thousand)
        @Expect("ALL", currency.code)
        @Expect(2, currency.fraction)
        @Expect("008", currency.numericCode)
        @Expect("L", currency.grapheme)
        @Expect("$1", currency.template)
    }
}

@Test
class currencyByNumericCode{
    @TestCase
    public func test1(){
        let currencies : Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByNumericCode("052")) {
            case None => throw NoneValueException("没有找到numeric code为052的Currency")
            case Some(v) => v
        }

        @Expect(".", currency.decimal)
        @Expect(",", currency.thousand)
        @Expect("BBD", currency.code)
        @Expect(2, currency.fraction)
        @Expect("052", currency.numericCode)
        @Expect("$", currency.grapheme)
        @Expect("$1", currency.template)
    }
    @TestCase
    public func test2(){
        let currencies : Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByNumericCode("368")) {
            case None => throw NoneValueException("没有找到numeric code为368的Currency")
            case Some(v) => v
        }

        @Expect(".", currency.decimal)
        @Expect(",", currency.thousand)
        @Expect("IQD", currency.code)
        @Expect(3, currency.fraction)
        @Expect("368", currency.numericCode)
        @Expect(".\u{062f}.\u{0639}", currency.grapheme)
        @Expect("1 $", currency.template)
    }
    @TestCase
    public func test3(){
        let currencies : Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByNumericCode("788")) {
            case None => throw NoneValueException("没有找到numeric code为788的Currency")
            case Some(v) => v
        }

        @Expect(".", currency.decimal)
        @Expect(",", currency.thousand)
        @Expect("TND", currency.code)
        @Expect(3, currency.fraction)
        @Expect("788", currency.numericCode)
        @Expect(".\u{062f}.\u{062a}", currency.grapheme)
        @Expect("1 $", currency.template)
    }
}
