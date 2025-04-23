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

    public func substitute(str: String):String {
        /**
         * @brief      将传入字符串直接代替Currency对象中的模板
         *
         * @param      str   字符串
         *
         * @return     转换生成的字符串
         */
        var ret: String = this.template.replace("1", str)
        ret = ret.replace("$", this.grapheme)
        return ret
    }

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
}
