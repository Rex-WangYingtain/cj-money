package cj_money

import std.math.*
import std.convert.*
import std.math.numeric.*

/**
 * @brief      BigMoney用BigInt这个数据类型来模拟定点数，以适应大数运算
 */
public class BigMoney {
    /**
     * @brief      从BigInt创建并返回BigMoney的新实例。使用BigInt创建时，不是真实值转换，而是直接赋值
     *
     * @param      amount   金额
     * @param      currency   Currency对象，BigMoney的Currency标准
     */
    public BigMoney(
        var amount: BigInt, // 钱的金额
        let currency: Currency // 钱的标准
    ) {

    }

    /**
     * @brief      通过Money对象创建BigMoney对象
     *
     * @param      m   Money对象
     */
    public init(m: Money) {
        this.currency = m.currency
        this.amount = BigInt(m.amount)
    }

    /**
     * @brief      从数字字符串创建BigMoney实例
     *
     * @param      amount   数字字符串，表示BigMoney实例的金额
     * @param      currency   Currency对象，BigMoney的Currency标准
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, currency: Currency, mode!: String = "round") {
        this.currency = currency
        this.amount = NumberStringToBigAmount(amount, this.currency.fraction, mode: mode)
    }

    /**
     * @brief      从数字字符串创建BigMoney实例
     *
     * @param      amount   数字字符串，表示BigMoney实例的金额
     * @param      code   Currency对象对应的编号
     * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, code: String, code_mode!: String = "code", mode!: String = "round") {
        this.currency = Currency(code, mode: code_mode)
        this.amount = NumberStringToBigAmount(amount, this.currency.fraction, mode: mode)
    }

    /**
     * @brief      将BigMoney实例转换为Money实例并返回
     *
     * @return     返回的Money实例
     */
    public func toMoney() {
        return Money(this.amount.toInt64(), this.currency)
    }

    /**
     * @brief      判断BigMoney的Currency标准是否相同
     *
     * @param      obm   对比的BigMoney对象
     *
     * @return     是否相等的布尔值
     */
    public func sameCurrency(obm: BigMoney): Bool {
        return this.currency.equalsByCode(obm.currency)
    }

    /**
     * @brief      判断BigMoney的金额大小
     *
     * @param      obm   对比的BigMoney对象
     *
     * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
     *
     * @return     如果金额相等，返回0；被对比对象this大于对比对象obm返回1；否则返回-1
     */
    public func compareAmount(obm: BigMoney): Int64 {
        if (!this.sameCurrency(obm)) {
            throw CurrencyNotSameException(
                "this的Currency的code为${this.currency.code}，om的Currency的code为${obm.currency.code}")
        }
        if (this.amount > obm.amount) {
            return 1
        } else if (this.amount < obm.amount) {
            return -1
        }
        return 0
    }

    /**
     * @brief      判断被对比对象this的金额是否大于对比对象obm的金额
     *
     * @param      obm   对比的BigMoney对象
     *
     * @return     判断的布尔值
     */
    public func greaterThan(obm: BigMoney): Bool {
        return this.compareAmount(obm) == 1
    }

    /**
     * @brief      判断被对比对象this的金额是否大于等于对比对象obm的金额
     *
     * @param      obm   对比的BigMoney对象
     *
     * @return     判断的布尔值
     */
    public func greaterThanOrEqual(obm: BigMoney): Bool {
        return this.compareAmount(obm) >= 0
    }

    /**
     * @brief      判断被对比对象this的金额是否小于对比对象obm的金额
     *
     * @param      obm   对比的BigMoney对象
     *
     * @return     判断的布尔值
     */
    public func lessThan(obm: BigMoney): Bool {
        return this.compareAmount(obm) == -1
    }

    /**
     * @brief      判断被对比对象this的金额是否小于等于对比对象obm的金额
     *
     * @param      obm   对比的BigMoney对象
     *
     * @return     判断的布尔值
     */
    public func lessThanOrEqual(obm: BigMoney): Bool {
        return this.compareAmount(obm) <= 0
    }

    /**
     * @brief      判断两个BigMoney对象是否完全相等。包括Currency对象和金额amount
     *
     * @param      obm   对比的BigMoney对象
     *
     * @return     是否相等的布尔值
     */
    public func equals(obm: BigMoney): Bool {
        return this.compareAmount(obm) == 0
    }

    /**
     * @brief      判断BigMoney对象的金额amount是否为0
     *
     * @return     是否为0的布尔值
     */
    public func isZero(): Bool {
        return this.amount == BigInt_ZERO
    }

    /**
     * @brief      判断BigMoney对象的金额amount是否为正值
     *
     * @return     是否为为正值的布尔值
     */
    public func isPositive(): Bool {
        return this.amount > BigInt_ZERO
    }

    /**
     * @brief      判断BigMoney对象的金额amount是否为负值
     *
     * @return     是否为负值的布尔值
     */
    public func isNegative(): Bool {
        return this.amount < BigInt_ZERO
    }

    /**
     * @brief      将金额amount属性取绝对值
     */
    public func absolute() {
        this.amount = abs(this.amount)
    }

    /**
     * @brief      将金额amount属性取负
     */
    public func negative() {
        this.amount = -this.amount
    }

    /**
     * @brief      Display允许将String结构表示为给定货币值的字符串。
     *
     * @return     给定货币值的字符串
     */
    public func display(): String {
        return this.currency.getFormatter().format(this.amount)
    }

    /**
     * @brief      BigMoney展示为科学计数法，并按照标准对应的格式展示。
     *
     * @param      integer_len      表示整数部分的长度，默认为1
     * @param      fractional_len   表示小数部分的最大长度，默认为2
     *
     * @return     科学计数法字符串
     */
    public func displayByScientificNotation(integer_len!: Int64=1, fractional_len!: Int64=2): String {
        let tup = ScientificNotation(this.amount.toString(), this.currency.fraction, integer_len, fractional_len)
        let str: String
        if (tup[0] == "-") {
            str = tup[0] + tup[1] + "." + tup[2] + "E" + tup[3].toString()
        } else {
            str = tup[1] + "." + tup[2] + "E" + tup[3].toString()
        }
        return this.currency.getFormatter().substitute(str)
    }

    // 下面是操作符重载

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, add)
     */
    public operator func +(right: BigMoney): BigMoney{
        return calculate(this, right, add)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, subtract)
     */
    public operator func -(right: BigMoney): BigMoney{
        return calculate(this, right, subtract)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, modulus)
     */
    public operator func %(right: BigMoney): BigMoney{
        return calculate(this, right, modulus)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, multiply, "round")
     */
    public operator func *(right: BigMoney): BigMoney{
        return calculate(this, right, multiply)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, divide, "round")
     */
    public operator func /(right: BigMoney): BigMoney{
        return calculate(this, right, divide)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, negative)
     */
    public operator func -(): BigMoney{
        return calculate(this, negative)
    }

    /**
     * @brief      相对于this.equals(obm)
     */
    public operator func ==(obm: BigMoney): Bool{
        return this.equals(obm)
    }

    /**
     * @brief      相对于this.greaterThan(obm)
     */
    public operator func >(obm: BigMoney): Bool{
        return this.greaterThan(obm)
    }

    /**
     * @brief      相对于this.greaterThanOrEqual(obm)
     */
    public operator func >=(obm: BigMoney): Bool{
        return this.greaterThanOrEqual(obm)
    }

    /**
     * @brief      相对于this.lessThan(obm)
     */
    public operator func <(obm: BigMoney): Bool{
        return this.lessThan(obm)
    }

    /**
     * @brief      相对于this.lessThanOrEqual(obm)
     */
    public operator func <=(obm: BigMoney): Bool{
        return this.lessThanOrEqual(obm)
    }
}
