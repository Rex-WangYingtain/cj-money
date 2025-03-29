package cj_money

import std.math.*
import std.collection.*

interface Calculate {
    func calculate(a: Money, b: Money, calculator: (Money, Money) -> Money): Money
    /**
     * @brief      对Money类型的二元运算
     *
     * @param      a    被操作数
     * @param      b    操作数
     * @param      calculator    计算方法（add，subtract，multiply，divide，modulus）
     *
     * @note       在调用时，函数会先检查Money对象a和Money对象b的Currency标准是否相等。需要舍入时，采用四舍五入的策略。
     *
     * @return     计算得到的Money对象
     */
    func calculate(m: Money, calculator: (Money) -> Money): Money
    /**
     * @brief      对Money类型的一元运算
     *
     * @param      m    被操作数
     * @param      calculator    计算方法（absolute，negative）
     *
     * @return     计算得到的Money对象
     */
    func allocate(m: Money, r: Int64, s: Int64): Money
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
    func round(m: Money, e: Int64): Money
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
    func split(m: Money, n: Int64): ArrayList<Money>
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
    func allocate(m: Money, rs: Array<Int64>): ArrayList<Money>
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
}

class Calculator <: Calculate {
    public func calculate(a: Money, b: Money, calculator: (Money, Money) -> Money): Money {
        if (!a.sameCurrency(b)) {
            throw CurrencyNotSameException("a的Currency的code为${a.currency.code}，b的Currency的code为${b.currency.code}")
        }
        return calculator(a, b)
    }

    public func calculate(m: Money, calculator: (Money) -> Money): Money {
        return calculator(m)
    }

    public func allocate(m: Money, r: Int64, s: Int64): Money {
        if (s <= 0) {
            throw IllegalArgumentException("划分比例s不能小于等于零")
        }
        return Money(m.amount * r / s, m.currency)
    }

    public func round(m: Money, e: Int64): Money {
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

    public func split(m: Money, n: Int64): ArrayList<Money> {
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

    public func allocate(m: Money, rs: Array<Int64>): ArrayList<Money> {
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
            let tmp = this.allocate(m, r, sum)
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
}

func add(a: Money, b: Money): Money {
    /**
     * @brief      对Money类型的加运算
     *
     * @param      a    被操作数
     * @param      b    操作数
     *
     * @return     计算得到的Money对象
     */
    return Money(a.amount + b.amount, a.currency)
}

func subtract(a: Money, b: Money): Money {
    /**
     * @brief      对Money类型的减运算
     *
     * @param      a    被操作数
     * @param      b    操作数
     *
     * @return     计算得到的Money对象
     */
    return Money(a.amount - b.amount, a.currency)
}

func multiply(a: Money, b: Money): Money {
    /**
     * @brief      对Money类型的乘运算
     *
     * @param      a    被操作数
     * @param      b    操作数
     *
     * @return     计算得到的Money对象
     */
    let fraction: Int64 = a.currency.fraction
    let exp: Int64 = Int64(pow(10.0, fraction))
    var res: Int64 = a.amount * b.amount / exp

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
}

func divide(a: Money, b: Money): Money {
    /**
     * @brief      对Money类型的除运算
     *
     * @param      a    被操作数
     * @param      b    操作数
     *
     * @return     计算得到的Money对象
     */
    if (b.isZero()) {
        throw IllegalArgumentException("除以零错误")
    }

    let fraction: Int64 = a.currency.fraction
    let exp: Int64 = Int64(pow(10.0, fraction))
    var res: Int64 = a.amount * exp / b.amount

    if (a.amount * b.amount < 0) {
        if (-(a.amount * exp * 10 / b.amount  % 10) < 5) {
            return Money(res, a.currency)
        }
        return Money(res - 1, a.currency)
    } else {
        println(a.amount)
        println(b.amount)

        println(a.amount * exp * 10 / b.amount)
        println(a.amount * exp * 10 / b.amount  % 10)
        if (a.amount * exp * 10 / b.amount  % 10 < 5) {
            return Money(res, a.currency)
        }
        return Money(res + 1, a.currency)
    }
}

func modulus(a: Money, b: Money): Money {
    /**
     * @brief      对Money类型的取模运算。在数学中，取模运算的定义是：
     *             对于整数a和b（b≠0），存在唯一的整数q和r，
     *             使得a = b*q + r，且0 ≤ r < |b|。
     *             其中，q是商，r是余数，也就是取模的结果。
     *
     * @param      a    被操作数
     * @param      b    操作数
     *
     * @return     计算得到的Money对象
     */
    if (b.isZero()) {
        throw IllegalArgumentException("对零取模错误")
    }

    var ans: Int64 = a.amount % b.amount
    if (ans * b.amount < 0){
        ans += b.amount
    }
    return Money(ans, a.currency)
}

func absolute(m: Money): Money {
    /**
     * @brief      对Money类型的取绝对值操作
     *
     * @param      m    被操作数
     *
     * @return     计算得到的Money对象
     */
    return Money(abs(m.amount), m.currency)
}

func negative(m: Money): Money {
    /**
     * @brief      对Money类型的取负数操作
     *
     * @param      m    被操作数
     *
     * @return     计算得到的Money对象
     */
    return Money(-m.amount, m.currency)
}
