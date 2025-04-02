package cj_money

import std.math.abs
import std.math.pow
import std.math.numeric.*

class Formatter {
    public Formatter(
        let fraction: Int64,
        let decimal: String,
        let thousand: String,
        let grapheme: String,
        let template: String
    ) {}

    public func format(amount: Int64): String {
        /**
         * @brief      使用给定的货币模板返回格式化的字符串。
         *
         * @param      amount   需要转换的整型。
         *
         * @return     转换生成的字符串
         */
        return this.format(amount.toString())
    }

    public func format(amount: BigInt): String {
        /**
         * @brief      使用给定的货币模板返回格式化的字符串。
         *
         * @param      amount   需要转换的BigInt。
         *
         * @return     转换生成的字符串
         */
        return this.format(amount.toString())
    }

    private func format(amount: String): String {
        /**
         * @brief      使用给定的货币模板返回格式化的字符串。
         *
         * @param      amount   需要转换的String。
         *
         * @return     转换生成的字符串
         */
        var flag: Bool = false
        var sa: String
        if (amount[0] == b'-'){
            flag = true
            sa = amount[1..amount.size]
        }else {
            sa = amount
        }

        if (sa.size <= this.fraction) {
            sa = "0" * (this.fraction - sa.size + 1) + sa
        }

        if (this.thousand != "") {
            for (i in (sa.size - this.fraction - 3)..0 : -3) {
                sa = sa[..i] + this.thousand + sa[i..]
            }
        }

        if (this.fraction > 0) {
            sa = sa[..(sa.size - this.fraction)] + this.decimal + sa[(sa.size - this.fraction)..]
        }

        sa = this.template.replace("1", sa)
        sa = sa.replace("$", this.grapheme)

        if (flag) {
            sa = "-" + sa
        }

        return sa
    }

    public func toMajorUnits(amount: Int64): Float64 {
        /**
         * @brief      返回float64，表示使用货币数据的子单元的值。
         *
         * @param      amount   需要计算的整型。
         *
         * @return     货币的值
         */
        if (this.fraction == 0) {
            return Float64(amount)
        }

        return Float64(amount) / pow(10.0, this.fraction)
    }

    public func toMajorUnits(amount: BigInt): Decimal {
        /**
         * @brief      返回Decimal，表示使用货币数据的子单元的值。
         *
         * @param      amount   需要计算的BigInt。
         *
         * @return     货币的值
         */
        if (this.fraction == 0) {
            return Decimal(amount)
        }

        return Decimal(amount) / Decimal(pow(10.0, this.fraction))
    }

    public func abs(amount: Int64): Int64 {
        /**
         * @brief      返回给定整数的绝对值。
         *
         * @param      amount   需要计算的整型。
         *
         * @return     绝对值
         */
        if (amount < 0) {
            return -amount
        }
        return amount
    }
}
