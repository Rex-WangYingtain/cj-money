package cj_money

import std.unittest.*
import std.unittest.testmacro.*

import std.math.numeric.*

@Test
class BigMoneyInitTest{
    // 没有小数部分的情况
    @TestCase
    public func test1(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133", currency)

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413300"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test2(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133", currency)

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133000"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    @TestCase
    public func test3(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133", currency)

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413300"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test4(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133", currency)

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133000"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 负数，小数部分大于fraction，舍去的情况
    @TestCase
    public func test5(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1241254", currency)

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413312"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test6(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1241254", currency)

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133124"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 正数，小数部分大于fraction，舍去的情况
    @TestCase
    public func test7(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.134114123412413412413", currency)

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test8(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.1234525343214", currency)

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133123"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 负数，小数部分大于fraction，舍入的情况
    @TestCase
    public func test9(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1251254", currency)

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test10(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1246254", currency)

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133125"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 正数，小数部分大于fraction，舍入的情况
    @TestCase
    public func test11(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.135114123412413412413", currency)

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413314"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test12(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.1236525343214", currency)

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133124"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 负数，小数部分小于fraction的情况
    @TestCase
    public func test13(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.13", currency)

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test14(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.128", currency)

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133128"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 正数，小数部分小于fraction的情况
    @TestCase
    public func test15(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KYD")) {
            case None => throw NoneValueException("没有找到Currency标准KYD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.13", currency)

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test16(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("KWD")) {
            case None => throw NoneValueException("没有找到Currency标准KWD")
            case Some(v) => v
        }
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.128", currency)

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133128"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }

    // 没有小数部分的情况
    @TestCase
    public func test17(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133", "KYD")

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413300"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test18(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133", "KWD")

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133000"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    @TestCase
    public func test19(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133", "KYD")

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413300"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test20(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133", "KWD")

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133000"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 负数，小数部分大于fraction，舍去的情况
    @TestCase
    public func test21(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1241254", "KYD")

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413312"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test22(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1241254", "KWD")

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133124"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 正数，小数部分大于fraction，舍去的情况
    @TestCase
    public func test23(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.134114123412413412413", "KYD")

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test24(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.1234525343214", "KWD")

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133123"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 负数，小数部分大于fraction，舍入的情况
    @TestCase
    public func test25(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1251254", "KYD")

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test26(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.1246254", "KWD")

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133125"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 正数，小数部分大于fraction，舍入的情况
    @TestCase
    public func test27(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.135114123412413412413", "KYD")

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413314"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test28(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.1236525343214", "KWD")

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133124"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 负数，小数部分小于fraction的情况
    @TestCase
    public func test29(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.13", "KYD")

        @Expect(BigInt("-121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test30(){
        let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324133.128", "KWD")

        @Expect(BigInt("-1213124543253654325132543564651234431244412421154324133128"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
    // 正数，小数部分小于fraction的情况
    @TestCase
    public func test31(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.13", "KYD")

        @Expect(BigInt("121312454325365432513254356465123443124441242115432413313"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KYD", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("136", bm.currency.numericCode)
        @Expect("$", bm.currency.grapheme)
        @Expect("$1", bm.currency.template)
    }
    @TestCase
    public func test32(){
        let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.128", "KWD")

        @Expect(BigInt("1213124543253654325132543564651234431244412421154324133128"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("KWD", bm.currency.code)
        @Expect(3, bm.currency.fraction)
        @Expect("414", bm.currency.numericCode)
        @Expect(".\u{062f}.\u{0643}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }

    // 考虑异常的情况
    @TestCase
    public func test33(){
        @ExpectThrows[IllegalArgumentException]({
            let bm: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.128.76789", "KWD")
        })
    }
    @TestCase
    public func test34(){
        @ExpectThrows[IllegalArgumentException]({
            let bm: BigMoney = BigMoney("+121312454325365432513254356465.123443124441242.1154324", "KWD")
        })
    }
    @TestCase
    public func test35(){
        @ExpectThrows[IllegalArgumentException]({
            let bm: BigMoney = BigMoney("--1213124543253654325132543564651234431244412421154324.12341324154241", "KWD")
        })
    }
    @TestCase
    public func test36(){
        @ExpectThrows[IllegalArgumentException]({
            let bm: BigMoney = BigMoney("-1213124543253654325132543564651234431244412421154324.", "KWD")
        })
    }
    @TestCase
    public func test37() {
        let m: Money = Money(100, "CNY")
        let bm: BigMoney = BigMoney(m)

        @Expect(BigInt("100"), bm.amount)
        @Expect(".", bm.currency.decimal)
        @Expect(",", bm.currency.thousand)
        @Expect("CNY", bm.currency.code)
        @Expect(2, bm.currency.fraction)
        @Expect("156", bm.currency.numericCode)
        @Expect("\u{5143}", bm.currency.grapheme)
        @Expect("1 $", bm.currency.template)
    }
}

@Test
class toMoneyTest {
    @TestCase
    public func test() {
        let bm: BigMoney = BigMoney("100", "CNY")

        let m: Money = bm.toMoney()
        @Expect(10000, m.amount)
        @Expect(".", m.currency.decimal)
        @Expect(",", m.currency.thousand)
        @Expect("CNY", m.currency.code)
        @Expect(2, m.currency.fraction)
        @Expect("\u{5143}", m.currency.grapheme)
        @Expect("1 $", m.currency.template)
    }
}


@Test
class BigMoneySameCurrencyTest{
    @TestCase
    public func test(){
        let bm1: BigMoney = BigMoney("1213124543253654325132543564651234431244412421154324133.1236525343214", "KWD")
        let bm2: BigMoney = BigMoney("-121312454654325132543564651431244454324133.123651324132414235123421412341225343214", "KWD")
        let bm3: BigMoney = BigMoney("1213124543253654325132543314154254235234564651234431244412421154324133.123652535444135143431242344442314443214", "DZD")

        @Expect(true, bm1.sameCurrency(bm2))
        @Expect(false, bm1.sameCurrency(bm3))
        @Expect(false, bm2.sameCurrency(bm3))
        @Expect(true, bm2.sameCurrency(bm1))
        @Expect(false, bm3.sameCurrency(bm1))
        @Expect(false, bm3.sameCurrency(bm2))
    }
}

@Test
class BigMoneyCompareAmountTest{
    @TestCase
    public func test1(){
        let m1: BigMoney = BigMoney("12000447912364897234109248712098472089554327080392092830985720974589752389745", "JOD")
        let m2: BigMoney = BigMoney("123453253333333333333333323452353253252345243654235325.2245325432", "JOD")
        let m3: BigMoney = BigMoney("0", "JOD")
        let m4: BigMoney = BigMoney("0.0", "JOD")
        let m5: BigMoney = BigMoney("-10138493712905471989203380192728930.25341215342", "JOD")

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
        let m1: BigMoney = BigMoney("12000134134154351323413.13412412412", "NZD")
        let m2: BigMoney = BigMoney("113414.213414151", "SVC")
        @ExpectThrows[CurrencyNotSameException]({
            m1.compareAmount(m2)
        })
    }
}

@Test
class BigMoneyGreaterThanTest{
    @TestCase
    public func test(){
        let m1: BigMoney = BigMoney("994312452321243513234252341214525312331254322222222222222222222222222222222222222222222222222222222222222532452555531121241234999", "SHP")
        let m2: BigMoney = BigMoney("531432421253432536125555555555555666666666666666666666666666666666666666666555555325432656.892341254112", "SHP")
        let m3: BigMoney = BigMoney("12123542352353532541342412341234114", "SHP")
        let m4: BigMoney = BigMoney("12123542352353532541342412341234114.0000000000001", "SHP")
        let m5: BigMoney = BigMoney("-813412513424215555124414444444444444444444444444444444444444444444444444444444444444444444444444444444444254848", "SHP")

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
class BigMoneyGreaterThanOrEqualTest{
    @TestCase
    public func test(){
        let m1: BigMoney = BigMoney("994312452321243513234252341214525312331254322222222222222222222222222222222222222222222222222222222222222532452555531121241234999", "SHP")
        let m2: BigMoney = BigMoney("531432421253432536125555555555555666666666666666666666666666666666666666666555555325432656.892341254112", "SHP")
        let m3: BigMoney = BigMoney("12123542352353532541342412341234114", "SHP")
        let m4: BigMoney = BigMoney("12123542352353532541342412341234114.0000000000001", "SHP")
        let m5: BigMoney = BigMoney("-813412513424215555124414444444444444444444444444444444444444444444444444444444444444444444444444444444444254848", "SHP")

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
class BigMoneyLessThanTest{
    @TestCase
    public func test(){
        let m1: BigMoney = BigMoney("994312452321243513234252341214525312331254322222222222222222222222222222222222222222222222222222222222222532452555531121241234999", "SHP")
        let m2: BigMoney = BigMoney("531432421253432536125555555555555666666666666666666666666666666666666666666555555325432656.892341254112", "SHP")
        let m3: BigMoney = BigMoney("12123542352353532541342412341234114", "SHP")
        let m4: BigMoney = BigMoney("12123542352353532541342412341234114.0000000000001", "SHP")
        let m5: BigMoney = BigMoney("-813412513424215555124414444444444444444444444444444444444444444444444444444444444444444444444444444444444254848", "SHP")

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
class BigMoneyLessThanOrEqualTest{
    @TestCase
    public func test(){
        let m1: BigMoney = BigMoney("994312452321243513234252341214525312331254322222222222222222222222222222222222222222222222222222222222222532452555531121241234999", "SHP")
        let m2: BigMoney = BigMoney("531432421253432536125555555555555666666666666666666666666666666666666666666555555325432656.892341254112", "SHP")
        let m3: BigMoney = BigMoney("12123542352353532541342412341234114", "SHP")
        let m4: BigMoney = BigMoney("12123542352353532541342412341234114.0000000000001", "SHP")
        let m5: BigMoney = BigMoney("-813412513424215555124414444444444444444444444444444444444444444444444444444444444444444444444444444444444254848", "SHP")

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
class BigMoneyEqualsTest{
    @TestCase
    public func test(){
        let currencies: Currencies = Currencies.getCurrencies()
        let currency: Currency = match (currencies.currencyByCode("ZAR")) {
            case None => throw NoneValueException("没有找到Currency标准ZAR")
            case Some(v) => v
        }
        let m1: BigMoney = BigMoney(BigInt("1299943123546543214532346543214256764513233425653453136567432124555555644432546879797635"), currency)
        let m2: BigMoney = BigMoney("-123987654345678999876545678998765431234356534231232435434231324354231", "ZAR")
        let m3: BigMoney = BigMoney("12999431235465432145323465432142567645132334256534531365674321245555556444325468797976.35", "ZAR")

        @Expect(false, m1.equals(m2))
        @Expect(true, m1.equals(m3))
        @Expect(false, m2.equals(m3))
        @Expect(false, m2.equals(m1))
        @Expect(true, m3.equals(m1))
        @Expect(false, m3.equals(m2))
    }
}

@Test
class BigMoneyJudgmentOnSelf{
    let m1: BigMoney = BigMoney("12555776674367248784685682426457628745829756284375687234532879658723453", "WST")
    let m2: BigMoney = BigMoney("17824582928795687245987247532.12452352532546424314252542", "SCR")
    let m3: BigMoney = BigMoney("0", "LAK")
    let m4: BigMoney = BigMoney("0.0", "GTQ")
    let m5: BigMoney = BigMoney("-1228746279428930273985287345687623874587233286528736587", "IMP")
    let m6: BigMoney = BigMoney("-19723444428738273095.42354325256436432555555555555555532535123", "CAD")
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
class BigMoneyOperationOnSelf{
    @TestCase
    public func absoluteTest(){
        let m1: BigMoney = BigMoney("12314315154123455555555554326546665789856566", "WST")
        let m2: BigMoney = BigMoney("1143142532567664765735735632.113422454325364634562", "SCR")
        let m3: BigMoney = BigMoney("0", "LAK")
        let m4: BigMoney = BigMoney("0.0", "GTQ")
        let m5: BigMoney = BigMoney("-142345345674578569753452442522", "IMP")
        let m6: BigMoney = BigMoney("-1.4245235647655555465243255624535123", "CAD")
        m1.absolute()
        m2.absolute()
        m3.absolute()
        m4.absolute()
        m5.absolute()
        m6.absolute()
        @Expect(m1.amount, BigInt("1231431515412345555555555432654666578985656600"))
        @Expect(m2.amount, BigInt("114314253256766476573573563211"))
        @Expect(m3.amount, BigInt("0"))
        @Expect(m4.amount, BigInt("0"))
        @Expect(m5.amount, BigInt("14234534567457856975345244252200"))
        @Expect(m6.amount, BigInt("142"))
    }
    @TestCase
    public func negativeTest(){
        let m1: BigMoney = BigMoney("12314315154123455555555554326546665789856566", "WST")
        let m2: BigMoney = BigMoney("1143142532567664765735735632.113422454325364634562", "SCR")
        let m3: BigMoney = BigMoney("0", "LAK")
        let m4: BigMoney = BigMoney("0.0", "GTQ")
        let m5: BigMoney = BigMoney("-142345345674578569753452442522", "IMP")
        let m6: BigMoney = BigMoney("-1.4245235647655555465243255624535123", "CAD")
        m1.negative()
        m2.negative()
        m3.negative()
        m4.negative()
        m5.negative()
        m6.negative()
        @Expect(m1.amount, BigInt("-1231431515412345555555555432654666578985656600"))
        @Expect(m2.amount, BigInt("-114314253256766476573573563211"))
        @Expect(m3.amount, BigInt("0"))
        @Expect(m4.amount, BigInt("0"))
        @Expect(m5.amount, BigInt("14234534567457856975345244252200"))
        @Expect(m6.amount, BigInt("142"))
    }
}

@Test
class BigMoneyDisplayTest{
    @TestCase
    public func test1(){
        let m: BigMoney = BigMoney("1.46", "AWG")
        @Expect("1.46\u{0192}", m.display())
    }
    @TestCase
    public func test2(){
        let m: BigMoney = BigMoney("-13134.23", "MUR")
        @Expect("-\u{20a8}13,134.23", m.display())
    }
    @TestCase
    public func test3(){
        let m: BigMoney = BigMoney("0", "ZWL")
        @Expect("Z$0.00", m.display())
    }
    @TestCase
    public func test4(){
        let m: BigMoney = BigMoney("-0.0", "KYD")
        @Expect("$0.00", m.display())
    }
    @TestCase
    public func test5(){
        let m: BigMoney = BigMoney("-986134274785613487618734618746871236487.78543275", "CNY")
        @Expect("-986,134,274,785,613,487,618,734,618,746,871,236,487.79 \u{5143}", m.display())
    }
}

@Test
class BigMoneyDisplayByScientificNotationTest{
    @TestCase
    public func test1(){
        let m: BigMoney = BigMoney("1.46", "AWG")
        @Expect("1.46E0\u{0192}", m.displayByScientificNotation())
    }
    @TestCase
    public func test2(){
        let m: BigMoney = BigMoney("-13134.23", "AWG")
        @Expect("-13.13E3\u{0192}", m.displayByScientificNotation(integer_len: 2))
    }
    @TestCase
    public func test3(){
        let m: BigMoney = BigMoney("0", "AWG")
        @Expect("0.E0\u{0192}", m.displayByScientificNotation(integer_len: -1))
    }
    @TestCase
    public func test4(){
        let m: BigMoney = BigMoney("-0.0", "AWG")
        @Expect("0.E0\u{0192}", m.displayByScientificNotation())
    }
    @TestCase
    public func test5(){
        let m: BigMoney = BigMoney("-986134274785613487618734618746871236487.78543275", "AWG")
        @Expect("-0.98E39\u{0192}", m.displayByScientificNotation(integer_len: -2))
    }
    @TestCase
    public func test6(){
        let m: BigMoney = BigMoney("-986134274785613487618734618746871236487.78543275", "AWG")
        @Expect("-98.6E37\u{0192}", m.displayByScientificNotation(integer_len: 2, fractional_len: 1))
    }
    @TestCase
    public func test7(){
        let m: BigMoney = BigMoney("-986134274785613487618734618746871236487.78543275", "AWG")
        @Expect("-9.861342E38\u{0192}", m.displayByScientificNotation(integer_len: 1, fractional_len: 6))
    }
}

@Test
class BigMoneyOperatorTest{
    @TestCase
    public func test1(){
        let m1: BigMoney = BigMoney("131412541314435364576657655624353421324.687453287643587", "AED")
        let m2: BigMoney = BigMoney("-131412541314435364576657655624353421324.687453287643587", "AED")
        
        let m: BigMoney = m1 + m2
        @Expect(m.amount, BigInt(0))
    }
    @TestCase
    public func test2(){
        let m1: BigMoney = BigMoney("-1234145556442341242543523454.24353252302234523452355", "TJS")
        let m2: BigMoney = BigMoney("-162434524525634234513254531244425.38546456245325325464444444428", "TJS")
        
        let m: BigMoney = m1 - m2
        @Expect(m.amount, BigInt("16243329038007779217201198772097115"))
    }
    @TestCase
    public func test3(){
        let m1: BigMoney = BigMoney("-89745682734872856827345823458.234523525423", "COP")
        let m2: BigMoney = BigMoney("23453256443253245325145432.2342", "COP")
        
        let m: BigMoney = m1 % m2
        @Expect(m.amount, BigInt("992967345731303198574568598"))
    }
    @TestCase
    public func test4(){
        let m1: BigMoney = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        let m2: BigMoney = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        let m: BigMoney = m1 * m2
        @Expect(m.amount, BigInt("-21971797978002054031917875765532458497894733462543"))
    }
    @TestCase
    public func test5(){
        let m1: BigMoney = BigMoney("121234325254644235325326462.3034543143232563654333245245245", "KWD")
        let m2: BigMoney = BigMoney("-181234134242524355234.2345234154235235634657686789679650", "KWD")
        let m: BigMoney = m1 / m2
        @Expect(m.amount, BigInt("-668937591"))
    }
    @TestCase
    public func test6(){
        let m1: BigMoney = BigMoney("11345443412352344235356444444465444444413435234532532522.30541324413241234122222333", "KWD")
        
        let m2: BigMoney = -m1
        @Expect(m2.amount, BigInt("-11345443412352344235356444444465444444413435234532532522305"))
    }
}