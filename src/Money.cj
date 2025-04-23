package cj_money

import std.math.*
import std.convert.*
import std.math.numeric.*

class Money {
    public Money(
        var amount: Int64, // 钱的金额
        let currency: Currency // 钱的标准
    ) {
        /**
         * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
         *
         * @param      amount   金额
         * @param      currency   Currency对象
         */
    }

    public init(bm: BigMoney) {
        /**
         * @brief      从BigMoney实例创建并返回Money的新实例。
         *
         * @param      bm   BigMoney实例
         */
        this.currency = bm.currency
        this.amount = bm.amount.toInt64()
    }

    public init(amount: Int64, code: String, code_mode!: String = "code") {
        /**
         * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
         *
         * @param      amount   金额
         * @param      code   currency标准对应的code
         */
        this.currency = Currency(code, mode: code_mode)

        this.amount = amount
    }

    public init(amount: Float64, code: String, code_mode!: String = "code") {
        /**
         * @brief      从float64创建并返回Money的新实例。
         *             总是将小数四舍五入。
         *
         * @param      amount   金额
         * @param      code   currency标准对应的code
         */
        this.currency = Currency(code, mode: code_mode)
        let currencyDecimals: Float64 = pow(10.0, currency.fraction)
        let float_amount = amount * currencyDecimals
        this.amount = Float64ToInt64Round(float_amount)
    }

    public init(amount: String, code: String, code_mode!: String = "code", mode!: String = "round") {
        /**
         * @brief      从数字字符串创建Money实例
         *
         * @param      amount   数字字符串，表示Money实例的金额
         * @param      code   Currency对象对应的编号
         * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
         * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
         */
        this.currency = Currency(code, mode: code_mode)
        this.amount = NumberStringToSmallAmount(amount, this.currency.fraction, mode: mode)
    }

    public init(amount: Float64, currency: Currency) {
        /**
         * @brief      从float64创建并返回Money的新实例。
         *             总是将小数四舍五入。
         *
         * @param      amount   金额
         * @param      currency   Currency对象
         *
         * @return     是否相等的布尔值
         */
        this.currency = currency

        let currencyDecimals: Float64 = pow(10.0, currency.fraction)
        let float_amount = amount * currencyDecimals
        this.amount = Float64ToInt64Round(float_amount)
    }

    public init(amount: String, currency: Currency, mode!: String = "round") {
        /**
         * @brief      从数字字符串创建Money实例
         *
         * @param      amount   数字字符串，表示Money实例的金额
         * @param      currency   Currency对象，Money的Currency标准
         * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
         */
        this.currency = currency
        this.amount = NumberStringToSmallAmount(amount, this.currency.fraction, mode: mode)
    }

    public func toBigMoney() : BigMoney{
        /**
         * @brief      将Money实例转换为BigMoney实例并返回
         *
         * @return     返回的BigMoney实例
         */
        return BigMoney(BigInt(this.amount), this.currency)
    }

    public func sameCurrency(om: Money): Bool {
        /**
         * @brief      判断Money的Currency标准是否相同
         *
         * @param      om   对比的Money对象
         *
         * @return     是否相等的布尔值
         */
        return this.currency.equalsByCode(om.currency)
    }

    public func compareAmount(om: Money): Int64 {
        /**
         * @brief      判断Money的金额大小
         *
         * @param      om   对比的Money对象
         *
         * @note       要求Money对象this和om的Currency标准相等
         *
         * @return     如果金额相等，返回0；被对比对象this大于对比对象om返回1；否则返回-1
         */
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

    public func greaterThan(om: Money): Bool {
        /**
         * @brief      判断被对比对象this的金额是否大于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) == 1
    }

    public func greaterThanOrEqual(om: Money): Bool {
        /**
         * @brief      判断被对比对象this的金额是否大于等于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) >= 0
    }

    public func lessThan(om: Money): Bool {
        /**
         * @brief      判断被对比对象this的金额是否小于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) == -1
    }

    public func lessThanOrEqual(om: Money): Bool {
        /**
         * @brief      判断被对比对象this的金额是否小于等于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) <= 0
    }

    public func equals(om: Money): Bool {
        /**
         * @brief      判断两个Money对象是否完全相等。包括Currency对象和金额amount
         *
         * @param      om   对比的Money对象
         *
         * @return     是否相等的布尔值
         */
        return this.compareAmount(om) == 0
    }

    public func isZero(): Bool {
        /**
         * @brief      判断Money对象的金额amount是否为0
         *
         * @return     是否为0的布尔值
         */
        return this.amount == 0
    }

    public func isPositive(): Bool {
        /**
         * @brief      判断Money对象的金额amount是否为正值
         *
         * @return     是否为为正值的布尔值
         */
        return this.amount > 0
    }

    public func isNegative(): Bool {
        /**
         * @brief      判断Money对象的金额amount是否为负值
         *
         * @return     是否为负值的布尔值
         */
        return this.amount < 0
    }

    public func absolute() {
        /**
         * @brief      将金额amount属性取绝对值
         */
        this.amount = abs(this.amount)
    }

    public func negative() {
        /**
         * @brief      将金额amount属性取负
         */
        this.amount = -this.amount
    }

    public func display(): String {
        /**
         * @brief      Display允许将Money结构表示为给定货币值的字符串。
         *
         * @return     给定货币值的字符串
         */
        return this.currency.getFormatter().format(this.amount)
    }

    public func displayByScientificNotation(integer_len!: Int64 = 1, fractional_len!: Int64=2): String {
        /**
         * @brief      Money展示为科学计数法，并按照标准对应的格式展示。
         *
         * @param      integer_len      表示整数部分的长度，默认为1
         * @param      fractional_len   表示小数部分的最大长度，默认为2
         *
         * @return
         */
        let tup = ScientificNotation(this.amount.toString(), this.currency.fraction, integer_len, fractional_len)
        let str: String
        if (tup[0] == "-") {
            str = tup[0] + tup[1] + "." + tup[2] + "E" + tup[3].toString()
        } else {
            str = tup[1] + "." + tup[2] + "E" + tup[3].toString()
        }
        return this.currency.getFormatter().substitute(str)
    }
}
