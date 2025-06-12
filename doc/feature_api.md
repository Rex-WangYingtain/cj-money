# cj-money

## 介绍
`cj-money`是一个用于解决金融计算领域浮点数误差的库。

项目通过模拟定点数的计算来避免金融计算的浮点误差问题，支持了加、减、乘、除、取模、取相反数、取绝对值、舍入、分配等运算；同时还提供了格式化输入输出的函数；提供了序列化和反序列化的函数；还提供了对大数和小数的支持让开发者平衡计算范围和性能。



## 1. 主要类型说明

### 1.1 Currency结构体
`Currency`存储了一种货币的`ISO 4217`标准的部分信息。这些信息用于进行货币的格式化展示以及限制小数保留的位数。

```cangjie
struct Currency {
    /**
     * @brief      原子数据类型创建Currency对象
     * @param      decimal   表示小数点符号，用于货币金额中的小数部分分隔符。
     * @param      thousand    表示千分位符号，用于货币金额中的千位分隔符。
     * @param      code   表示货币的ISO代码，根据ISO 4217标准定义的三位字母代码。
     * @param      fraction   表示货币的最小单位，即货币的分或分以下单位的数量。
     * @param      numericCode   表示货币的数字代码，根据ISO 4217标准定义的三位数字代码。
     * @param      grapheme   表示货币符号，即货币的图形表示，如美元的"$"、欧元的"€"等。
     * @param      template   表示货币的展示模板，定义了货币金额的显示格式。
     */
    public Currency(
        let decimal: String,
        let thousand: String,
        let code: String,
        let fraction: Int64,
        let numericCode: String,
        let grapheme: String,
        let template: String
    )

    /**
     * @brief      通过货币的字母代码或者数字代码创建Currency对象
     * @param      code   Currency对象对应的代号
     * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
     */
    public init(code: String, mode!: String = "code")

    /**
     * @brief      格式化程序返回货币格式化程序表示
     * @return     这个Currency对应的Formatter对象
     */
    public func getFormatter(): Formatter
    
    /**
     * @brief      根据唯一标识符code判断两个Currency对象是否相等
     * @param      oc   相对比的Currency对象
     * @return     是否相等的布尔值
     */
    public func equalsByCode(oc: Currency): Bool
}
```



### 1.2 Currencies类

`Currencies`类硬编码存储了`ISO 4217`标准中所有货币对应的Currency结构体，出于性能和一致性的考虑，这个类被设计为单例模式。

```cangjie
class Currencies {
    private static var instance: Option<Currencies> = None
    let currencies: HashMap<String, Currency>
    /**
     * @brief      获取Currencies对象
     * @return     获取的Currencies对象
     */
    public static func getCurrencies(): Currencies
    
    /**
     * @brief      根据ISO-4271中定义的数字代码，CurrencyByNumericCode返回货币。
     * @param      numericCode   供检索的numericCode
     * @return     numericCode对应的Currency对象
     */
    public func currencyByNumericCode(numericCode: String): ?Currency

    /**
     * @brief      返回给定货币代码的货币。
     * @param      code   供检索的货币代码
     * @return     code对应的Currency对象
     */
    public func currencyByCode(code: String): ?Currency

    /**
     * @brief      这里硬编码了ISO 4217标准
     */
    private Currencies()
}

```



### 1.3 Formatter类

`Formatter`类将`Money`和`BigMoney`按照`ISO 4217`标准格式化为符合标准的字符串或其他表示形式。

```
class Formatter {
    /**
     * @brief      Formatter类的构造函数
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
    )

    /**
     * @brief      将传入字符串直接代替Currency对象中的模板
     * @param      str   字符串
     * @return     转换生成的字符串
     */
    public func substitute(str: String): String 

    /**
     * @brief      使用给定的货币模板返回格式化的字符串。
     * @param      amount   需要转换的整型。
     * @return     转换生成的字符串
     */
    public func format(amount: Int64): String
    
    /**
     * @brief      使用给定的货币模板返回格式化的字符串。
     * @param      amount   需要转换的BigInt。
     * @return     转换生成的字符串
     */
    public func format(amount: BigInt): String

    /**
     * @brief      使用给定的货币模板返回格式化的字符串。
     * @param      amount   需要转换的String。
     * @return     转换生成的字符串
     */
    private func format(amount: String): String
}

```



### 1.4 Money类

`Money`类用`Int64`类型来模拟定点数，相对于`BigMoney`类使用`BigInt`类型，表示范围受限，但理论上性能更快。

```cangjie
class Money {
    /**
     * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
     * @param      amount   金额
     * @param      currency   Currency对象
     */
    public Money(
        var amount: Int64,
        let currency: Currency
    )

    /**
     * @brief      从BigMoney实例创建并返回Money的新实例。
     * @param      bm   BigMoney实例
     */
    public init(bm: BigMoney)

    /**
     * @brief      从Int64创建并返回Money的新实例。使用整数创建时，不是真实值转换，而是直接赋值
     * @param      amount   金额
     * @param      code   currency标准对应的code
     */
    public init(amount: Int64, code: String, code_mode!: String = "code")

    /**
     * @brief      从float64创建并返回Money的新实例。总是将小数四舍五入。
     * @param      amount   金额
     * @param      code   currency标准对应的code
     */
    public init(amount: Float64, code: String, code_mode!: String = "code")

    /**
     * @brief      从数字字符串创建Money实例
     * @param      amount   数字字符串，表示Money实例的金额
     * @param      code   Currency对象对应的编号
     * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, code: String, code_mode!: String = "code", mode!: String = "round")

    /**
     * @brief      从float64创建并返回Money的新实例。总是将小数四舍五入。
     * @param      amount   金额
     * @param      currency   Currency对象
     * @return     是否相等的布尔值
     */
    public init(amount: Float64, currency: Currency)

    /**
     * @brief      从数字字符串创建Money实例
     * @param      amount   数字字符串，表示Money实例的金额
     * @param      currency   Currency对象，Money的Currency标准
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, currency: Currency, mode!: String = "round")

    /**
     * @brief      将Money实例转换为BigMoney实例并返回
     * @return     返回的BigMoney实例
     */
    public func toBigMoney() : BigMoney

    /**
     * @brief      判断Money的Currency标准是否相同
     * @param      om   对比的Money对象
     * @return     是否相等的布尔值
     */
    public func sameCurrency(om: Money): Bool

    /**
     * @brief      判断Money的金额大小
     * @param      om   对比的Money对象
     * @note       要求Money对象this和om的Currency标准相等
     * @return     如果金额相等，返回0；被对比对象this大于对比对象om返回1；否则返回-1
     */
    public func compareAmount(om: Money): Int64

    /**
     * @brief      判断被对比对象this的金额是否大于对比对象om的金额
     * @param      om   对比的Money对象
     * @return     判断的布尔值
     */
    public func greaterThan(om: Money): Bool

    /**
     * @brief      判断被对比对象this的金额是否大于等于对比对象om的金额
     * @param      om   对比的Money对象
     * @return     判断的布尔值
     */
    public func greaterThanOrEqual(om: Money): Bool

    /**
     * @brief      判断被对比对象this的金额是否小于对比对象om的金额
     * @param      om   对比的Money对象
     * @return     判断的布尔值
     */
    public func lessThan(om: Money): Bool

    /**
     * @brief      判断被对比对象this的金额是否小于等于对比对象om的金额
     * @param      om   对比的Money对象
     * @return     判断的布尔值
     */
    public func lessThanOrEqual(om: Money): Bool

    /**
     * @brief      判断两个Money对象是否完全相等。包括Currency对象和金额amount
     * @param      om   对比的Money对象
     * @return     是否相等的布尔值
     */
    public func equals(om: Money): Bool

    /**
     * @brief      判断Money对象的金额amount是否为0
     * @return     是否为0的布尔值
     */
    public func isZero(): Bool

    /**
     * @brief      判断Money对象的金额amount是否为正值
     * @return     是否为为正值的布尔值
     */
    public func isPositive(): Bool

    /**
     * @brief      判断Money对象的金额amount是否为负值
     * @return     是否为负值的布尔值
     */
    public func isNegative(): Bool

    /**
     * @brief      将金额amount属性取绝对值
     */
    public func absolute()

    /**
     * @brief      将金额amount属性取负
     */
    public func negative()

    /**
     * @brief      Display允许将Money结构表示为给定货币值的字符串。
     * @return     给定货币值的字符串
     */
    public func display(): String 
    
    /**
     * @brief      Money展示为科学计数法，并按照标准对应的格式展示。
     * @param      integer_len      表示整数部分的长度，默认为1
     * @param      fractional_len   表示小数部分的最大长度，默认为2
     * @return     科学计数法字符串
     */
    public func displayByScientificNotation(integer_len!: Int64 = 1, fractional_len!: Int64=2): String 

    // 下面是操作符重载

    /**
     * @brief      相当于calculate(this: Money, right: Money, add)
     */
    public operator func +(right: Money): Money

    /**
     * @brief      相当于calculate(this: Money, right: Money, subtract)
     */
    public operator func -(right: Money): Money

    /**
     * @brief      相当于calculate(this: Money, right: Money, modulus)
     */
    public operator func %(right: Money): Money

    /**
     * @brief      相当于calculate(this: Money, right: Money, multiply, "round")
     */
    public operator func *(right: Money): Money

    /**
     * @brief      相当于calculate(this: Money, right: Money, divide, "round")
     */
    public operator func /(right: Money): Money

    /**
     * @brief      相当于calculate(this: Money, negative)
     */
    public operator func -(): Money
    
    /**
     * @brief      相对于this.equals(om)
     */
    public operator func ==(om: Money): Bool

    /**
     * @brief      相对于this.greaterThan(om)
     */
    public operator func >(om: Money): Bool

    /**
     * @brief      相对于this.greaterThanOrEqual(om)
     */
    public operator func >=(om: Money): Bool

    /**
     * @brief      相对于this.lessThan(om)
     */
    public operator func <(om: Money): Bool

    /**
     * @brief      相对于this.lessThanOrEqual(om)
     */
    public operator func <=(om: Money): Bool
}

```



### 1.5 BigMoney类

`BigMoney`类用`BigInt`类型来模拟定点数，可以支持大数运算。

```cangjie
class BigMoney {
    /**
     * @brief      从BigInt创建并返回BigMoney的新实例。使用BigInt创建时，不是真实值转换，而是直接赋值
     * @param      amount   金额
     * @param      currency   Currency对象，BigMoney的Currency标准
     */
    public BigMoney(
        var amount: BigInt,
        let currency: Currency
    )

    /**
     * @brief      通过Money对象创建BigMoney对象
     * @param      m   Money对象
     */
    public init(m: Money)

    /**
     * @brief      从数字字符串创建BigMoney实例
     * @param      amount   数字字符串，表示BigMoney实例的金额
     * @param      currency   Currency对象，BigMoney的Currency标准
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, currency: Currency, mode!: String = "round")

    /**
     * @brief      从数字字符串创建BigMoney实例
     * @param      amount   数字字符串，表示BigMoney实例的金额
     * @param      code   Currency对象对应的编号
     * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
     * @param      mode   舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
     */
    public init(amount: String, code: String, code_mode!: String = "code", mode!: String = "round")
    
    /**
     * @brief      将BigMoney实例转换为Money实例并返回
     * @return     返回的Money实例
     */
    public func toMoney()

    /**
     * @brief      判断BigMoney的Currency标准是否相同
     * @param      obm   对比的BigMoney对象
     * @return     是否相等的布尔值
     */
    public func sameCurrency(obm: BigMoney): Bool

    /**
     * @brief      判断BigMoney的金额大小
     * @param      obm   对比的BigMoney对象
     * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
     * @return     如果金额相等，返回0；被对比对象this大于对比对象obm返回1；否则返回-1
     */
    public func compareAmount(obm: BigMoney): Int64

    /**
     * @brief      判断被对比对象this的金额是否大于对比对象obm的金额
     * @param      obm   对比的BigMoney对象
     * @return     判断的布尔值
     */
    public func greaterThan(obm: BigMoney): Bool

    /**
     * @brief      判断被对比对象this的金额是否大于等于对比对象obm的金额
     * @param      obm   对比的BigMoney对象
     * @return     判断的布尔值
     */
    public func greaterThanOrEqual(obm: BigMoney): Bool

    /**
     * @brief      判断被对比对象this的金额是否小于对比对象obm的金额
     * @param      obm   对比的BigMoney对象
     * @return     判断的布尔值
     */
    public func lessThan(obm: BigMoney): Bool

    /**
     * @brief      判断被对比对象this的金额是否小于等于对比对象obm的金额
     * @param      obm   对比的BigMoney对象
     * @return     判断的布尔值
     */
    public func lessThanOrEqual(obm: BigMoney): Bool

    /**
     * @brief      判断两个BigMoney对象是否完全相等。包括Currency对象和金额amount
     * @param      obm   对比的BigMoney对象
     * @return     是否相等的布尔值
     */
    public func equals(obm: BigMoney): Bool

    /**
     * @brief      判断BigMoney对象的金额amount是否为0
     * @return     是否为0的布尔值
     */
    public func isZero(): Bool 

    /**
     * @brief      判断BigMoney对象的金额amount是否为正值
     * @return     是否为为正值的布尔值
     */
    public func isPositive(): Bool

    /**
     * @brief      判断BigMoney对象的金额amount是否为负值
     * @return     是否为负值的布尔值
     */
    public func isNegative(): Bool
    
    /**
     * @brief      将金额amount属性取绝对值
     */
    public func absolute()

    /**
     * @brief      将金额amount属性取负
     */
    public func negative()
    
    /**
     * @brief      Display允许将String结构表示为给定货币值的字符串。
     * @return     给定货币值的字符串
     */
    public func display(): String

    /**
     * @brief      Money展示为科学计数法，并按照标准对应的格式展示。
     * @param      integer_len      表示整数部分的长度，默认为1
     * @param      fractional_len   表示小数部分的最大长度，默认为2
     * @return     科学计数法字符串
     */
    public func displayByScientificNotation(integer_len!: Int64=1, fractional_len!: Int64=2): String

    // 下面是操作符重载

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, add)
     */
    public operator func +(right: BigMoney): BigMoney{
        return calculate(this, right, add)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, subtract)
     */
    public operator func -(right: BigMoney): BigMoney{
        return calculate(this, right, subtract)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, modulus)
     */
    public operator func %(right: BigMoney): BigMoney{
        return calculate(this, right, modulus)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, multiply, "round")
     */
    public operator func *(right: BigMoney): BigMoney{
        return calculate(this, right, multiply)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, right: BigMoney, divide, "round")
     */
    public operator func /(right: BigMoney): BigMoney{
        return calculate(this, right, divide)
    }

    /**
     * @brief      相当于calculate(this: BigMoney, negative)
     */
    public operator func -(): BigMoney{
        return calculate(this, negative)
    }

    /**
     * @brief      相对于this.equals(obm)
     */
    public operator func ==(obm: BigMoney): Bool{
        return this.equals(obm)
    }

    /**
     * @brief      相对于this.greaterThan(obm)
     */
    public operator func >(obm: BigMoney): Bool{
        return this.greaterThan(obm)
    }

    /**
     * @brief      相对于this.greaterThanOrEqual(obm)
     */
    public operator func >=(obm: BigMoney): Bool{
        return this.greaterThanOrEqual(obm)
    }

    /**
     * @brief      相对于this.lessThan(obm)
     */
    public operator func <(obm: BigMoney): Bool{
        return this.lessThan(obm)
    }

    /**
     * @brief      相对于this.lessThanOrEqual(obm)
     */
    public operator func <=(obm: BigMoney): Bool{
        return this.lessThanOrEqual(obm)
    }
}

```



## 2. 主要接口说明

### 2.1 计算接口

实现了`Money`和`BigMoney`的加、减、乘、除、取相反数、取绝对值、舍入、分配等计算。这些函数写在了`Calculator.cj`这个文件里面。

```cangjie
// ====== Money ======

/**
 * @brief      对Money类型的二元运算
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（add，subtract，modulus）
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 * @return     计算得到的Money对象
 */
func calculate(a: Money, b: Money, calculator: (Money, Money) -> Money): Money

/**
 * @brief      对Money类型的二元运算
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（multiply，divide）
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 * @return     计算得到的Money对象
 */
func calculate(a: Money, b: Money, calculator: (Money, Money, String) -> Money, mode!: String="round"): Money

/**
 * @brief      对Money类型的一元运算
 * @param      m    被操作数
 * @param      calculator    计算方法（absolute，negative）
 * @return     计算得到的Money对象
 */
func calculate(m: Money, calculator: (Money) -> Money): Money

/**
 * @brief      函数 allocate 的功能是根据比例 r/s 对Money对象的金额进行分配。
 * @param      m    被操作数
 * @param      r    取的比例
 * @param      s    划分比例
 * @note       划分比例s不能小于等于零。当需要舍入时，直接舍去超出的位数。
 * @return     计算得到的Money对象
 */
func allocate(m: Money, r: Int64, s: Int64): Money

/**
 * @brief      将一个 Money 结构体的金额按照给定的比例分配给多个接收方。除法后，剩余的金额将在各方之间进行循环分配。
 * @param      m    被操作数
 * @param      rs   一个表示分配权重的数组
 * @note       划分比例应该为大于等于0的整数。除法后，剩余的金额将在各方之间进行循环分配。
 * @return     Money对象的ArrayList
 */
func allocate(m: Money, rs: Array<Int64>): ArrayList<Money>

/**
 * @brief      函数 round 的功能是根据指定的精度 e 对Money的金额进行四舍五入操作。
 * @param      m    被操作数
 * @param      e    精度
 * @note       精度 e 为正整数。
 * @return     计算得到的Money对象
 */
func round(m: Money, e: Int64): Money

/**
 * @brief      将Money对象m的金额平均分为n份，并使用Money对象的ArrayList返回。除法后，剩余的金额将在各方之间进行循环分配。
 * @param      m    被操作数
 * @param      n    份数
 * @note       n应该为大于0的整数
 * @return     Money对象的ArrayList
 */
func split(m: Money, n: Int64): ArrayList<Money>

/**
 * @brief      对Money类型的加运算
 * @param      a    被操作数
 * @param      b    操作数
 * @return     计算得到的Money对象
 */
func add(a: Money, b: Money): Money

/**
 * @brief      对Money类型的减运算
 * @param      a    被操作数
 * @param      b    操作数
 * @return     计算得到的Money对象
 */
func subtract(a: Money, b: Money): Money

/**
 * @brief      对Money类型的乘运算
 * @param      a    被乘数
 * @param      b    乘数
 * mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @return     计算得到的Money对象
 */
func multiply(a: Money, b: Money, mode!: String="round"): Money

/**
 * @brief      对Money类型的除运算
 * @param      a    被除数
 * @param      b    除数
 * mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @return     计算得到的Money对象
 */
func divide(a: Money, b: Money, mode!: String="round"): Money

/**
 * @brief      对Money类型的取模运算。
 * @param      a    被操作数
 * @param      b    操作数
 * @return     计算得到的Money对象
 */
func modulus(a: Money, b: Money): Money

/**
 * @brief      对Money类型的取绝对值操作
 * @param      m    被操作数
 * @return     计算得到的Money对象
 */
func absolute(m: Money): Money

/**
 * @brief      对Money类型的取负数操作
 * @param      m    被操作数
 * @return     计算得到的Money对象
 */
func negative(m: Money): Money

// ====== BigMoney ======

/**
 * @brief      对BigMoney类型的二元运算
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（add，subtract，modulus）
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 * @return     计算得到的BigMoney对象
 */
func calculate(a: BigMoney, b: BigMoney, calculator: (BigMoney, BigMoney) -> BigMoney): BigMoney

/**
 * @brief      对BigMoney类型的二元运算
 * @param      a    被操作数
 * @param      b    操作数
 * @param      calculator    计算方法（multiply，divide）
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @exception  要求BigMoney对象this和om的Currency标准相等，否则抛出CurrencyNotSameException异常
 * @return     计算得到的BigMoney对象
 */
func calculate(a: BigMoney, b: BigMoney, calculator: (BigMoney, BigMoney, String) -> BigMoney, mode!: String="round"): BigMoney

/**
 * @brief      对BigMoney类型的一元运算
 * @param      m    被操作数
 * @param      calculator    计算方法（absolute，negative）
 * @return     计算得到的BigMoney对象
 */
func calculate(m: BigMoney, calculator: (BigMoney) -> BigMoney): BigMoney

/**
 * @brief      函数 allocate 的功能是根据比例 r/s 对BigMoney对象的金额进行分配。
 * @param      m    被操作数
 * @param      r    取的比例
 * @param      s    划分比例
 * @note       划分比例s不能小于等于零。当需要舍入时，直接舍去超出的位数。
 * @return     计算得到的BigMoney对象
 */
func allocate(m: BigMoney, r: Int64, s: Int64): BigMoney

/**
 * @brief      将一个 BigMoney 结构体的金额按照给定的比例分配给多个接收方。除法后，剩余的金额将在各方之间进行循环分配。
 * @param      m    被操作数
 * @param      rs   一个表示分配权重的数组
 * @note       划分比例应该为大于等于0的整数。除法后，剩余的金额将在各方之间进行循环分配。
 * @return     BigMoney对象的ArrayList
 */
func allocate(m: BigMoney, rs: Array<Int64>): ArrayList<BigMoney>

/**
 * @brief      函数 round 的功能是根据指定的精度 e 对BigMoney的金额进行四舍五入操作。
 * @param      m    被操作数
 * @param      e    精度
 * @note       精度 e 为正整数。
 * @return     计算得到的Money对象
 */
func round(m: BigMoney, e: Int64): BigMoney

/**
 * @brief      将BigMoney对象m的金额平均分为n份，并使用BigMoney对象的ArrayList返回。除法后，剩余的金额将在各方之间进行循环分配。
 * @param      m    被操作数
 * @param      n    份数
 * @note       n应该为大于0的整数
 * @return     BigMoney对象的ArrayList
 */
func split(m: BigMoney, n: Int64): ArrayList<BigMoney>

/**
 * @brief      对BigMoney类型的加运算
 * @param      a    被操作数
 * @param      b    操作数
 * @return     计算得到的BigMoney对象
 */
func add(a: BigMoney, b: BigMoney): BigMoney
/**
 * @brief      对BigMoney类型的减运算
 * @param      a    被减数
 * @param      b    减数
 * @return     计算得到的BigMoney对象
 */
func subtract(a: BigMoney, b: BigMoney): BigMoney

/**
 * @brief      对BigMoney类型的乘运算
 * @param      a    被操作数
 * @param      b    操作数
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @return     计算得到的BigMoney对象
 */
func multiply(a: BigMoney, b: BigMoney, mode!: String="round"): BigMoney

/**
 * @brief      对BigMoney类型的除运算
 * @param      a    被除数
 * @param      b    除数
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @return     计算得到的BigMoney对象
 */
func divide(a: BigMoney, b: BigMoney, mode!: String="round"): BigMoney

/**
 * @brief      对BigMoney类型的取模运算。
 * @param      a    被操作数
 * @param      b    操作数
 * @return     计算得到的BigMoney对象
 */
func modulus(a: BigMoney, b: BigMoney): BigMoney

/**
 * @brief      对BigMoney类型的取绝对值操作
 * @param      m    被操作数
 * @return     计算得到的BigMoney对象
 */
func absolute(m: BigMoney): BigMoney

/**
 * @brief      对BigMoney类型的取负数操作
 * @param      m    被操作数
 * @return     计算得到的BigMoney对象
 */
func negative(m: BigMoney): BigMoney

```



### 2.2 序列化与反序列化接口

序列化和反序列化对关系型数据库的存储十分关键。高效地实现`Money`和`BigMoney`的与字符串的相互转化，可以方便数据库操作。这些函数被写在`db.cj`这个文件里面。

建议使用默认的分隔字符串，可以避免混淆。

```cangjie
/**
 * @brief      将Money对象序列化为字符串。包含金额和Currency的code两项信息
 * @param      m    序列化的Money对象
 * @param      separator    分隔符
 * @return     序列化生成的字符串
 */
func serializeByCode(m: Money, separator!: String=DefaultDBMoneyValueSeparator): String

/**
 * @brief      将BigMoney对象序列化为字符串。包含金额和Currency的code两项信息
 * @param      m    序列化的Money对象
 * @param      separator    分隔符
 * @return     序列化生成的字符串
 */
func serializeByCode(m: BigMoney, separator!: String=DefaultDBMoneyValueSeparator): String

/**
 * @brief      将 amount|code 字符串反序列化为Money对象
 * @param      st    反序列化的字符串
 * @param      separator    分隔符
 * @return     反序列化生成的Money对象
 */
func deserializeByCode(st: String,  separator!: String=DefaultDBMoneyValueSeparator): Money

/**
 * @brief      将 amount|code 字符串反序列化为BigMoney对象
 * @param      st    反序列化的字符串
 * @param      separator    分隔符
 * @return     反序列化生成的BigMoney对象
 */
func deserializeBigMoneyByCode(st: String,  separator!: String=DefaultDBMoneyValueSeparator): BigMoney

/**
 * @brief      将Money对象序列化为字符串。包含金额和Currency的全部信息
 * @param      m    序列化的Money对象
 * @param      separator    分隔符
 * @return     序列化生成的字符串 amount|code|numericCode|fraction|grapheme|template|decimal|thousand
 */
func serializeAll(m: Money, separator!: String=DefaultDBMoneyValueSeparator): String

/**
 * @brief      将BigMoney对象序列化为字符串。包含金额和Currency的全部信息
 * @param      m    序列化的Money对象
 * @param      separator    分隔符
 * @return     序列化生成的字符串 amount|code|numericCode|fraction|grapheme|template|decimal|thousand
 */
func serializeAll(m: BigMoney, separator!: String=DefaultDBMoneyValueSeparator): String

/**
 * @brief      将 amount|code|numericCode|fraction|grapheme|template|decimal|thousand 字符串反序列化为Money对象
 * @param      st    反序列化的字符串
 * @param      separator    分隔符
 * @return     反序列化生成的Money对象
 */
func deserializeAll(st: String,  separator!: String=DefaultDBMoneyValueSeparator): Money

/**
 * @brief      将 amount|code|numericCode|fraction|grapheme|template|decimal|thousand 字符串反序列化为BigMone对象
 * @param      st    反序列化的字符串
 * @param      separator    分隔符
 * @return     反序列化生成的BigMoney对象
 */
func deserializeBigMoneyAll(st: String,  separator!: String=DefaultDBMoneyValueSeparator): BigMoney
```



### 2.3 格式化输入接口

在实际生活中或编程时，我们有时会使用数字字符串、科学计数法字符串等方式来表示货币的金额。解析这些字符串并进行合理的舍入对于创建`Money`对象或`BigMoney`对象是必要的。这些函数被写在`utils.cj`这个文件中。

我不建议开发者直接使用这些接口，这些接口被封装在了`Money`类和`BigMoney`类的构造函数中，可以直接对构造函数传参以实现通过数字字符串、科学计数法字符串等方式创建`Money`对象或`BigMoney`对象。

```cangjie
/**
 * @brief      判断str中的字符是否都是char
 * @param      str   受判断的String
 * @param      char   判断的字符
 * @return     是否都是的布尔值
 */
func StringAll(str: String, char: UInt8)

/**
 * @brief      判断一个ASCII字符是否是数字字符
 * @param      char   判断的字符
 * @return     是否都是的布尔值
 */
func isDigit(char: UInt8): Bool

/**
 * @brief      将一个Float64的数精确地转为Int64，四舍五入
 * @param      num   受转换的浮点数
 * @return     得到的整型
 */
func Float64ToInt64Round(num: Float64): Int64

/**
 * @brief      有限状态机，解析一个数字字符串
 * @param      number_string   数字字符串
 * @return     一个元组。第一元素表示符号，类型是字符串，有"+"和"-"两种情况；
 *                      第二元素表示整数部分，类型是字符串；
 *                      第三元素表示小数部分，类型是字符串；
 *                      第四元素表示指数部分的符号，类型是字符串，有"+"和"-"两种情况；
 *                      第五元素表示指数部分，类型是字符串。
 */
func FSMNumberString(number_string: String)

/**
 * @brief      将一个数字字符串转换为定点小数的整数表示。
 * @param      number_string   数字字符串
 * @param      fraction   定点小数的位数
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @return     定点小数的整数表示，类型是Int64
 */
func NumberStringToSmallAmount(number_string: String, fraction: Int64, mode!: String = "round"): Int64

/**
 * @brief      将一个数字字符串转换为定点小数的整数表示。
 * @param      number_string   数字字符串
 * @param      fraction   定点小数的位数
 * @param      mode    舍入模式（round四舍五入，truncate截断舍入，ceil向前舍入），默认为round
 * @return     定点小数的整数表示，类型是BigInt
 */
func NumberStringToBigAmount(number_string: String, fraction: Int64, mode!: String = "round"): BigInt

/**
 * @brief      将一个数字字符串转换为科学计数法表示的信息元组
 * @param      amount   数字字符串的整数部分
 * @param      fraction   数字字符串的小数位数
 * @param      integer_len   整数部分的长度
 * @param      fractional_len   小数部分的最大长度
 * @return     一个元组。第一元素表示符号，类型是字符串，有"+"和"-"两种情况；
 *                      第二元素表示整数部分，类型是字符串；
 *                      第三元素表示小数部分，类型是字符串；
 *                      第四元素表示指数部分，类型是Int64。
 */
func ScientificNotation(amount: String, fraction: Int64, integer_len: Int64, fractional_len: Int64)
```

