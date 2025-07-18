package cj_money

/**
 * @brief      在进行Money或BigMoney的二元运算或比较时，检查Currency实例是否相等，不相等将抛出此异常
 */
public class CurrencyNotSameException <: Exception {
    public init(message: String) {
        super(message)
    }
}

/**
 * @brief      不支持负指数异常，在我实现的整数幂计算函数中，还不支持负指数，如果传入，抛出异常
 */
public class NegativeExponentNotSupportException <: Exception {
    public init(message: String) {
        super(message)
    }
}
