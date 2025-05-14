package cj_money

import std.unittest.*
import std.unittest.testmacro.*

@Test
class serializeByCodeTest{
    @TestCase
    public func test1() {
        let m: Money = Money(100, "CUC")
        let st: String = serializeByCode(m)
        @Expect(st, "100|CUC")
    }
    @TestCase
    public func test2() {
        let m: Money = Money(1.0, "GHS")
        let st: String = serializeByCode(m, separator: "%")
        @Expect(st, "100%GHS")
    }
    @TestCase
    public func test3() {
        let m: Money = Money(9.9, "MAD")
        let st: String = serializeByCode(m)
        @Expect(st, "990|MAD")
    }
}
@Test
class deserializeByCodeTest{
    @TestCase
    public func test1(){
        let st: String = "999|GYD"
        let m: Money = deserializeByCode(st)

        @Expect(999, m.amount)
        @Expect(".", m.currency.decimal)
        @Expect(",", m.currency.thousand)
        @Expect("GYD", m.currency.code)
        @Expect(2, m.currency.fraction)
        @Expect("328", m.currency.numericCode)
        @Expect("$", m.currency.grapheme)
        @Expect("$1", m.currency.template)
    }
    @TestCase
    public func test2(){
        let st: String = "88888888%^PAB"
        let m: Money = deserializeByCode(st, separator: "%^")

        @Expect(88888888, m.amount)
        @Expect(".", m.currency.decimal)
        @Expect(",", m.currency.thousand)
        @Expect("PAB", m.currency.code)
        @Expect(2, m.currency.fraction)
        @Expect("590", m.currency.numericCode)
        @Expect("B/.", m.currency.grapheme)
        @Expect("$1", m.currency.template)
    }
    @TestCase
    public func test3(){
        let st: String = "5432&XCD"
        let m: Money = deserializeByCode(st, separator: "&")

        @Expect(5432, m.amount)
        @Expect(".", m.currency.decimal)
        @Expect(",", m.currency.thousand)
        @Expect("XCD", m.currency.code)
        @Expect(2, m.currency.fraction)
        @Expect("951", m.currency.numericCode)
        @Expect("$", m.currency.grapheme)
        @Expect("$1", m.currency.template)
    }
    @TestCase
    public func test4(){
        let st: String = "5432&XCD"
        @ExpectThrows[IllegalFormatException]({
            let m: Money = deserializeByCode(st, separator: "|")
        })
    }
    @TestCase
    public func test5(){
        let st: String = "970|ZWD|716|2|Z$|$1|.|,"
        @ExpectThrows[IllegalFormatException]({
            let m: Money = deserializeByCode(st, separator: "|")
        })
    }
}

@Test
class serializeAllTest{
    @TestCase
    public func test1(){
        let m: Money = Money(9.7, "ZWD")
        let st: String = serializeAll(m)
        @Expect(st, "970|ZWD|716|2|Z$|$1|.|,")
    }
    @TestCase
    public func test2(){
        let m: Money = Money(99, "ZWL")
        let st: String = serializeAll(m, separator: "@@")
        @Expect(st, "99@@ZWL@@932@@2@@Z$@@$1@@.@@,")
    }
    @TestCase
    public func test3(){
        let m: Money = Money(Float64(100), "MKD")
        let st: String = serializeAll(m, separator: "^")
        @Expect(st, "10000^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,")
    }
}

@Test 
class deserializeAllTest{
    @TestCase
    public func test1(){
        let st: String = "99@@ZWL@@932@@2@@Z$@@$1@@.@@,"
        let m: Money = deserializeAll(st, separator: "@@")
        @Expect(m.amount, 99)
        @Expect(m.currency.decimal, ".")
        @Expect(m.currency.thousand, ",")
        @Expect(m.currency.code, "ZWL")
        @Expect(m.currency.fraction, 2)
        @Expect(m.currency.numericCode, "932")
        @Expect(m.currency.grapheme, "Z$")
        @Expect(m.currency.template, "$1")
    }
    @TestCase
    public func test2(){
        let st: String = "970|ZWD|716|2|Z$|$1|.|,"
        let m: Money = deserializeAll(st)
        @Expect(m.amount, 970)
        @Expect(m.currency.decimal, ".")
        @Expect(m.currency.thousand, ",")
        @Expect(m.currency.code, "ZWD")
        @Expect(m.currency.fraction, 2)
        @Expect(m.currency.numericCode, "716")
        @Expect(m.currency.grapheme, "Z$")
        @Expect(m.currency.template, "$1")
    }
    @TestCase
    public func test3(){
        let st: String = "10000^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,"
        let m: Money = deserializeAll(st, separator: "^")
        @Expect(m.amount, 10000)
        @Expect(m.currency.decimal, ".")
        @Expect(m.currency.thousand, ",")
        @Expect(m.currency.code, "MKD")
        @Expect(m.currency.fraction, 2)
        @Expect(m.currency.numericCode, "807")
        @Expect(m.currency.grapheme, "\u{0434}\u{0435}\u{043d}")
        @Expect(m.currency.template, "$1")
    }
    @TestCase
    public func test4(){
        let st: String = "10000^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,"
        @ExpectThrows[IllegalFormatException]({
            let m: Money = deserializeByCode(st, separator: "|")
        })
    }
    @TestCase
    public func test5(){
        let st: String = "10000^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^"
        @ExpectThrows[IllegalFormatException]({
            let m: Money = deserializeByCode(st, separator: "^")
        })
    }
}
