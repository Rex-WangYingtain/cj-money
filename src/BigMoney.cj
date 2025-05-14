package cj_money

import std.math.*
import std.convert.*
import std.math.numeric.*

class BigMoney {
    public BigMoney(
        var amount: BigInt, // 钱的金额
        let currency: Currency // 钱的标准
    ) {
        /**
         * @brief      从BigInt创建并返回BigMoney的新实例。使用BigInt创建时，不是真实值转换，而是直接赋值
         *
         * @param      amount   金额
         * @param      currency   Currency对象，BigMoney的Currency标准
         */
    }

    public init(m: Money) {
        /**
         * @brief      通过Money对象创建BigMoney对象
         *
         * @param      m   Money对象
         */
        this.currency = m.currency
        this.amount = BigInt(m.amount)
    }

    public init(amount: String, currency: Currency, mode!: String = "round") {
        /**
         * @brief      从数字字符串创建BigMoney实例
         *
         * @param      amount   数字字符串，表示BigMoney实例的金额
         * @param      currency   Currency对象，BigMoney的Currency标准
         * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
         */
        this.currency = currency
        this.amount = NumberStringToBigAmount(amount, this.currency.fraction, mode: mode)
    }

    public init(amount: String, code: String, code_mode!: String = "code", mode!: String = "round") {
        /**
         * @brief      从数字字符串创建BigMoney实例
         *
         * @param      amount   数字字符串，表示BigMoney实例的金额
         * @param      code   Currency对象对应的编号
         * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
         * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
         */
        this.currency = Currency(code, mode: code_mode)
        this.amount = NumberStringToBigAmount(amount, this.currency.fraction, mode: mode)
    }

    public func toMoney() {
        /**
         * @brief      将BigMoney实例转换为Money实例并返回
         *
         * @return     返回的Money实例
         */
        return Money(this.amount.toInt64(), this.currency)
    }

    public func sameCurrency(obm: BigMoney): Bool {
        /**
         * @brief      判断BigMoney的Currency标准是否相同
         *
         * @param      obm   对比的BigMoney对象
         *
         * @return     是否相等的布尔值
         */
        return this.currency.equalsByCode(obm.currency)
    }

    public func compareAmount(obm: BigMoney): Int64 {
        /**
         * @brief      判断BigMoney的金额大小
         *
         * @param      obm   对比的BigMoney对象
         *
         * @note       要求BigMoney对象this和om的Currency标准相等
         *
         * @return     如果金额相等，返回0；被对比对象this大于对比对象obm返回1；否则返回-1
         */
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

    public func greaterThan(obm: BigMoney): Bool {
        /**
         * @brief      判断被对比对象this的金额是否大于对比对象obm的金额
         *
         * @param      obm   对比的BigMoney对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(obm) == 1
    }

    public func greaterThanOrEqual(obm: BigMoney): Bool {
        /**
         * @brief      判断被对比对象this的金额是否大于等于对比对象obm的金额
         *
         * @param      obm   对比的BigMoney对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(obm) >= 0
    }

    public func lessThan(obm: BigMoney): Bool {
        /**
         * @brief      判断被对比对象this的金额是否小于对比对象obm的金额
         *
         * @param      obm   对比的BigMoney对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(obm) == -1
    }

    public func lessThanOrEqual(obm: BigMoney): Bool {
        /**
         * @brief      判断被对比对象this的金额是否小于等于对比对象obm的金额
         *
         * @param      obm   对比的BigMoney对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(obm) <= 0
    }

    public func equals(obm: BigMoney): Bool {
        /**
         * @brief      判断两个BigMoney对象是否完全相等。包括Currency对象和金额amount
         *
         * @param      obm   对比的BigMoney对象
         *
         * @return     是否相等的布尔值
         */
        return this.compareAmount(obm) == 0
    }

    public func isZero(): Bool {
        /**
         * @brief      判断BigMoney对象的金额amount是否为0
         *
         * @return     是否为0的布尔值
         */
        return this.amount == BigInt_ZERO
    }

    public func isPositive(): Bool {
        /**
         * @brief      判断BigMoney对象的金额amount是否为正值
         *
         * @return     是否为为正值的布尔值
         */
        return this.amount > BigInt_ZERO
    }

    public func isNegative(): Bool {
        /**
         * @brief      判断BigMoney对象的金额amount是否为负值
         *
         * @return     是否为负值的布尔值
         */
        return this.amount < BigInt_ZERO
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
         * @brief      Display允许将String结构表示为给定货币值的字符串。
         *
         * @return     给定货币值的字符串
         */
        return this.currency.getFormatter().format(this.amount)
    }

    public func displayByScientificNotation(integer_len!: Int64=1, fractional_len!: Int64=2): String {
        /**
         * @brief      BigMoney展示为科学计数法，并按照标准对应的格式展示。
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
