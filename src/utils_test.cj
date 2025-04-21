package cj_money

import std.unittest.*
import std.unittest.testmacro.*

import std.math.numeric.*

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

@Test
class FSM_number_stringTest {
    @TestCase
    public func test1() {
        let tuple = FSMNumberString("123")
        @Expect(tuple[0], b'+')
        @Expect(tuple[1], "123")
        @Expect(tuple[2], "")
        @Expect(tuple[3], b'+')
        @Expect(tuple[4], "")
    }
    @TestCase
    public func test2() {
        let tuple = FSMNumberString("-123")
        @Expect(tuple[0], b'-')
        @Expect(tuple[1], "123")
        @Expect(tuple[2], "")
        @Expect(tuple[3], b'+')
        @Expect(tuple[4], "")
    }
    @TestCase
    public func test3() {
        let tuple = FSMNumberString("-123.456")
        @Expect(tuple[0], b'-')
        @Expect(tuple[1], "123")
        @Expect(tuple[2], "456")
        @Expect(tuple[3], b'+')
        @Expect(tuple[4], "")
    }
    @TestCase
    public func test4() {
        let tuple = FSMNumberString("-123.456e-789")
        @Expect(tuple[0], b'-')
        @Expect(tuple[1], "123")
        @Expect(tuple[2], "456")
        @Expect(tuple[3], b'-')
        @Expect(tuple[4], "789")
    }
    @TestCase
    public func test5() {
        let tuple = FSMNumberString("-123.456E789")
        @Expect(tuple[0], b'-')
        @Expect(tuple[1], "123")
        @Expect(tuple[2], "456")
        @Expect(tuple[3], b'+')
        @Expect(tuple[4], "789")
    }
    @TestCase
    public func test6() {
        let tuple = FSMNumberString("-.456e789")
        @Expect(tuple[0], b'-')
        @Expect(tuple[1], "")
        @Expect(tuple[2], "456")
        @Expect(tuple[3], b'+')
        @Expect(tuple[4], "789")
    }
    @TestCase
    public func test7() {
        let tuple = FSMNumberString(".456e789")
        @Expect(tuple[0], b'+')
        @Expect(tuple[1], "")
        @Expect(tuple[2], "456")
        @Expect(tuple[3], b'+')
        @Expect(tuple[4], "789")
    }
}

@Test
class NumberStringToSmallAmountTest {
    // truncate
    @TestCase
    public func test1() {
        let ans: Int64 = NumberStringToSmallAmount("123", 2, mode:"truncate")
        @Expect(ans, 12300)
    }
    @TestCase
    public func test2() {
        let ans: Int64 = NumberStringToSmallAmount("-123", 3, mode:"truncate")
        @Expect(ans, -123000)
    }
    @TestCase
    public func test3() {
        let ans: Int64 = NumberStringToSmallAmount("-123.456", 2, mode:"truncate")
        @Expect(ans, -12345)
    }
    @TestCase
    public func test4() {
        let ans: Int64 = NumberStringToSmallAmount("-123.456e-789", 2, mode:"truncate")
        @Expect(ans, 0)
    }
    @TestCase
    public func test5() {
        let ans: Int64 = NumberStringToSmallAmount(".456e2", 2, mode:"truncate")
        @Expect(ans, 4560)
    }

    // ceil
    @TestCase
    public func test6() {
        let ans: Int64 = NumberStringToSmallAmount("123", 2, mode:"ceil")
        @Expect(ans, 12300)
    }
    @TestCase
    public func test7() {
        let ans: Int64 = NumberStringToSmallAmount("-123", 3, mode:"ceil")
        @Expect(ans, -123000)
    }
    @TestCase
    public func test8() {
        let ans: Int64 = NumberStringToSmallAmount("-123.456", 2, mode:"ceil")
        @Expect(ans, -12344)
    }
    @TestCase
    public func test9() {
        let ans: Int64 = NumberStringToSmallAmount("-123.456e-789", 2, mode:"ceil")
        @Expect(ans, 1)
    }
    @TestCase
    public func test10() {
        let ans: Int64 = NumberStringToSmallAmount(".4568987e2", 2, mode:"ceil")
        @Expect(ans, 4569)
    }

    // round
    @TestCase
    public func test11() {
        let ans: Int64 = NumberStringToSmallAmount("123", 2, mode:"round")
        @Expect(ans, 12300)
    }
    @TestCase
    public func test12() {
        let ans: Int64 = NumberStringToSmallAmount("-123", 3, mode:"round")
        @Expect(ans, -123000)
    }
    @TestCase
    public func test13() {
        let ans: Int64 = NumberStringToSmallAmount("-123.456", 2, mode:"round")
        @Expect(ans, -12346)
    }
    @TestCase
    public func test14() {
        let ans: Int64 = NumberStringToSmallAmount("-123.456e-789", 2, mode:"round")
        @Expect(ans, 0)
    }
    @TestCase
    public func test15() {
        let ans: Int64 = NumberStringToSmallAmount(".4568487e2", 2, mode:"round")
        @Expect(ans, 4568)
    }
    @TestCase
    public func test16() {
        let ans: Int64 = NumberStringToSmallAmount("0.005", 2, mode:"round")
        @Expect(ans, 1)
    }
}

@Test
class NumberStringToBigAmountTest {
    // truncate
    @TestCase
    public func test1() {
        let ans: BigInt = NumberStringToBigAmount("1231928348132475823791837215732484329137284884319287348912734183291327", 2, mode:"truncate")
        @Expect(ans, BigInt("123192834813247582379183721573248432913728488431928734891273418329132700"))
    }
    @TestCase
    public func test2() {
        let ans: BigInt = NumberStringToBigAmount("-12313241233791837215732484329137284884319287348912734183291327", 3, mode:"truncate")
        @Expect(ans, BigInt("-12313241233791837215732484329137284884319287348912734183291327000"))
    }
    @TestCase
    public func test3() {
        let ans: BigInt = NumberStringToBigAmount("-1231487871342872134731123423134241342321431424314213422643.45123134213426", 2, mode:"truncate")
        @Expect(ans, BigInt("-123148787134287213473112342313424134232143142431421342264345"))
    }
    @TestCase
    public func test4() {
        let ans: BigInt = NumberStringToBigAmount("-113244444444444413241222222224444444444444444324142123.459813274781932478134298713426e-7989", 2, mode:"truncate")
        @Expect(ans, BigInt(0))
    }
    @TestCase
    public func test5() {
        let ans: BigInt = NumberStringToBigAmount(".486689768777778766454653456e2", 2, mode:"truncate")
        @Expect(ans, BigInt("4866"))
    }

    // ceil
    @TestCase
    public func test6() {
        let ans: BigInt = NumberStringToBigAmount("12871934263468912778134278721347382148374297834123", 2, mode:"ceil")
        @Expect(ans, BigInt("1287193426346891277813427872134738214837429783412300"))
    }
    @TestCase
    public func test7() {
        let ans: BigInt = NumberStringToBigAmount("-12310342799128304183294183294193284031289470381420931420897", 3, mode:"ceil")
        @Expect(ans, BigInt("-12310342799128304183294183294193284031289470381420931420897000"))
    }
    @TestCase
    public func test8() {
        let ans: BigInt = NumberStringToBigAmount("-123430982792843724839243974389423879420374389438734294839.456", 2, mode:"ceil")
        @Expect(ans, BigInt("-12343098279284372483924397438942387942037438943873429483944"))
    }
    @TestCase
    public func test9() {
        let ans: BigInt = NumberStringToBigAmount("-129178324873142632817813427613423714287834126872314683.456e-76689", 2, mode:"ceil")
        @Expect(ans, BigInt("1"))
    }
    @TestCase
    public func test10() {
        let ans: BigInt = NumberStringToBigAmount(".456489332814972309748873142879342870932478098987e4", 2, mode:"ceil")
        @Expect(ans, BigInt("456490"))
    }

    // round
    @TestCase
    public func test11() {
        let ans: BigInt = NumberStringToBigAmount("121784361328797813264879612873946382174687129643", 2, mode:"round")
        @Expect(ans, BigInt("12178436132879781326487961287394638217468712964300"))
    }
    @TestCase
    public func test12() {
        let ans: BigInt = NumberStringToBigAmount("-181324796981234683172468712468723439894325434532321423", 3, mode:"round")
        @Expect(ans, BigInt("-181324796981234683172468712468723439894325434532321423000"))
    }
    @TestCase
    public func test13() {
        let ans: BigInt = NumberStringToBigAmount("-1214378781234683247813264879632187483.4593243124132543254326", 2, mode:"round")
        @Expect(ans, BigInt("-121437878123468324781326487963218748346"))
    }
    @TestCase
    public func test14() {
        let ans: BigInt = NumberStringToBigAmount("-121324124124321124412431241212343123.42387947823468734287432856e-789", 2, mode:"round")
        @Expect(ans, BigInt("0"))
    }
    @TestCase
    public func test15() {
        let ans: BigInt = NumberStringToBigAmount(".45687743218683428793268932869532875723478487e2", 2, mode:"round")
        @Expect(ans, BigInt("4569"))
    }
    @TestCase
    public func test16() {
        let ans: BigInt = NumberStringToBigAmount("0.005", 2, mode:"round")
        @Expect(ans, BigInt("1"))
    }
}

@Test
class ScientificNotationTest{
    @TestCase
    func test1() {  // 常规转换
        let tup = ScientificNotation("12345", 3, 1, 3)
        @Expect(tup[0], "1")
        @Expect(tup[1], "234")
        @Expect(tup[2], 1)
    }
    @TestCase
    func test2() {  // 极小数值处理
        let tup = ScientificNotation("12", 5, 0, 2)
        @Expect(tup[0], "0")
        @Expect(tup[1], "12")
        @Expect(tup[2], -3)
    }
    @TestCase
    func test3() {// 全零情况
        let tup = ScientificNotation("0000", 2, 1, 3)
        @Expect(tup[0], "0")
        @Expect(tup[1], "")
        @Expect(tup[2], 0)
    }
    @TestCase
    func test4() {  // 整数部分补零
        let tup = ScientificNotation("123", 1, 4, 2)
        @Expect(tup[0], "1230")
        @Expect(tup[1], "")
        @Expect(tup[2], -2)
    }
}