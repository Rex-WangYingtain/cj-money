package cj_money

import std.unittest.*
import std.unittest.testmacro.*
import std.math.numeric.*

@Test
class serializeByCodeTest{
    // Money
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
    // BigMoney
    @TestCase
    public func test4() {
        let m: BigMoney = BigMoney("879348923753277832687532897328753287973298.7492037328098438", "CUC")
        let st: String = serializeByCode(m)
        @Expect(st, "87934892375327783268753289732875328797329875|CUC")
    }
    @TestCase
    public func test5() {
        let m: BigMoney = BigMoney("879348923753277832687532897328753287973298.7492037328098438", "CUC")
        let st: String = serializeByCode(m, separator: "%")
        @Expect(st, "87934892375327783268753289732875328797329875%CUC")
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
    // BigMoney
    @TestCase
    public func test4(){
        let m: BigMoney = BigMoney("9423432523532345325324353425325325325325325325325325.23444444444464555556343257", "ZWD")
        let st: String = serializeAll(m)
        @Expect(st, "942343252353234532532435342532532532532532532532532523|ZWD|716|2|Z$|$1|.|,")
    }
    @TestCase
    public func test5(){
        let m: BigMoney = BigMoney("-923840578923452388753289532895328999999999278943276783249687236239.23453253253232", "MKD")
        let st: String = serializeAll(m, separator: "^")
        @Expect(st, "-92384057892345238875328953289532899999999927894327678324968723623923^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,")
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
            let m: Money = deserializeAll(st, separator: "|")
        })
    }
    @TestCase
    public func test5(){
        let st: String = "10000^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,^cangjie"
        @ExpectThrows[IllegalFormatException]({
            let m: Money = deserializeAll(st, separator: "^")
        })
    }
}

@Test
class deserializeBigMoneyByCodeTest{
    @TestCase
    public func test1(){
        let st: String = "9872347893879328932032890329723893289328632879687983274958723487873234878342778267887799|GYD"
        let m: BigMoney = deserializeBigMoneyByCode(st)

        @Expect(BigInt("9872347893879328932032890329723893289328632879687983274958723487873234878342778267887799"), m.amount)
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
        let st: String = "888887234589270908713461683487314892643893120489127059428378796634209783289286378888%^PAB"
        let m: BigMoney = deserializeBigMoneyByCode(st, separator: "%^")

        @Expect(BigInt("888887234589270908713461683487314892643893120489127059428378796634209783289286378888"), m.amount)
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
        let st: String = "597854709283802933280958092389405784324353222222222224365424522&XCD"
        @ExpectThrows[IllegalFormatException]({
            let m: BigMoney = deserializeBigMoneyByCode(st, separator: "|")
        })
    }
    @TestCase
    public func test4(){
        let st: String = "92345235555555555235667053666666666632345322222222222222222222536|ZWD|716|2|Z$|$1|.|,"
        @ExpectThrows[IllegalFormatException]({
            let m: BigMoney = deserializeBigMoneyByCode(st, separator: "|")
        })
    }
}

@Test 
class deserializeBigMoneyAllTest{
    @TestCase
    public func test1(){
        let st: String = "9897522222222234958092888888888888888724933268344283498174321829374681469329@@ZWL@@932@@2@@Z$@@$1@@.@@,"
        let m: BigMoney = deserializeBigMoneyAll(st, separator: "@@")
        @Expect(m.amount, BigInt("9897522222222234958092888888888888888724933268344283498174321829374681469329"))
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
        let st: String = "909857342798235283973289732897892379745322502344444444444444444444444444123414324214|ZWD|716|2|Z$|$1|.|,"
        let m: BigMoney = deserializeBigMoneyAll(st)
        @Expect(m.amount, BigInt("909857342798235283973289732897892379745322502344444444444444444444444444123414324214"))
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
        let st: String = "100732987045823903289000000000000000000000004738292839780975203897327895239800^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,"
        @ExpectThrows[IllegalFormatException]({
            let m: BigMoney = deserializeBigMoneyAll(st, separator: "|")
        })
    }
    @TestCase
    public func test4(){
        let st: String = "100732987045823903289000000000000000000000004738292839780975203897327895239800^MKD^807^2^\u{0434}\u{0435}\u{043d}^$1^.^,^cangjie"
        @ExpectThrows[IllegalFormatException]({
            let m: BigMoney = deserializeBigMoneyAll(st, separator: "^")
        })
    }
}
