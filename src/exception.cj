package cj_money


open class CurrencyNotSameException <: Exception {
    public init(message: String) {
        super(message)
    }
    public open override func getClassName(): String {
        "CurrencyNotSameException"
    }
}
