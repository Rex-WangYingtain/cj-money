package cj_money

import std.math.*
import std.collection.*
import std.math.numeric.*

// ====== Money ======

/**
 * @brief      对Money类型的二元运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（add，subtract，modulus）
 *
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 *
 * @return     计算得到的Money对象
 */
func calculate(a: Money, b: Money, calculator: (Money, Money) -> Money): Money {
    if (!a.sameCurrency(b)) {
        throw CurrencyNotSameException("a的Currency的code为${a.currency.code}，b的Currency的code为${b.currency.code}")
    }
    return calculator(a, b)
}

/**
 * @brief      对Money类型的二元运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（multiply，divide）
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 *
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 *
 * @return     计算得到的Money对象
 */
func calculate(a: Money, b: Money, calculator: (Money, Money, String) -> Money, mode!: String="round"): Money {
    if (!a.sameCurrency(b)) {
        throw CurrencyNotSameException("a的Currency的code为${a.currency.code}，b的Currency的code为${b.currency.code}")
    }
    return calculator(a, b, mode)
}

/**
 * @brief      对Money类型的一元运算
 *
 * @param      m    被操作数
 * @param      calculator    计算方法（absolute，negative）
 *
 * @return     计算得到的Money对象
 */
func calculate(m: Money, calculator: (Money) -> Money): Money {
    return calculator(m)
}

/**
 * @brief      函数 allocate 的功能是根据比例 r/s 对Money对象的金额进行分配。
 *
 * @param      m    被操作数
 * @param      r    取的比例
 * @param      s    划分比例
 *
 * @note       划分比例s不能小于等于零。当需要舍入时，直接舍去超出的位数。
 *
 * @return     计算得到的Money对象
 */
func allocate(m: Money, r: Int64, s: Int64): Money {

    if (s <= 0) {
        throw IllegalArgumentException("划分比例s不能小于等于零")
    }
    return Money(m.amount * r / s, m.currency)
}

/**
 * @brief      将一个 Money 结构体的金额按照给定的比例分配给多个接收方。除法后，剩余的金额将在各方之间进行循环分配。
 *
 * @param      m    被操作数
 * @param      rs   一个表示分配权重的数组
 *
 * @note       划分比例应该为大于等于0的整数。除法后，剩余的金额将在各方之间进行循环分配。
 *
 * @return     Money对象的ArrayList
 */
func allocate(m: Money, rs: Array<Int64>): ArrayList<Money> {
    if (rs.size == 0) {
        throw IllegalArgumentException("划分比例的数组rs不能为空。")
    }
    // 计算比率和。
    var sum: Int64 = 0
    for (r in rs) {
        if (r < 0) {
            throw IllegalArgumentException("划分比例不能为负数。")
        }
        sum += r
    }

    var total: Int64 = 0
    let money_list: ArrayList<Money> = ArrayList<Money>()
    for (r in rs) {
        let tmp = allocate(m, r, sum)
        money_list.append(tmp)
        total += tmp.amount
    }

    // 计算剩余值
    var left = m.amount - total
    var sub: Int64 = 1
    if (left < 0) {
        sub = -sub
    }

    for (i in 0..money_list.size) {
        if (left == 0){
            break
        }
        money_list[i].amount = money_list[i].amount + sub
        left -= sub
    }

    return money_list
}

/**
 * @brief      函数 round 的功能是根据指定的精度 e 对Money的金额进行四舍五入操作。
 *
 * @param      m    被操作数
 * @param      e    精度
 *
 * @note       精度 e 为正整数。
 *
 * @return     计算得到的Money对象
 */
func round(m: Money, e: Int64): Money {
    if (e <= 0) {
        throw IllegalArgumentException("精度 e 为正整数。")
    }

    var absam: Int64 = abs(m.amount)
    let exp: Int64 = Int64(pow(10.0, e))
    let dec: Int64 = absam % exp

    if (dec >= exp / 2) {
        absam += exp
    }

    absam = (absam / exp) * exp

    if (m.amount < 0) {
        return Money(-absam, m.currency)
    }

    return Money(absam, m.currency)
}

/**
 * @brief      将Money对象m的金额平均分为n份，并使用Money对象的ArrayList返回
 *             除法后，剩余的金额将在各方之间进行循环分配。
 *
 * @param      m    被操作数
 * @param      n    份数
 *
 * @note       n应该为大于0的整数
 *
 * @return     Money对象的ArrayList
 */
func split(m: Money, n: Int64): ArrayList<Money> {
    if (n <= 0) {
        throw IllegalArgumentException("划分份数应该为大于0的整数。")
    }

    let amount: Int64 = m.amount / n
    let money_list: ArrayList<Money> = ArrayList<Money>()

    for (_ in 0..n) {
        money_list.append(Money(amount, m.currency))
    }

    // 计算剩余值r
    let r: Int64 = m.amount % n
    var l: Int64 = abs(r)

    var v: Int64 = 1
    if (m.amount < 0) {
        v = -1
    }

    for (i in 0..n) {
        if (l == 0) {
            break
        }
        money_list[i].amount = money_list[i].amount + v
        l--
    }
    return money_list
}

/**
 * @brief      对Money类型的加运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 *
 * @return     计算得到的Money对象
 */
func add(a: Money, b: Money): Money {
    return Money(a.amount + b.amount, a.currency)
}

/**
 * @brief      对Money类型的减运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 *
 * @return     计算得到的Money对象
 */
func subtract(a: Money, b: Money): Money {
    return Money(a.amount - b.amount, a.currency)
}

/**
 * @brief      对Money类型的乘运算
 *
 * @param      a    被乘数
 * @param      b    乘数
 * mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 *
 * @return     计算得到的Money对象
 */
func multiply(a: Money, b: Money, mode!: String="round"): Money {
    let fraction: Int64 = a.currency.fraction
    let exp: Int64 = Int64(pow(10.0, fraction))
    var res: Int64 = a.amount * b.amount / exp

    if (mode == "round") {     // 四舍五入
        if (a.amount * b.amount < 0) {
            if (-(a.amount * b.amount % exp) < exp / 2) {
                return Money(res, a.currency)
            }
            return Money(res - 1, a.currency)
        } else {
            if (a.amount * b.amount % exp < exp / 2) {
                return Money(res, a.currency)
            }
            return Money(res + 1, a.currency)
        }
    } else if(mode == "truncate") {    // 直接去掉剩余部分
        return Money(res, a.currency)
    } else if (mode == "ceil") {   // 直接去掉剩余部分后正数加一，负数减一
        if (a.amount * b.amount == 0) {
            return Money(res, a.currency)
        } else if (a.amount * b.amount < 0) {
            return Money(res - 1, a.currency)
        } else {
            return Money(res + 1, a.currency)
        }
    } else {
        throw IllegalArgumentException("没有舍入模式" + mode)
    }
}

/**
 * @brief      对Money类型的除运算
 *
 * @param      a    被除数
 * @param      b    除数
 * mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 *
 * @return     计算得到的Money对象
 */
func divide(a: Money, b: Money, mode!: String="round"): Money {
    if (b.isZero()) {
        throw IllegalArgumentException("除以零错误")
    }

    let fraction: Int64 = a.currency.fraction
    let exp: Int64 = Int64(pow(10.0, fraction))
    var res: Int64 = a.amount * exp / b.amount

    if (mode == "round") {     // 四舍五入
        if (a.amount * b.amount < 0) {
            if (-(a.amount * exp * 10 / b.amount  % 10) < 5) {
                return Money(res, a.currency)
            }
            return Money(res - 1, a.currency)
        } else {
            if (a.amount * exp * 10 / b.amount  % 10 < 5) {
                return Money(res, a.currency)
            }
            return Money(res + 1, a.currency)
        }
    } else if (mode == "truncate") {   // 直接去掉剩余部分
        return Money(res, a.currency)
    } else if (mode == "ceil") {   // 直接去掉剩余部分后正数加一，负数减一
        if (a.amount == 0) {
            return Money(res, a.currency)
        } else if (a.amount < 0) {
            return Money(res - 1, a.currency)
        } else {
            return Money(res + 1, a.currency)
        }
    } else {
        throw IllegalArgumentException("没有舍入模式" + mode)
    }
}

/**
 * @brief      对Money类型的取模运算。
 *
 * @param      a    被操作数
 * @param      b    操作数
 *
 * @return     计算得到的Money对象
 */
func modulus(a: Money, b: Money): Money {
    if (b.isZero()) {
        throw IllegalArgumentException("对零取模错误")
    }
    var ans: Int64 = a.amount % b.amount
    if (ans * b.amount < 0){
        ans += b.amount
    }
    return Money(ans, a.currency)
}

/**
 * @brief      对Money类型的取绝对值操作
 *
 * @param      m    被操作数
 *
 * @return     计算得到的Money对象
 */
func absolute(m: Money): Money {
    return Money(abs(m.amount), m.currency)
}

/**
 * @brief      对Money类型的取负数操作
 *
 * @param      m    被操作数
 *
 * @return     计算得到的Money对象
 */
func negative(m: Money): Money {
    return Money(-m.amount, m.currency)
}

// ====== BigMoney ======

/**
 * @brief      对BigMoney类型的二元运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（add，subtract，modulus）
 *
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 *
 * @return     计算得到的BigMoney对象
 */
func calculate(a: BigMoney, b: BigMoney, calculator: (BigMoney, BigMoney) -> BigMoney): BigMoney {
    if (!a.sameCurrency(b)) {
        throw CurrencyNotSameException("a的Currency的code为${a.currency.code}，b的Currency的code为${b.currency.code}")
    }
    return calculator(a, b)
}

/**
 * @brief      对BigMoney类型的二元运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（multiply，divide）
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 *
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 *
 * @return     计算得到的BigMoney对象
 */
func calculate(a: BigMoney, b: BigMoney, calculator: (BigMoney, BigMoney, String) -> BigMoney, mode!: String="round"): BigMoney {
    if (!a.sameCurrency(b)) {
        throw CurrencyNotSameException("a的Currency的code为${a.currency.code}，b的Currency的code为${b.currency.code}")
    }
    return calculator(a, b, mode)
}

/**
 * @brief      对BigMoney类型的一元运算
 *
 * @param      m    被操作数
 * @param      calculator    计算方法（absolute，negative）
 *
 * @return     计算得到的BigMoney对象
 */
func calculate(m: BigMoney, calculator: (BigMoney) -> BigMoney): BigMoney {
    return calculator(m)
}

/**
 * @brief      函数 allocate 的功能是根据比例 r/s 对BigMoney对象的金额进行分配。
 *
 * @param      m    被操作数
 * @param      r    取的比例
 * @param      s    划分比例
 *
 * @note       划分比例s不能小于等于零。当需要舍入时，直接舍去超出的位数。
 *
 * @return     计算得到的BigMoney对象
 */
func allocate(m: BigMoney, r: Int64, s: Int64): BigMoney {
    if (s <= 0) {
        throw IllegalArgumentException("划分比例s不能小于等于零")
    }
    return BigMoney(m.amount * BigInt(r) / BigInt(s), m.currency)
}

/**
 * @brief      将一个 BigMoney 结构体的金额按照给定的比例分配给多个接收方。除法后，剩余的金额将在各方之间进行循环分配。
 *
 * @param      m    被操作数
 * @param      rs   一个表示分配权重的数组
 *
 * @note       划分比例应该为大于等于0的整数。除法后，剩余的金额将在各方之间进行循环分配。
 *
 * @return     BigMoney对象的ArrayList
 */
func allocate(m: BigMoney, rs: Array<Int64>): ArrayList<BigMoney> {
    if (rs.size == 0) {
        throw IllegalArgumentException("划分比例的数组rs不能为空。")
    }
    // 计算比率和。
    var sum: Int64 = 0
    for (r in rs) {
        if (r < 0) {
            throw IllegalArgumentException("划分比例不能为负数。")
        }
        sum += r
    }

    var total: BigInt = BigInt_ZERO
    let money_list: ArrayList<BigMoney> = ArrayList<BigMoney>()
    for (r in rs) {
        let tmp: BigMoney = allocate(m, r, sum)
        money_list.append(tmp)
        total += tmp.amount
    }

    // 计算剩余值
    var left: BigInt  = m.amount - total
    var sub: BigInt = BigInt_ONE
    if (left < BigInt_ZERO) {
        sub = -sub
    }

    for (i in 0..money_list.size) {
        if (left == BigInt_ZERO){
            break
        }
        money_list[i].amount = money_list[i].amount + sub
        left -= sub
    }

    return money_list
}

/**
 * @brief      函数 round 的功能是根据指定的精度 e 对BigMoney的金额进行四舍五入操作。
 *
 * @param      m    被操作数
 * @param      e    精度
 *
 * @note       精度 e 为正整数。
 *
 * @return     计算得到的Money对象
 */
func round(m: BigMoney, e: Int64): BigMoney {
    if (e <= 0) {
        throw IllegalArgumentException("精度 e 为正整数。")
    }

    var absam: BigInt
    if (m.amount >= BigInt_ZERO){
        absam = m.amount
    }else {
        absam = -m.amount
    }

    let exp: BigInt = BigInt(Int64(pow(10.0, e)))
    let dec: BigInt = absam % exp

    if (dec >= exp / BigInt_TWO) {
        absam += exp
    }

    absam = (absam / exp) * exp

    if (m.amount < BigInt_ZERO) {
        return BigMoney(-absam, m.currency)
    }

    return BigMoney(absam, m.currency)
}

/**
 * @brief      将BigMoney对象m的金额平均分为n份，并使用BigMoney对象的ArrayList返回
 *             除法后，剩余的金额将在各方之间进行循环分配。
 *
 * @param      m    被操作数
 * @param      n    份数
 *
 * @note       n应该为大于0的整数
 *
 * @return     BigMoney对象的ArrayList
 */
func split(m: BigMoney, n: Int64): ArrayList<BigMoney> {
    if (n <= 0) {
        throw IllegalArgumentException("划分份数应该为大于0的整数。")
    }

    let amount: BigInt = m.amount / BigInt(n)
    let money_list: ArrayList<BigMoney> = ArrayList<BigMoney>()

    for (_ in 0..n) {
        money_list.append(BigMoney(amount, m.currency))
    }

    // 计算剩余值r
    let r: BigInt = m.amount % BigInt(n)
    var l: BigInt
    if (r >= BigInt_ZERO){
        l = r
    }else {
        l = -r
    }

    var v: BigInt
    if (m.amount < BigInt_ZERO) {
        v = BigInt_MINUS_ONE
    }else {
        v = BigInt_ONE
    }

    for (i in 0..n) {
        if (l == BigInt_ZERO) {
            break
        }
        money_list[i].amount = money_list[i].amount + v
        l -= BigInt_ONE
    }
    return money_list
}

/**
 * @brief      对BigMoney类型的加运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 *
 * @return     计算得到的BigMoney对象
 */
func add(a: BigMoney, b: BigMoney): BigMoney {
    return BigMoney(a.amount + b.amount, a.currency)
}

/**
 * @brief      对BigMoney类型的减运算
 *
 * @param      a    被减数
 * @param      b    减数
 *
 * @return     计算得到的BigMoney对象
 */
func subtract(a: BigMoney, b: BigMoney): BigMoney {
    return BigMoney(a.amount - b.amount, a.currency)
}

/**
 * @brief      对BigMoney类型的乘运算
 *
 * @param      a    被操作数
 * @param      b    操作数
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 *
 * @return     计算得到的BigMoney对象
 */
func multiply(a: BigMoney, b: BigMoney, mode!: String="round"): BigMoney {
    let fraction: Int64 = a.currency.fraction
    let exp: BigInt = BigInt(Int64(pow(10.0, fraction)))
    var res: BigInt = a.amount * b.amount / exp

    if (mode == "round") {
        if (a.amount * b.amount < BigInt_ZERO) {
            if (-(a.amount * b.amount % exp) < exp / BigInt_TWO) {
                return BigMoney(res, a.currency)
            }
            return BigMoney(res - BigInt_ONE, a.currency)
        } else {
            if (a.amount * b.amount % exp < exp / BigInt_TWO) {
                return BigMoney(res, a.currency)
            }
            return BigMoney(res + BigInt_ONE, a.currency)
        }
    } else if (mode == "truncate") {
        return BigMoney(res, a.currency)
    } else if (mode == "ceil") {
        if (a.amount * b.amount == BigInt_ZERO) {
            return BigMoney(res, a.currency)
        } else if (a.amount * b.amount < BigInt_ZERO){
            return BigMoney(res - BigInt_ONE, a.currency)
        } else {
            return BigMoney(res + BigInt_ONE, a.currency)
        }
    } else {
        throw IllegalArgumentException("没有舍入模式" + mode)
    }
}

/**
 * @brief      对BigMoney类型的除运算
 *
 * @param      a    被除数
 * @param      b    除数
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 *
 * @return     计算得到的BigMoney对象
 */
func divide(a: BigMoney, b: BigMoney, mode!: String="round"): BigMoney {
    if (b.isZero()) {
        throw IllegalArgumentException("除以零错误")
    }
    let fraction: Int64 = a.currency.fraction
    let exp: BigInt = BigInt(Int64(pow(10.0, fraction)))
    var res: BigInt = a.amount * exp / b.amount

    if (mode == "round") {
        if (a.amount < BigInt_ZERO) {
            if (-(a.amount * exp * BigInt_TEN / b.amount  % BigInt_TEN) < BigInt_FIVE) {
                return BigMoney(res, a.currency)
            }
            return BigMoney(res - BigInt_ONE, a.currency)
        } else {
            if (a.amount * exp * BigInt_TEN / b.amount  % BigInt_TEN < BigInt_FIVE) {
                return BigMoney(res, a.currency)
            }
            return BigMoney(res + BigInt_ONE, a.currency)
        }
    } else if (mode == "truncate"){
        return BigMoney(res, a.currency)
    } else if (mode == "ceil") {
        if (a.amount == BigInt_ZERO) {
            return BigMoney(res, a.currency)
        } else if (a.amount < BigInt_ZERO){
            return BigMoney(res - BigInt_ZERO, a.currency)
        } else {
            return BigMoney(res + BigInt_ZERO, a.currency)
        }
    } else {
        throw IllegalArgumentException("没有舍入模式" + mode)
    }
}

/**
 * @brief      对BigMoney类型的取模运算。
 *
 * @param      a    被操作数
 * @param      b    操作数
 *
 * @return     计算得到的BigMoney对象
 */
func modulus(a: BigMoney, b: BigMoney): BigMoney {
    if (b.isZero()) {
        throw IllegalArgumentException("对零取模错误")
    }

    var ans: BigInt = a.amount % b.amount
    if (ans * b.amount < BigInt_ZERO){
        ans += b.amount
    }
    return BigMoney(ans, a.currency)
}

/**
 * @brief      对BigMoney类型的取绝对值操作
 *
 * @param      m    被操作数
 *
 * @return     计算得到的BigMoney对象
 */
func absolute(m: BigMoney): BigMoney {
    return BigMoney(abs(m.amount), m.currency)
}

/**
 * @brief      对BigMoney类型的取负数操作
 *
 * @param      m    被操作数
 *
 * @return     计算得到的BigMoney对象
 */
func negative(m: BigMoney): BigMoney {
    return BigMoney(-m.amount, m.currency)
}
