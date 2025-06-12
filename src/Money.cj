package cj_money

import std.math.*
import std.convert.*
import std.math.numeric.*

/**
 * @brief      Money用Int64类型来模拟定点数，相对与BigMoney，表示范围受限，但理论上性能更快
 */
class Money {
    /**
     * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
     *
     * @param      amount   金额
     * @param      currency   Currency对象
     */
    public Money(
        var amount: Int64, // 钱的金额
        let currency: Currency // 钱的标准
    ) {
    }

    /**
     * @brief      从BigMoney实例创建并返回Money的新实例。
     *
     * @param      bm   BigMoney实例
     */
    public init(bm: BigMoney) {
        this.currency = bm.currency
        this.amount = bm.amount.toInt64()
    }

    /**
     * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
     *
     * @param      amount   金额
     * @param      code   currency标准对应的code
     */
    public init(amount: Int64, code: String, code_mode!: String = "code") {
        this.currency = Currency(code, mode: code_mode)

        this.amount = amount
    }

    /**
     * @brief      从float64创建并返回Money的新实例。
     *             总是将小数四舍五入。
     *
     * @param      amount   金额
     * @param      code   currency标准对应的code
     */
    public init(amount: Float64, code: String, code_mode!: String = "code") {
        this.currency = Currency(code, mode: code_mode)
        let currencyDecimals: Float64 = pow(10.0, currency.fraction)
        let float_amount = amount * currencyDecimals
        this.amount = Float64ToInt64Round(float_amount)
    }

    /**
     * @brief      从数字字符串创建Money实例
     *
     * @param      amount   数字字符串，表示Money实例的金额
     * @param      code   Currency对象对应的编号
     * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, code: String, code_mode!: String = "code", mode!: String = "round") {
        this.currency = Currency(code, mode: code_mode)
        this.amount = NumberStringToSmallAmount(amount, this.currency.fraction, mode: mode)
    }

    /**
     * @brief      从float64创建并返回Money的新实例。
     *             总是将小数四舍五入。
     *
     * @param      amount   金额
     * @param      currency   Currency对象
     *
     * @return     是否相等的布尔值
     */
    public init(amount: Float64, currency: Currency) {
        this.currency = currency

        let currencyDecimals: Float64 = pow(10.0, currency.fraction)
        let float_amount = amount * currencyDecimals
        this.amount = Float64ToInt64Round(float_amount)
    }

    /**
     * @brief      从数字字符串创建Money实例
     *
     * @param      amount   数字字符串，表示Money实例的金额
     * @param      currency   Currency对象，Money的Currency标准
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, currency: Currency, mode!: String = "round") {
        this.currency = currency
        this.amount = NumberStringToSmallAmount(amount, this.currency.fraction, mode: mode)
    }

    /**
     * @brief      将Money实例转换为BigMoney实例并返回
     *
     * @return     返回的BigMoney实例
     */
    public func toBigMoney() : BigMoney{
        return BigMoney(BigInt(this.amount), this.currency)
    }

    /**
     * @brief      判断Money的Currency标准是否相同
     *
     * @param      om   对比的Money对象
     *
     * @return     是否相等的布尔值
     */
    public func sameCurrency(om: Money): Bool {
        return this.currency.equalsByCode(om.currency)
    }

    /**
     * @brief      判断Money的金额大小
     *
     * @param      om   对比的Money对象
     *
     * @note       要求Money对象this和om的Currency标准相等
     *
     * @return     如果金额相等，返回0；被对比对象this大于对比对象om返回1；否则返回-1
     */
    public func compareAmount(om: Money): Int64 {
        if (!this.sameCurrency(om)) {
            throw CurrencyNotSameException(
                "this的Currency的code为${this.currency.code}，om的Currency的code为${om.currency.code}")
        }
        if (this.amount > om.amount) {
            return 1
        } else if (this.amount < om.amount) {
            return -1
        }
        return 0
    }

    /**
     * @brief      判断被对比对象this的金额是否大于对比对象om的金额
     *
     * @param      om   对比的Money对象
     *
     * @return     判断的布尔值
     */
    public func greaterThan(om: Money): Bool {
        return this.compareAmount(om) == 1
    }

    /**
     * @brief      判断被对比对象this的金额是否大于等于对比对象om的金额
     *
     * @param      om   对比的Money对象
     *
     * @return     判断的布尔值
     */
    public func greaterThanOrEqual(om: Money): Bool {
        return this.compareAmount(om) >= 0
    }

    /**
     * @brief      判断被对比对象this的金额是否小于对比对象om的金额
     *
     * @param      om   对比的Money对象
     *
     * @return     判断的布尔值
     */
    public func lessThan(om: Money): Bool {
        return this.compareAmount(om) == -1
    }

    /**
     * @brief      判断被对比对象this的金额是否小于等于对比对象om的金额
     *
     * @param      om   对比的Money对象
     *
     * @return     判断的布尔值
     */
    public func lessThanOrEqual(om: Money): Bool {
        return this.compareAmount(om) <= 0
    }

    /**
     * @brief      判断两个Money对象是否完全相等。包括Currency对象和金额amount
     *
     * @param      om   对比的Money对象
     *
     * @return     是否相等的布尔值
     */
    public func equals(om: Money): Bool {
        return this.compareAmount(om) == 0
    }

    /**
     * @brief      判断Money对象的金额amount是否为0
     *
     * @return     是否为0的布尔值
     */
    public func isZero(): Bool {
        return this.amount == 0
    }

    /**
     * @brief      判断Money对象的金额amount是否为正值
     *
     * @return     是否为为正值的布尔值
     */
    public func isPositive(): Bool {
        return this.amount > 0
    }

    /**
     * @brief      判断Money对象的金额amount是否为负值
     *
     * @return     是否为负值的布尔值
     */
    public func isNegative(): Bool {
        return this.amount < 0
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
     * @brief      Display允许将Money结构表示为给定货币值的字符串。
     *
     * @return     给定货币值的字符串
     */
    public func display(): String {
        return this.currency.getFormatter().format(this.amount)
    }

    /**
     * @brief      Money展示为科学计数法，并按照标准对应的格式展示。
     *
     * @param      integer_len      表示整数部分的长度，默认为1
     * @param      fractional_len   表示小数部分的最大长度，默认为2
     *
     * @return
     */
    public func displayByScientificNotation(integer_len!: Int64 = 1, fractional_len!: Int64=2): String {
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
     * @brief      相当于calculate(this: Money, right: Money, add)
     */
    public operator func +(right: Money): Money{
        return calculate(this, right, add)
    }

    /**
     * @brief      相当于calculate(this: Money, right: Money, subtract)
     */
    public operator func -(right: Money): Money{
        return calculate(this, right, subtract)
    }

    /**
     * @brief      相当于calculate(this: Money, right: Money, modulus)
     */
    public operator func %(right: Money): Money{
        return calculate(this, right, modulus)
    }

    /**
     * @brief      相当于calculate(this: Money, right: Money, multiply, "round")
     */
    public operator func *(right: Money): Money{
        return calculate(this, right, multiply)
    }

    /**
     * @brief      相当于calculate(this: Money, right: Money, divide, "round")
     */
    public operator func /(right: Money): Money{
        return calculate(this, right, divide)
    }

    /**
     * @brief      相当于calculate(this: Money, negative)
     */
    public operator func -(): Money{
        return calculate(this, negative)
    }

    /**
     * @brief      相对于this.equals(om)
     */
    public operator func ==(om: Money): Bool{
        return this.equals(om)
    }

    /**
     * @brief      相对于this.greaterThan(om)
     */
    public operator func >(om: Money): Bool{
        return this.greaterThan(om)
    }

    /**
     * @brief      相对于this.greaterThanOrEqual(om)
     */
    public operator func >=(om: Money): Bool{
        return this.greaterThanOrEqual(om)
    }

    /**
     * @brief      相对于this.lessThan(om)
     */
    public operator func <(om: Money): Bool{
        return this.lessThan(om)
    }

    /**
     * @brief      相对于this.lessThanOrEqual(om)
     */
    public operator func <=(om: Money): Bool{
        return this.lessThanOrEqual(om)
    }
}
