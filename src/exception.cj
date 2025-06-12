package cj_money

/**
 * @brief      在进行Money或BigMoney的二元运算或比较时，检查Currency实例是否相等，不相等将抛出此异常
 */
open class CurrencyNotSameException <: Exception {
    public init(message: String) {
        super(message)
    }
}
