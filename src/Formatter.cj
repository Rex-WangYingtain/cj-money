package cj_money

import std.math.abs
import std.math.pow
import std.math.numeric.*

/**
 * @brief      Formatter类将Money和BigMoney按照ISO 4217标准格式化为符合标准的字符串或其他
 */
public class Formatter {
    /**
     * @brief      Formatter类的构造函数
     *
     * @param      fraction   表示货币的最小单位，即货币的分或分以下单位的数量。
     * @param      decimal   表示小数点符号，用于货币金额中的小数部分分隔符。
     * @param      thousand    表示千分位符号，用于货币金额中的千位分隔符。
     * @param      grapheme   表示货币符号，即货币的图形表示，如美元的"$"、欧元的"€"等。
     * @param      template   表示货币的展示模板，定义了货币金额的显示格式。
     */
    public Formatter(
        let fraction: Int64,
        let decimal: String,
        let thousand: String,
        let grapheme: String,
        let template: String
    ) {}

    /**
     * @brief      将传入字符串直接代替Currency对象中的模板
     *
     * @param      str   字符串
     *
     * @return     转换生成的字符串
     */
    public func substitute(str: String):String {
        var ret: String = this.template.replace("1", str)
        ret = ret.replace("$", this.grapheme)
        return ret
    }

    /**
     * @brief      使用给定的货币模板返回格式化的字符串。
     *
     * @param      amount   需要转换的整型。
     *
     * @return     转换生成的字符串
     */
    public func format(amount: Int64): String {
        return this.format(amount.toString())
    }

    /**
     * @brief      使用给定的货币模板返回格式化的字符串。
     *
     * @param      amount   需要转换的BigInt。
     *
     * @return     转换生成的字符串
     */
    public func format(amount: BigInt): String {
        return this.format(amount.toString())
    }

    /**
     * @brief      使用给定的货币模板返回格式化的字符串。
     *
     * @param      amount   需要转换的String。
     *
     * @return     转换生成的字符串
     */
    private func format(amount: String): String {
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
