package cj_money

import std.math.*

import std.convert.*

class Money {
    var amount: Int64       // 钱的金额
    let currency: Currency  // 钱的标准

    public init(amount: Int64, code: String) {
        /**
         * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
         *
         * @param      amount   金额
         * @param      code   currency标准对应的code
         *
         * @return     是否相等的布尔值
         */
        
        this.currency = Currency(code)

        this.amount = amount
    }

    public init(amount: Float64, code: String) {
        /**
         * @brief      从float64创建并返回Money的新实例。
         *             总是将小数四舍五入。
         *
         * @param      amount   金额
         * @param      code   currency标准对应的code
         *
         * @return     是否相等的布尔值
         */
        this.currency = Currency(code)
        let currencyDecimals: Float64 = pow(10.0, currency.fraction)
        let float_amount = amount * currencyDecimals
        this.amount = Float64ToInt64Round(float_amount)
    }

    public init(amount: Int64, currency: Currency) {
        /**
         * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
         *
         * @param      amount   金额
         * @param      currency   Currency对象
         *
         * @return     是否相等的布尔值
         */
        this.currency = currency
        this.amount = amount
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
        if (!this.sameCurrency(om)){
            throw CurrencyNotSameException("this的Currency的code为${this.currency.code}，om的Currency的code为${om.currency.code}")
        }
        if (this.amount > om.amount) {
            return 1
        } else if (this.amount < om.amount) {
            return -1
        }
        return 0
    }

    public func greaterThan(om: Money): Bool{
        /**
         * @brief      判断被对比对象this的金额是否大于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) == 1
    }

    public func greaterThanOrEqual(om: Money): Bool{
        /**
         * @brief      判断被对比对象this的金额是否大于等于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) >= 0
    }

    public func lessThan(om: Money): Bool{
        /**
         * @brief      判断被对比对象this的金额是否小于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) == -1
    }

    public func lessThanOrEqual(om: Money): Bool{
        /**
         * @brief      判断被对比对象this的金额是否小于等于对比对象om的金额
         *
         * @param      om   对比的Money对象
         *
         * @return     判断的布尔值
         */
        return this.compareAmount(om) <= 0
    }

    public func equals(om: Money):Bool{
        /**
         * @brief      判断两个Money对象是否完全相等。包括Currency对象和金额amount
         *
         * @param      om   对比的Money对象
         *
         * @return     是否相等的布尔值
         */
        return this.compareAmount(om) == 0
    }

    public func isZero(): Bool{
        /**
         * @brief      判断Money对象的金额amount是否为0
         *
         * @return     是否为0的布尔值
         */
        return this.amount == 0
    }

    public func isPositive():Bool{
        /**
         * @brief      判断Money对象的金额amount是否为正值
         *
         * @return     是否为为正值的布尔值
         */
        return this.amount > 0
    }

    public func isNegative(): Bool{
        /**
         * @brief      判断Money对象的金额amount是否为负值
         *
         * @return     是否为负值的布尔值
         */
        return this.amount < 0
    }

    public func absolute(){
        /**
         * @brief      将金额amount属性取绝对值
         */
        this.amount = abs(this.amount)
    }

    public func negative(){
        /**
         * @brief      将金额amount属性取负
         */
        this.amount = -this.amount
    }

    public func display():String{
        /**
         * @brief      Display允许将Money结构表示为给定货币值的字符串。
         *
         * @return     给定货币值的字符串
         */
        return this.currency.getFormatter().format(this.amount)
    }

    public func asMajorUnits(): Float64{
        /**
         * @brief      AsMajorUnits允许将Money结构表示为给定货币值的子单元（float64）
         *
         * @return     给定货币值的子单元（float64）
         */
        return this.currency.getFormatter().toMajorUnits(this.amount)
    }
}
