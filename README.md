<div align="center">
<h1>cj-money</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.5.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.18-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-97.8%25-brightgreen" style="display: inline-block;" />
</p>


## 介绍
`cj-money`是一个用于解决金融计算领域浮点数误差的库。

项目参考了[Rhymond/go-money: Go implementation of Fowler's Money pattern](https://github.com/Rhymond/go-money)项目，并进行了若干功能拓展。

项目通过模拟定点数的计算来避免金融计算的浮点误差问题，支持了加、减、乘、除、取模、取相反数、取绝对值、舍入、分配等运算；同时还提供了格式化输入输出的函数；提供了序列化和反序列化的函数；还提供了对大数和小数的支持让开发者平衡计算范围和性能。



### 遵循标准

项目中的货币满足`ISO 4217`标准。



### 项目特性

- **高精度**：通过模拟定点数的计算来避免金融计算的浮点误差问题。
- **功能丰富**：支持了加、减、乘、除、取模、取相反数、取绝对值、舍入、分配等运算，满足金融计算的基本需求。
- **国际标准**：项目中的货币满足`ISO 4217`标准。
- **各取所需**：项目提供了对大数和小数的支持让开发者平衡计算范围和性能。

- **简单易用**：
  - **格式化**：提供各种格式化输入输出、序列化和反序列化方法，便于项目应用到各种系统。
  - **操作符重载**：让基本计算更贴近开发者的习惯，让代码更加简洁。



## 项目架构

- `doc` 文档目录，用于存放接口文档和测试覆盖文档。
- `src` 源代码目录，用于存放源代码以及相应的测试脚本。

### 源码目录

```
.
├── doc                         # 文档目录
│   └── test_doc          		# 测试覆盖文档
│   └── feature_api.md          # 特性接口文档
├── src                         # 源码目录
│   └── BigMoney.cj             # 大金额金钱类型定义
│   └── BigMoney_test.cj        # 大金额金钱类型相关功能测试
│   └── Calculator.cj           # 金钱计算核心逻辑
│   └── Calculator_test.cj      # 金钱计算核心逻辑相关功能测试
│   └── Currency.cj             # 货币标准定义
│   └── Currency_test.cj        # 货币标准相关功能测试
│   └── Formatter.cj            # 格式化输出逻辑
│   └── Formatter_test.cj       # 格式化输出相关功能测试
│   └── Money.cj                # 小金额金钱类型定义
│   └── Money_test.cj           # 小金额金钱类型相关功能测试
│   └── db.cj                   # 序列化和反序列化逻辑
│   └── db_test.cj              # 序列化和反序列化相关功能测试
│   └── const.cj                # 项目常量定义
│   └── exception.cj            # 自定义异常
│   └── utils.cj            	# 格式化输入逻辑
│   └── utils_test.cj           # 格式化输入相关功能测试
├── .gitignore                  # Git 忽略规则文件
├── LICENSE                     # 许可证
├── README.md                   # 项目介绍
└── cjpm.toml                   # 项目配置文件
```



### 接口说明

主要类和函数接口说明，详见 [API](./doc/feature_api.md)




## 使用说明

一个简易的示例程序见于[cj-money-example](https://gitcode.com/m0_74803157/cj-money-example/tree/main)。完整功能详见[接口说明](./doc/feature_api.md)，下面是核心功能：

### 创建金钱对象

声明`Money`对象，`Money`对象有两个属性组成，`amount`和`currency`，分别表示金额和货币标准。`amount`可以通过整型、浮点型、数字字符串、科学计数法字符串声明。`currency`可以通过`Currency`对象、货币代码和货币数字代码声明。可以指定舍入模式。

```cangjie
let currency: Currency = Currency(".", ",", "AOA", 2, "973", "Kz", "1$")
let m1: Money = Money(100, "784", "numeric code")
let m2: Money = Money("100", currency)
let m3: Money = Money(2.00, "CNY")
let m4: Money = Money("1.566666E2", "CNY", code_mode: "code", mode: "round")
```

`BigMoney`对象同理。`amount`可以通过`BigInt`对象、数字字符串、科学计数法字符串声明。`currency`可以通过`Currency`对象、货币代码和货币数字代码声明。可以指定舍入模式。

```cangjie
let bm1: BigMoney = BigMoney(BigInt("189732178342819734281273941864375134261342871234783429182347673843234"), currency)
let bm2: BigMoney = BigMoney("-6428273457845568738192746871923498173429871346871349213464328756.134123412", "CNY")
let bm3: BigMoney = BigMoney("10.132413242134e128", "CNY")
```



### 格式化输出

通过`display`方法，可以将`Money`对象或`BigMoney`对象按照`currency`中的`template`模板来生成一个字符串，用于展示。

```cangjie
println(m1.display())
```

`displayByScientificNotation`方法将`Money`对象或`BigMoney`对象转化为按照`template`模板的科学计数法字符串。

```cangjie
println(m1.displayByScientificNotation(integer_len: 1, fractional_len: 2))
```



### 二元运算前置条件

`sameCurrency`方法可以根据货币的ISO字母代码来判断`Money`对象或`BigMoney`对象中的`currency`对象是否相等。`currency`对象相等的`Money`对象或`BigMoney`对象之间才能进行运算。

```cangjie
println(m1.sameCurrency(m2))
```



### 判断金额大小

使用关系运算符判断`Money`对象或`BigMoney`对象的大小关系。

```cangjie
print(m1 == m3)
print(m1 > m3)
print(m1 >= m3)
print(m1 < m3)
print(m1 <= m3)
```



### 判断正负性

方法`isZero`、`isPositive`、`isNegative`用于判断`Money`对象或`BigMoney`对象的金额`amount`属性的正负性

```cangjie
println(m1.isZero())
println(m2.isPositive())
println(m3.isNegative())
```



### 一元运算

取绝对值：

```cangjie
let m10: Money = calculate(m1, absolute)
```

取相反数：

```cangjie
var m11: Money = calculate(m1, negative)
m11 = -m11
```



### 二元运算

加：

```cangjie
var m5: Money = calculate(m1, m3, add)
m5 = m1 + m3
```

减：

```cangjie
var m6: Money = calculate(m1, m3, subtract)
m6 = m1 - m3
```

乘：

```cangjie
var m7: Money = calculate(m1, m3, multiply, "round")
m7 = m1 * m3
```

除：

```cangjie
var m8: Money = calculate(m1, m3, divide, "ceil")
m8 = m1 / m3
```

取余：

```cangjie
var m9: Money = calculate(m1, m3, modulus)
m9 = m1  % m3
```



### 分配

`allocate`方法有两个重构。

一是是根据比例`r/s `对`Money`对象或`BigMoney`对象的金额进行分配。

```cangjie
let m12: Money = allocate(m1, 1, 2)
```

二是将一个`Money`对象或`BigMoney`对象的金额按照给定的比例分配给多个接收方。除法后，剩余的金额将在各方之间进行循环分配。

```cangjie
let ms1: ArrayList<Money> = allocate(m1, [1, 2, 3])
```

方法`split`将`Money`对象`m`的金额平均分为`n`份，并使用`Money`对象的`ArrayList`返回。除法后，剩余的金额将在各方之间进行循环分配。

```cangjie
let ms2: ArrayList<Money> = split(m1, 3)
```



### 四舍五入

方法`round`的功能是根据指定的精度`e`对`Money`的金额进行四舍五入操作。

```cangjie
let m13: Money = round(m1, 1)
```



### 序列化和反序列化

序列化：

```cangjie
println(serializeByCode(m1, separator: "|"))
println(serializeAll(m1, separator: "|"))
```

反序列化：

```cangjie
let m14: Money = deserializeByCode("999|GYD", separator: "|")
let m15: Money = deserializeAll("970|ZWD|716|2|Z$|$1|.|,", separator: "|")
```



## 约束与限制

- 在下述版本验证通过：

```
Cangjie Version: 0.53.18
```

- 项目的测试覆盖率到达了`97.8%`，部分测试脚本中的一些分支不可能覆盖，基于异常处理的习惯把这些分支写出。对于项目的源代码，测试覆盖率达到了`100%`。



## 开源协议

本项目基于 [MIT_License](./LICENSE) 。
