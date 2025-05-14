package cj_money

import std.convert.*

// func Float64ToInt64Truncate(num: Float64): Int64{
//     /**
//      * @brief      将一个Float64的数精确地转为Int64，舍去小数部分
//      *
//      * @param      num   受转换的浮点数
//      *
//      * @return     得到的整型
//      */
//     var string_num: String = num.toString()

//     let _index: ?Int64 = string_num.indexOf(".")
//     if (_index.isNone()){
//         throw Exception("非法浮点数")
//     }
//     let index: Int64 = _index.getOrThrow()

//     string_num = string_num[0..index]

//     return Int64.parse(string_num)
// }

func Float64ToInt64Round(num: Float64): Int64{
    /**
     * @brief      将一个Float64的数精确地转为Int64，四舍五入
     *
     * @param      num   受转换的浮点数
     *
     * @return     得到的整型
     */
    var string_num: String = num.toString()

    let index: Int64 = match (string_num.indexOf(".")) {
        case None => throw NoneValueException("非法浮点数")     // 实际上不可能发生
        case Some(v) => v
    }

    let decimal: UInt8 = string_num[index + 1] - b'0'

    string_num = string_num[0..index]

    if (decimal < 5){
        return Int64.parse(string_num)
    }

    if (num > 0.0){
        return Int64.parse(string_num) + 1
    }

    return Int64.parse(string_num) - 1
}