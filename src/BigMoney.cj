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
         * @param      currency   Currency标准
         */
    }

    public init(amount: String, currency: Currency) {
        /**
         * @brief      从数字字符串创建并返回BigMoney的新实例。总是将小数四舍五入。
         *
         * @param      amount   金额
         * @param      currency   Currency标准
         */
        this.currency = currency

        this.amount = BigInt(0) // TODO: 有没有更优雅的解决方案
        this.amount = this.getAmount(amount, this.currency.fraction)
    }

    public init(amount: String, code: String) {
        /**
         * @brief      从数字字符串创建并返回BigMoney的新实例。总是将小数四舍五入。
         *
         * @param      amount   金额
         * @param      code   currency标准对应的code
         *
         * @return     是否相等的布尔值
         */
        this.currency = Currency(code)

        this.amount = BigInt(0) // TODO: 有没有更优雅的解决方案
        this.amount = this.getAmount(amount, this.currency.fraction)
    }

    private func getAmount(amount: String, fraction: Int64): BigInt {
        let amount_arr: Array<String> = amount.split(".")

        if (amount_arr.size == 1 && !amount_arr[0].isEmpty()) {
            // 没有小数部分的情况
            return BigInt(amount_arr[0]) * BigInt(Int64(pow(10.0, fraction)))
        } else if (amount_arr.size == 2 && !amount_arr[0].isEmpty() && !amount_arr[1].isEmpty()) {
            var ret: BigInt = BigInt(amount_arr[0]) * BigInt(Int64(pow(10.0, fraction)))

            if (amount_arr[1].size > fraction) {
                if (fraction == 0) {
                    if (amount_arr[1][fraction] - b'0' < 5){
                        return ret
                    }
                    else {
                        return ret + BigInt(1)
                    }
                }
                if (amount_arr[1][fraction] - b'0' < 5) {
                    if (ret < BigInt(0)) {
                        // 负数，小数部分大于fraction，舍去的情况
                        return ret - BigInt(amount_arr[1][0..fraction])
                    } else {
                        // 正数，小数部分大于fraction，舍去的情况
                        return ret + BigInt(amount_arr[1][0..fraction])
                    }
                } else {
                    if (ret < BigInt(0)) {
                        // 负数，小数部分大于fraction，舍入的情况
                        return ret - BigInt(amount_arr[1][0..fraction]) - BigInt(1)
                    } else {
                        // 正数，小数部分大于fraction，舍入的情况
                        return ret + BigInt(amount_arr[1][0..fraction]) + BigInt(1)
                    }
                }
            } else {
                if (ret < BigInt(0)) {
                    // 负数，小数部分小于fraction的情况
                    return ret - BigInt(amount_arr[1]) * BigInt(Int64(pow(10.0, fraction - amount_arr[1].size)))
                } else {
                    // 正数，小数部分小于fraction的情况
                    return ret + BigInt(amount_arr[1]) * BigInt(Int64(pow(10.0, fraction - amount_arr[1].size)))
                }
            }
        } else {
            throw IllegalArgumentException("非法数字字符串")
        }
    }

    public func sameCurrency(obm: BigMoney): Bool {
        /**
         * @brief      判断BigMoney的Currency标准是否相同
         *
         * @param      om   对比的Money对象
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
         * @brief      判断Money对象的金额amount是否为0
         *
         * @return     是否为0的布尔值
         */
        return this.amount == BigInt(0)
    }

    public func isPositive(): Bool {
        /**
         * @brief      判断Money对象的金额amount是否为正值
         *
         * @return     是否为为正值的布尔值
         */
        return this.amount > BigInt(0)
    }

    public func isNegative(): Bool {
        /**
         * @brief      判断Money对象的金额amount是否为负值
         *
         * @return     是否为负值的布尔值
         */
        return this.amount < BigInt(0)
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

    public func asMajorUnits(): Decimal {
        /**
         * @brief      AsMajorUnits允许将Money结构表示为给定货币值的子单元（float64）
         *
         * @return     给定货币值的子单元（float64）
         */
        return this.currency.getFormatter().toMajorUnits(this.amount)
    }
}
