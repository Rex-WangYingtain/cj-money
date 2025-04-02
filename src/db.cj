package cj_money

import std.math.numeric.*
import std.convert.*

// 这个模块主要实现对Money对象的序列化和反序列化，方便数据库操作
/*
序列化
例如：
金额100美分 + 货币USD -> "100|USD"
反序列化
例如：
"100|USD" -> 金额100美分 + 货币USD
*/

// 建议使用的分隔字符串，可以避免混淆
const DefaultDBMoneyValueSeparator: String = "|"

func serializeByCode(m: Money, separator!: String=DefaultDBMoneyValueSeparator): String{
    /**
     * @brief      将Money对象序列化为字符串。包含金额和Currency的code两项信息
     *
     * @param      m    序列化的Money对象
     * @param      separator    分隔符
     *
     * @return     序列化生成的字符串
     */
    return m.amount.toString() + separator + m.currency.code
}

func serializeByCode(m: BigMoney, separator!: String=DefaultDBMoneyValueSeparator): String{
    /**
     * @brief      将BigMoney对象序列化为字符串。包含金额和Currency的code两项信息
     *
     * @param      m    序列化的Money对象
     * @param      separator    分隔符
     *
     * @return     序列化生成的字符串
     */
    return m.amount.toString() + separator + m.currency.code
}

func deserializeByCode(st: String,  separator!: String=DefaultDBMoneyValueSeparator): Money{
    /**
     * @brief      将 amount|code 字符串反序列化为Money对象
     *
     * @param      st    反序列化的字符串
     * @param      separator    分隔符
     *
     * @return     反序列化生成的Money对象
     */
    let st_array : Array<String> = st.split(separator)
    if (st_array.size != 2){
        throw IllegalFormatException("无法用分隔符 " + separator + " 正确地划分Money序列")
    }

    return Money(Int64.parse(st_array[0]), st_array[1])
}

func deserializeBigMoneyByCode(st: String,  separator!: String=DefaultDBMoneyValueSeparator): BigMoney{
    /**
     * @brief      将 amount|code 字符串反序列化为BigMoney对象
     *
     * @param      st    反序列化的字符串
     * @param      separator    分隔符
     *
     * @return     反序列化生成的BigMoney对象
     */
    let st_array : Array<String> = st.split(separator)
    if (st_array.size != 2){
        throw IllegalFormatException("无法用分隔符 " + separator + " 正确地划分Money序列")
    }

    let currency: Currency = Currency(st_array[1])

    return BigMoney(BigInt(st_array[0]), currency)
}

func serializeAll(m: Money, separator!: String=DefaultDBMoneyValueSeparator): String{
    /**
     * @brief      将Money对象序列化为字符串。包含金额和Currency的全部信息
     *
     * @param      m    序列化的Money对象
     * @param      separator    分隔符
     *
     * @return     序列化生成的字符串 amount|code|numericCode|fraction|grapheme|template|decimal|thousand
     */
    return m.amount.toString() + separator + m.currency.code + separator + m.currency.numericCode + separator + "${m.currency.fraction}" + separator + m.currency.grapheme + separator + m.currency.template + separator + m.currency.decimal + separator + m.currency.thousand
}

func serializeAll(m: BigMoney, separator!: String=DefaultDBMoneyValueSeparator): String{
    /**
     * @brief      将BigMoney对象序列化为字符串。包含金额和Currency的全部信息
     *
     * @param      m    序列化的Money对象
     * @param      separator    分隔符
     *
     * @return     序列化生成的字符串 amount|code|numericCode|fraction|grapheme|template|decimal|thousand
     */
    return m.amount.toString() + separator + m.currency.code + separator + m.currency.numericCode + separator + "${m.currency.fraction}" + separator + m.currency.grapheme + separator + m.currency.template + separator + m.currency.decimal + separator + m.currency.thousand
}

func deserializeAll(st: String,  separator!: String=DefaultDBMoneyValueSeparator): Money{
    /**
     * @brief      将 amount|code|numericCode|fraction|grapheme|template|decimal|thousand 字符串反序列化为Money对象
     *
     * @param      st    反序列化的字符串
     * @param      separator    分隔符
     *
     * @return     反序列化生成的Money对象
     */
    let st_array : Array<String> = st.split(separator)
    if (st_array.size != 8){
        throw IllegalFormatException("无法用分隔符 " + separator + " 正确地划分Money序列")
    }
    let currency = Currency(st_array[6], st_array[7], st_array[1], Int64.parse(st_array[3]), st_array[2], st_array[4], st_array[5])
    return Money(Int64.parse(st_array[0]), currency)
}

func deserializeBigMoneyAll(st: String,  separator!: String=DefaultDBMoneyValueSeparator): BigMoney{
    /**
     * @brief      将 amount|code|numericCode|fraction|grapheme|template|decimal|thousand 字符串反序列化为BigMone对象
     *
     * @param      st    反序列化的字符串
     * @param      separator    分隔符
     *
     * @return     反序列化生成的BigMoney对象
     */
    let st_array : Array<String> = st.split(separator)
    
    if (st_array.size != 8){
        throw IllegalFormatException("无法用分隔符 " + separator + " 正确地划分Money序列")
    }
    let currency = Currency(st_array[6], st_array[7], st_array[1], Int64.parse(st_array[3]), st_array[2], st_array[4], st_array[5])
    return BigMoney(BigInt(st_array[0]), currency)
}
