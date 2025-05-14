package cj_money

import std.convert.*
import std.math.numeric.*
import std.collection.*
import std.math.*


func StringAll(str: String, char: UInt8) {
    /**
     * @brief      判断str中的字符是否都是char
     *
     * @param      str   受判断的String
     * @param      char   判断的字符
     *
     * @return     是否都是的布尔值
     */
    for(tmp in str) {
        if (tmp != char) {
            return false
        }
    }
    return true
}

func isDigit(char: UInt8): Bool {
    /**
     * @brief      判断一个ASCII字符是否是数字字符
     *
     * @param      char   判断的字符
     *
     * @return     是否都是的布尔值
     */
    if (char >= b'0' && char <= b'9') {
        return true
    }
    return false
}

func Float64ToInt64Round(num: Float64): Int64 {
    /**
     * @brief      将一个Float64的数精确地转为Int64，四舍五入
     *
     * @param      num   受转换的浮点数
     *
     * @return     得到的整型
     */
    var string_num: String = num.toString()

    let index: Int64 = string_num.indexOf(".").getOrThrow() // 不可能找不到

    let decimal: UInt8 = string_num[index + 1] - b'0'

    string_num = string_num[0..index]

    if (decimal < 5) {
        return Int64.parse(string_num)
    }

    if (num > 0.0) {
        return Int64.parse(string_num) + 1
    }

    return Int64.parse(string_num) - 1
}

func FSMNumberString(number_string: String) {
    /**
     * @brief      有限状态机，解析一个数字字符串
     *
     * @param      number_string   数字字符串
     *
     * @return     一个元组。第一元素表示符号，类型是字符串，有"+"和"-"两种情况；
     *                      第二元素表示整数部分，类型是字符串；
     *                      第三元素表示小数部分，类型是字符串；
     *                      第四元素表示指数部分的符号，类型是字符串，有"+"和"-"两种情况；
     *                      第五元素表示指数部分，类型是字符串。
     */
    var current_state: String = "start"
    var sign: UInt8 = b'+'
    let integer: ArrayList<UInt8> = ArrayList<UInt8>()
    let fractional: ArrayList<UInt8> = ArrayList<UInt8>()
    var exp_sign: UInt8 = b'+'
    let exponent: ArrayList<UInt8> = ArrayList<UInt8>()
    var has_integer: Bool = false
    var has_fraction: Bool = false

    for (char in number_string) {
        if (current_state == "start") {
            if (char == b'+' || char == b'-') {
                current_state = "sign"
                sign = char
            } else if (isDigit(char)) {
                current_state = "integer"
                integer.append(char)
                has_integer = true
            } else if (char == b'.') {
                current_state = "dot"
            } else {
                throw IllegalArgumentException("字符串开头出现非法字符。")
            }
        } else if (current_state == "sign") {
            if (isDigit(char)) {
                current_state = "integer"
                integer.append(char)
                has_integer = true
            } else if (char == b'.') {
                current_state = "dot"
            } else {
                throw IllegalArgumentException("符号后的字符串非法。")
            }
        } else if (current_state == "integer") {
            if (isDigit(char)) {
                integer.append(char)
            } else if (char == b'.') {
                current_state = "dot"
            } else if (char == b'e' || char == b'E') {
                current_state = "exp"
            } else {
                throw IllegalArgumentException("整数部分出现非法字符。")
            }
        } else if (current_state == "dot") {
            if (isDigit(char)) {
                current_state = "fraction"
                fractional.append(char)
                has_fraction = true
            } else {
                throw IllegalArgumentException("在小数点后出现非法字符。")
            }
        } else if (current_state == "fraction") {
            if (isDigit(char)) {
                fractional.append(char)
            } else if (char == b'e' || char == b'E') {
                current_state = 'exp'
            } else {
                throw IllegalArgumentException("小数部分出现非法字符。")
            }
        } else if (current_state == "exp") {
            if (char == b'+' || char == b'-') {
                current_state = "expsign"
                exp_sign = char
            } else if (isDigit(char)) {
                current_state = "exponent"
                exponent.append(char)
            } else {
                throw IllegalArgumentException("在指数标志后出现非法字符。")
            }
        } else if (current_state == "expsign") {
            if (isDigit(char)) {
                current_state = "exponent"
                exponent.append(char)
            } else {
                throw IllegalArgumentException("在指数部分符号后出现非法字符。")
            }
        } else if (current_state == "exponent") {
            if (isDigit(char)) {
                exponent.append(char)
            } else {
                throw IllegalArgumentException("在指数部分出现非法字符。")
            }
        }
    }

    if (current_state != "integer" && current_state != "fraction" && current_state != "exponent") {
        throw IllegalArgumentException("非法数字串。")
    }

    let _integer: Array<Rune> = Array<Rune>(integer.size, {x => Rune(integer[x])})
    let _fractional: Array<Rune> = Array<Rune>(fractional.size, {x => Rune(fractional[x])})
    let _exponent: Array<Rune> = Array<Rune>(exponent.size, {x => Rune(exponent[x])})

    return (sign, String(_integer), String(_fractional), exp_sign, String(_exponent))
}

func NumberStringToSmallAmount(number_string: String, fraction: Int64, mode!: String = "round"): Int64 {
    /**
     * @brief      将一个数字字符串转换为定点小数的整数表示。
     *
     * @param      number_string   数字字符串
     * @param      fraction   定点小数的位数
     * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     *
     * @return     定点小数的整数表示，类型是Int64
     */
    let tuple = FSMNumberString(number_string)
    let sign = tuple[0]
    let integer = tuple[1]
    let fractional = tuple[2]
    let exp_sign = tuple[3]
    let exponent = tuple[4]

    let integer_len = integer.size
    let fractional_len = fractional.size

    var exponent_val = 0
    if (exponent != ""){
        exponent_val = Int64.parse(exponent)
        if (exp_sign == b'-'){
            exponent_val = -exponent_val
        }
    }

    var current_point = integer_len + exponent_val + fraction

    if (mode == "truncate") {
        if (current_point > 0) {
            let string_num = integer + fractional
            if (current_point > integer_len + fractional_len) {
                if (sign == b'+'){
                    return Int64.parse(string_num) * Int64(pow(10.0, current_point - integer_len - fractional_len))
                } else {
                    return -Int64.parse(string_num) * Int64(pow(10.0, current_point - integer_len - fractional_len))
                }
            } else {
                if (sign == b'+'){
                    return Int64.parse(string_num[0..current_point])
                } else {
                    return -Int64.parse(string_num[0..current_point])
                }
            }
        } else {
            return 0
        }
    } else if (mode == "ceil") {
        var string_num: String = integer + fractional

        if (current_point > 0) {
            if (current_point > integer_len + fractional_len) {
                if (sign == b'+'){
                    return Int64.parse(string_num) * Int64(pow(10.0, current_point - integer_len - fractional_len))
                } else {
                    return -Int64.parse(string_num) * Int64(pow(10.0, current_point - integer_len - fractional_len))
                }
            } else {
                string_num = string_num[0..current_point]
                var ret: Int64 = Int64.parse(string_num[0..current_point])
                if (sign == b'-') {
                    ret = - ret
                }
                if (StringAll(string_num, b'0')){
                    return ret
                }
                return ret + 1
            }
        } else {
            if (StringAll(string_num, b'0')){
                return 0
            }
            else {
                return 1
            }
        }
    } else if (mode == "round") {
        var string_num: String = integer + fractional
        if (current_point > 0) {
            if (current_point > integer_len + fractional_len) {
                if (sign == b'+'){
                    return Int64.parse(string_num) * Int64(pow(10.0, current_point - integer_len - fractional_len))
                } else {
                    return -Int64.parse(string_num) * Int64(pow(10.0, current_point - integer_len - fractional_len))
                }
            } else {
                let remain: String = string_num[current_point..]
                string_num = string_num[0..current_point]
                var ret: Int64 = Int64.parse(string_num[0..current_point])

                if (remain.size > 0 && remain[0] > b'4'){
                    ret += 1
                }

                if (sign == b'-') {
                    ret = - ret
                }
                return ret
            }
        } else {
            if (current_point == 0 && string_num[0] > b'4'){
                if (sign == b'-'){
                    println(-1)
                    return -1
                } else {
                    println(1)
                    return 1
                }
            }
            return 0
        }
    } else {
        throw IllegalArgumentException("没有舍入模式" + mode)
    }
}

func NumberStringToBigAmount(number_string: String, fraction: Int64, mode!: String = "round"): BigInt {
    /**
     * @brief      将一个数字字符串转换为定点小数的整数表示。
     *
     * @param      number_string   数字字符串
     * @param      fraction   定点小数的位数
     * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     *
     * @return     定点小数的整数表示，类型是BigInt
     */
    let tuple = FSMNumberString(number_string)
    let sign = tuple[0]
    let integer = tuple[1]
    let fractional = tuple[2]
    let exp_sign = tuple[3]
    let exponent = tuple[4]

    let integer_len = integer.size
    let fractional_len = fractional.size

    var exponent_val = 0
    if (exponent != ""){
        exponent_val = Int64.parse(exponent)
        if (exp_sign == b'-'){
            exponent_val = -exponent_val
        }
    }

    var current_point = integer_len + exponent_val + fraction

    if (mode == "truncate") {
        if (current_point > 0) {
            let string_num = integer + fractional
            if (current_point > integer_len + fractional_len) {
                if (sign == b'+'){
                    return BigInt(string_num) * BigInt(Int64(pow(10.0, current_point - integer_len - fractional_len)))
                } else {
                    return -BigInt(string_num) * BigInt(Int64(pow(10.0, current_point - integer_len - fractional_len)))
                }
            } else {
                if (sign == b'+'){
                    return BigInt(string_num[0..current_point])
                } else {
                    return -BigInt(string_num[0..current_point])
                }
            }
        } else {
            return BigInt_ZERO
        }
    } else if (mode == "ceil") {
        var string_num: String = integer + fractional

        if (current_point > 0) {
            if (current_point > integer_len + fractional_len) {
                if (sign == b'+'){
                    return BigInt(string_num) * BigInt(Int64(pow(10.0, current_point - integer_len - fractional_len)))
                } else {
                    return -BigInt(string_num) * BigInt(Int64(pow(10.0, current_point - integer_len - fractional_len)))
                }
            } else {
                string_num = string_num[0..current_point]
                var ret: BigInt = BigInt(string_num[0..current_point])
                if (sign == b'-') {
                    ret = - ret
                }
                if (StringAll(string_num, b'0')){
                    return ret
                }
                return ret + BigInt_ONE
            }
        } else {
            if (StringAll(string_num, b'0')){
                return BigInt_ZERO
            }
            else {
                return BigInt_ONE
            }
        }
    } else if (mode == "round") {
        var string_num: String = integer + fractional

        if (current_point > 0) {
            if (current_point > integer_len + fractional_len) {
                if (sign == b'+'){
                    return BigInt(string_num) * BigInt(Int64(pow(10.0, current_point - integer_len - fractional_len)))
                } else {
                    return -BigInt(string_num) * BigInt(Int64(pow(10.0, current_point - integer_len - fractional_len)))
                }
            } else {
                let remain: String = string_num[current_point..]
                string_num = string_num[0..current_point]
                var ret: BigInt = BigInt(string_num[0..current_point])

                if (remain.size > 0 && remain[0] > b'4'){
                    ret += BigInt_ONE
                }

                if (sign == b'-') {
                    ret = - ret
                }
                return ret
            }
        } else {
            if (current_point == 0 && string_num[0] > b'4'){
                if (sign == b'-'){
                    return BigInt_MINUS_ONE
                } else {
                    return BigInt_ONE
                }
            }
            return BigInt_ZERO
        }
    } else {
        throw IllegalArgumentException("没有舍入模式" + mode)
    }
}

func ScientificNotation(amount: String, fraction: Int64, integer_len: Int64, fractional_len: Int64) {
    /**
     * @brief      将一个数字字符串转换为科学计数法表示的信息元组
     *
     * @param      amount   数字字符串的整数部分
     * @param      fraction   数字字符串的小数位数
     * @param      integer_len   整数部分的长度
     * @param      fractional_len   小数部分的最大长度
     *
     * @return     一个元组。第一元素表示符号，类型是字符串，有"+"和"-"两种情况；
     *                      第二元素表示整数部分，类型是字符串；
     *                      第三元素表示小数部分，类型是字符串；
     *                      第四元素表示指数部分，类型是Int64。
     */
    let signal: String
    var positive_amount: String
    if (amount[0] == b'-') {
        signal = "-"
        positive_amount = amount[1..]
    } else {
        signal = "+"
        positive_amount = amount
    }

    // 构造整数部分和小数部分
    var integer_part: String
    var fractional_part: String
    if (positive_amount.size > fraction) {
        integer_part = positive_amount[0..(positive_amount.size - fraction)]
        fractional_part = positive_amount[(positive_amount.size - fraction)..]
    } else {
        integer_part = "0"
        fractional_part = "0" * (fraction - positive_amount.size) + positive_amount
    }

    let merged_str = integer_part + fractional_part
    let original_point = integer_part.size

    // 找到第一个非零字符的位置
    var first_non_zero = -1
    for (index in 0..merged_str.size) {
        if (merged_str[index] != b'0') {
            first_non_zero = index
            break
        }
    }

    // 处理全零的情况
    if (first_non_zero == -1) {
        return ("+", "0", "", 0)
    }

    var fractional_str: String
    var integer_str: String
    let exponent: Int64
    if (integer_len > 0) {
        // 计算新的小数点的位置
        let new_point = first_non_zero + integer_len
        let start = first_non_zero
        let end = start + integer_len

        // 提取整数部分并补零
        integer_str = merged_str[start..min(end, merged_str.size)]

        if (integer_str.size < integer_len) {
            integer_str += "0" * (integer_len - integer_str.size)
        }

        // 剩余部分作为小数部分
        fractional_str = merged_str[min(end, merged_str.size)..]

        // 计算指数
        exponent = original_point - new_point
    } else {
        // 整数部分为0的特殊处理
        let new_point = first_non_zero
        integer_str = "0"
        fractional_str = merged_str[new_point..]
        exponent = original_point - new_point
    }
    // 截断小数部分到指定长度
    fractional_str = fractional_str[..min(fractional_len, fractional_str.size)]
    return (signal, integer_str, fractional_str, exponent)
}