```cangjie
package cj_money

import std.collection.*
import std.math.*
import std.math.numeric.*


main(): Int64 {
    /* 首先介绍Money模块 */

    // 声明Money对象，Money对象有两个部分组成，amount和currency。
    // currency可以直接用Currency赋值，也可以使用货币的ISO字母代码。
    // amount可以使用整数和浮点数初始化。当使用整数，将直接将整数赋给amount变量；
    // 当使用浮点数，将根据currency中的fraction属性进行换算，以表示与浮点数相同的金额。
    let currency: Currency = Currency(".", ",", "AOA", 2, "973", "Kz", "1$")
    let m1: Money = Money(100, "CNY")
    let m2: Money = Money(100, currency)
    let m3: Money = Money(2.00, "CNY")
    let m4: Money = Money(200, currency)

    // 通过display方法，可以将Money对象按照currency中的template模板来获取一个字符串，用于展示
    println(m1.display())
    println(m2.display())
    println(m3.display())
    println(m4.display())

    // sameCurrency方法可以根据货币的ISO字母代码来判断Money中的currency对象是否相等，一般来讲，currency对象相等的Money对象才能进行运算
    println(m1.sameCurrency(m2))
    println(m1.sameCurrency(m3))

    // compareAmount方法用于比较currency对象相同的Money对象的金额的大小关系，等于返回0，大于返回1，小于返回-1。
    // greaterThan、greaterThanOrEqual、lessThan、lessThanOrEqual、equals是基于compareAmount方法的方法，
    // 用于比较currency对象相同的Money对象的金额的大小关系，返回相应的布尔值
    println(m1.compareAmount(m3))
    println(m1.greaterThan(m3))
    println(m1.greaterThanOrEqual(m3))
    println(m1.lessThan(m3))
    println(m1.lessThanOrEqual(m3))
    println(m1.equals(m3))

    // 方法isZero、isPositive、isNegative用于判断Money对象的金额amount属性的正负性
    println(m1.isZero())
    println(m2.isPositive())
    println(m3.isNegative())

    // absolute方法用于将Money对象的金额amount属性取绝对值
    // negative方法用于将金额amount属性取负
    m1.negative()
    println(m1.display())
    m1.absolute()
    println(m1.display())

    // asMajorUnits方法将Money对象的金额转化为浮点数表示
    println(m1.asMajorUnits())

    /* 下面介绍Calculator模块，这个模块对Money对象进行运算，并返回一个新的Money对象 */

    // calculate方法根据传入的函数指针按对应方法进行运算，运算前，会检查Curency标准是否相同
    // 二元运算（add，subtract，multiply，divide，modulus）
    // 一元运算（absolute，negative）
    let calculator: Calculator = Calculator()
    let m5: Money = calculator.calculate(m1, m3, add)
    println(m5.display())
    let m6: Money = calculator.calculate(m1, m3, subtract)
    println(m6.display())
    let m7: Money = calculator.calculate(m1, m3, multiply)
    println(m7.display())
    let m8: Money = calculator.calculate(m1, m3, divide)
    println(m8.display())
    let m9: Money = calculator.calculate(m1, m3, modulus)
    println(m9.display())
    let m10: Money = calculator.calculate(m1, absolute)
    println(m10.display())
    let m11: Money = calculator.calculate(m1, negative)
    println(m11.display())

    // allocate方法有两个重构
    // 一是是根据比例r/s 对Money对象的金额进行分配。
    // 二是将一个Mone对象的金额按照给定的比例分配给多个接收方。除法后，剩余的金额将在各方之间进行循环分配。
    let m12: Money = calculator.allocate(m1, 1, 2)
    println(m12.display())
    let ms1: ArrayList<Money> = calculator.allocate(m1, [1, 2, 3])
    println(ms1[0].display())
    println(ms1[1].display())
    println(ms1[2].display())

    // 方法 round 的功能是根据指定的精度 e 对Money的金额进行四舍五入操作。
    let m13: Money = calculator.round(m1, 1)
    println(m13.display())

    // 方法split将Money对象m的金额平均分为n份，并使用Money对象的ArrayList返回。除法后，剩余的金额将在各方之间进行循环分配。
    let ms2: ArrayList<Money> = calculator.split(m1, 3)
    println(ms2[0].display())
    println(ms2[1].display())
    println(ms2[2].display())

    /* 最后介绍db模块，这个模块主要实现了对Money对象的序列化和反序列化，方便数据库操作 */
    // serializeByCode将Money对象序列化为字符串。包含金额和Currency的code两项信息，不定义separator将默认为"|"
    println(serializeByCode(m1, separator: "|"))
    // deserializeAll将Money对象序列化为字符串。包含金额和Currency的全部信息，不定义separator将默认为"|"
    println(serializeAll(m1, separator: "|"))
    // deserializeByCode将 amount|code 字符串反序列化为Money对象，不定义separator将默认为"|"
    let m14: Money = deserializeByCode("999|GYD", separator: "|")
    println(m14.display())
    // deserializeAll将 amount|code|numericCode|fraction|grapheme|template|decimal|thousand 字符串反序列化为Money对象，不定义separator将默认为"|"
    let m15: Money = deserializeAll("970|ZWD|716|2|Z$|$1|.|,", separator: "|")
    println(m15.display())

    /* bigMoney的使用与Money的使用相似 */
    let bm1: BigMoney = BigMoney(BigInt("189732178342819734281273941864375134261342871234783429182347673843234"), currency)
    let bm2: BigMoney = BigMoney("-6428273457845568738192746871923498173429871346871349213464328756.134123412", "CNY")
    let bm3: BigMoney = BigMoney("109348913248914327879134287134281394281432731287944513312489.132413242134", "CNY")

    println(bm1.display())
    println(bm2.display())

    println(bm1.sameCurrency(bm2))
    println(bm2.sameCurrency(bm3))

    println(bm2.compareAmount(bm3))
    println(bm2.greaterThan(bm3))
    println(bm2.greaterThanOrEqual(bm3))
    println(bm2.lessThan(bm3))
    println(bm2.lessThanOrEqual(bm3))
    println(bm2.equals(bm3))

    println(bm1.isZero())
    println(bm1.isPositive())
    println(bm1.isNegative())

    bm1.negative()
    println(bm1.display())
    bm1.absolute()
    println(bm1.display())

    println(bm1.asMajorUnits())

    let bm4: BigMoney = calculator.calculate(bm2, bm3, add)
    println(bm4.display())
    let bm5: BigMoney = calculator.calculate(bm2, bm3, subtract)
    println(bm5.display())
    let bm6: BigMoney = calculator.calculate(bm2, bm3, multiply)
    println(bm6.display())
    let bm7: BigMoney = calculator.calculate(bm2, bm3, divide)
    println(bm7.display())
    let bm8: BigMoney = calculator.calculate(bm2, bm3, modulus)
    println(bm8.display())
    let bm9: BigMoney = calculator.calculate(bm1, absolute)
    println(bm9.display())
    let bm10: BigMoney = calculator.calculate(bm1, negative)
    println(bm10.display())

    let bm11: BigMoney = calculator.allocate(bm1, 1, 3)
    println(bm11.display())
    let bm12: ArrayList<BigMoney> = calculator.allocate(bm1, [1, 2, 3])
    println(bm12[0].display())
    println(bm12[1].display())
    println(bm12[2].display())

    let bm13: BigMoney = calculator.round(bm1, 2)
    println(bm13.display())

    println(serializeByCode(bm1, separator: "|"))
    println(serializeAll(bm1, separator: "|"))

    let bm14: BigMoney = deserializeBigMoneyByCode("99143123412344534325645656575462243512345456657568776765635443212349|GYD", separator: "|")
    println(bm14.display())
    let bm15: BigMoney = deserializeBigMoneyAll("92452352344352345324654549877877534743272834743498327824357423428742387970|ZWD|716|2|Z$|$1|.|,", separator: "|")
    println(bm15.display())

    return 0
}

```