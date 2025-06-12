package cj_money

import std.collection.HashMap

/**
 * @brief      Currency类用于储存一个类的ISO 4217标准
 */
struct Currency {
    /**
     * @brief      原子数据类型创建Currency对象
     *
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
    ) {}

    /**
     * @brief      通过货币的字母代码或者数字代码创建Currency对象
     *
     * @param      code   Currency对象对应的代号
     * @param      code_mode   采用字母编号还是数字编号，code表示字母编号，numeric code表示数字编号，默认为code
     */
    public init(code: String, mode!: String = "code") {
        let currencies: Currencies = Currencies.getCurrencies()

        let currency: Currency

        if (mode == "code") {
            currency = match (currencies.currencyByCode(code)) {
                case None => throw NoneValueException("没有找到code为${code}的Currency")
                case Some(v) => v
            }
        } else if (mode == "numeric code") {
            currency = match (currencies.currencyByNumericCode(code)) {
                case None => throw NoneValueException("没有找到numeric code为${code}的Currency")
                case Some(v) => v
            }
        } else {
            throw IllegalArgumentException("不存在使用${code}创建Currency对象的模式。")
        }

        this.code = currency.code
        this.numericCode = currency.numericCode
        this.fraction = currency.fraction
        this.grapheme = currency.grapheme
        this.template = currency.template
        this.decimal = currency.decimal
        this.thousand = currency.thousand
    }

    /**
     * @brief      格式化程序返回货币格式化程序表示
     *
     * @return     这个Currency对应的Formatter对象
     */
    public func getFormatter(): Formatter {
        return Formatter(this.fraction, this.decimal, this.thousand, this.grapheme, this.template)
    }

    /**
     * @brief      根据唯一标识符code判断两个Currency对象是否相等
     *
     * @param      oc   相对比的Currency对象
     *
     * @return     是否相等的布尔值
     */
    public func equalsByCode(oc: Currency): Bool {
        return this.code == oc.code
    }
}

/**
 * @brief      Currencies类储存了货币的格式等标准，该类被设计为单例模式
 */
class Currencies {
    private static var instance: Option<Currencies> = None

    let currencies: HashMap<String, Currency>

    /**
     * @brief      获取Currencies对象
     *
     * @return     获取的Currencies对象
     */
    public static func getCurrencies(): Currencies {
        if (instance.isNone()) {
            instance = Some(Currencies())
        }
        return instance.getOrThrow()
    }

    /**
     * @brief      根据ISO-4271中定义的数字代码，CurrencyByNumericCode返回货币。
     *
     * @param      numericCode   供检索的numericCode
     *
     * @return     numericCode对应的Currency对象
     */
    public func currencyByNumericCode(numericCode: String): ?Currency {
        for ((_, sc) in this.currencies) {
            if (sc.numericCode == numericCode) {
                return sc
            }
        }
        return None
    }

    /**
     * @brief      返回给定货币代码的货币。
     *
     * @param      code   供检索的货币代码
     *
     * @return     code对应的Currency对象
     */
    public func currencyByCode(code: String): ?Currency {
        if (!this.currencies.contains(code)) {
            return None
        }
        return currencies[code]
    }

    /**
     * @brief      这里硬编码了ISO 4217标准
     */
    private Currencies() {
        currencies = HashMap<String, Currency>(
            [
                ("AED", Currency(".", ",", "AED", 2, "784", ".\u{062f}.\u{0625}", "1 $")),
                ("AFN", Currency(".", ",", "AFN", 2, "971", "\u{060b}", "1 $")),
                ("ALL", Currency(".", ",", "ALL", 2, "008", "L", "$1")),
                ("AMD", Currency(".", ",", "AMD", 2, "051", "\u{0564}\u{0580}.", "1 $")),
                ("ANG", Currency(",", ".", "ANG", 2, "532", "\u{0192}", "$1")),
                ("AOA", Currency(".", ",", "AOA", 2, "973", "Kz", "1$")),
                ("ARS", Currency(",", ".", "ARS", 2, "032", "$", "$1")),
                ("AUD", Currency(".", ",", "AUD", 2, "036", "$", "$1")),
                ("AWG", Currency(".", ",", "AWG", 2, "533", "\u{0192}", "1$")),
                ("AZN", Currency(".", ",", "AZN", 2, "944", "\u{20bc}", "$1")),
                ("BAM", Currency(".", ",", "BAM", 2, "977", "KM", "$1")),
                ("BBD", Currency(".", ",", "BBD", 2, "052", "$", "$1")),
                ("BDT", Currency(".", ",", "BDT", 2, "050", "\u{09f3}", "$1")),
                ("BGN", Currency(".", ",", "BGN", 2, "975", "\u{043b}\u{0432}", "$1")),
                ("BHD", Currency(".", ",", "BHD", 3, "048", ".\u{062f}.\u{0628}", "1 $")),
                ("BIF", Currency(".", ",", "BIF", 0, "108", "Fr", "1$")),
                ("BMD", Currency(".", ",", "BMD", 2, "060", "$", "$1")),
                ("BND", Currency(".", ",", "BND", 2, "096", "$", "$1")),
                ("BOB", Currency(".", ",", "BOB", 2, "068", "Bs.", "$1")),
                ("BRL", Currency(",", ".", "BRL", 2, "986", "R$", "$1")),
                ("BSD", Currency(".", ",", "BSD", 2, "044", "$", "$1")),
                ("BTN", Currency(".", ",", "BTN", 2, "064", "Nu.", "1$")),
                ("BWP", Currency(".", ",", "BWP", 2, "072", "P", "$1")),
                ("BYN", Currency(",", " ", "BYN", 2, "933", "p.", "1 $")),
                ("BYR", Currency(",", " ", "BYR", 0, "", "p.", "1 $")),
                ("BZD", Currency(".", ",", "BZD", 2, "084", "BZ$", "$1")),
                ("CAD", Currency(".", ",", "CAD", 2, "124", "$", "$1")),
                ("CDF", Currency(".", ",", "CDF", 2, "976", "FC", "1$")),
                ("CHF", Currency(".", ",", "CHF", 2, "756", "CHF", "1 $")),
                ("CLF", Currency(",", ".", "CLF", 4, "990", "UF", "$1")),
                ("CLP", Currency(",", ".", "CLP", 0, "152", "$", "$1")),
                ("CNY", Currency(".", ",", "CNY", 2, "156", "\u{5143}", "1 $")),
                ("COP", Currency(",", ".", "COP", 2, "170", "$", "$1")),
                ("CRC", Currency(".", ",", "CRC", 2, "188", "\u{20a1}", "$1")),
                ("CUC", Currency(".", ",", "CUC", 2, "931", "$", "1$")),
                ("CUP", Currency(".", ",", "CUP", 2, "192", "$MN", "$1")),
                ("CVE", Currency(".", ",", "CVE", 2, "132", "$", "1$")),
                ("CZK", Currency(".", ",", "CZK", 2, "203", "K\u{010d}", "1 $")),
                ("DJF", Currency(".", ",", "DJF", 0, "262", "Fdj", "1 $")),
                ("DKK", Currency(",", ".", "DKK", 2, "208", "kr", "$ 1")),
                ("DOP", Currency(".", ",", "DOP", 2, "214", "RD$", "$1")),
                ("DZD", Currency(".", ",", "DZD", 2, "012", ".\u{062f}.\u{062c}", "1 $")),
                ("EEK", Currency(".", ",", "EEK", 2, "", "kr", "$1")),
                ("EGP", Currency(".", ",", "EGP", 2, "818", "\u{00a3}", "$1")),
                ("ERN", Currency(".", ",", "ERN", 2, "232", "Nfk", "1 $")),
                ("ETB", Currency(".", ",", "ETB", 2, "230", "Br", "1 $")),
                ("EUR", Currency(".", ",", "EUR", 2, "978", "\u{20ac}", "$1")),
                ("FJD", Currency(".", ",", "FJD", 2, "242", "$", "$1")),
                ("FKP", Currency(".", ",", "FKP", 2, "238", "\u{00a3}", "$1")),
                ("GBP", Currency(".", ",", "GBP", 2, "826", "\u{00a3}", "$1")),
                ("GEL", Currency(".", ",", "GEL", 2, "981", "\u{10da}", "1 $")),
                ("GGP", Currency(".", ",", "GGP", 2, "", "\u{00a3}", "$1")),
                ("GHC", Currency(".", ",", "GHC", 2, "", "\u{00a2}", "$1")),
                ("GHS", Currency(".", ",", "GHS", 2, "936", "\u{20b5}", "$1")),
                ("GIP", Currency(".", ",", "GIP", 2, "292", "\u{00a3}", "$1")),
                ("GMD", Currency(".", ",", "GMD", 2, "270", "D", "1 $")),
                ("GNF", Currency(".", ",", "GNF", 0, "324", "FG", "1 $")),
                ("GTQ", Currency(".", ",", "GTQ", 2, "320", "Q", "$1")),
                ("GYD", Currency(".", ",", "GYD", 2, "328", "$", "$1")),
                ("HKD", Currency(".", ",", "HKD", 2, "344", "$", "$1")),
                ("HNL", Currency(".", ",", "HNL", 2, "340", "L", "$1")),
                ("HRK", Currency(",", ".", "HRK", 2, "191", "kn", "1 $")),
                ("HTG", Currency(",", ".", "HTG", 2, "332", "G", "1 $")),
                ("HUF", Currency(",", ".", "HUF", 2, "348", "Ft", "1 $")),
                ("IDR", Currency(",", ".", "IDR", 2, "360", "Rp", "$1")),
                ("ILS", Currency(".", ",", "ILS", 2, "376", "\u{20aa}", "$1")),
                ("IMP", Currency(".", ",", "IMP", 2, "", "\u{00a3}", "$1")),
                ("INR", Currency(".", ",", "INR", 2, "356", "\u{20b9}", "$1")),
                ("IQD", Currency(".", ",", "IQD", 3, "368", ".\u{062f}.\u{0639}", "1 $")),
                ("IRR", Currency(".", ",", "IRR", 2, "364", "\u{fdfc}", "1 $")),
                ("ISK", Currency(",", ".", "ISK", 0, "352", "kr", "$1")),
                ("JEP", Currency(".", ",", "JEP", 2, "", "\u{00a3}", "$1")),
                ("JMD", Currency(".", ",", "JMD", 2, "388", "J$", "$1")),
                ("JOD", Currency(".", ",", "JOD", 3, "400", ".\u{062f}.\u{0625}", "1 $")),
                ("JPY", Currency(".", ",", "JPY", 0, "392", "\u{00a5}", "$1")),
                ("KES", Currency(".", ",", "KES", 2, "404", "KSh", "$1")),
                ("KGS", Currency(".", ",", "KGS", 2, "417", "\u{0441}\u{043e}\u{043c}", "1 $")),
                ("KHR", Currency(".", ",", "KHR", 2, "116", "\u{17db}", "$1")),
                ("KMF", Currency(".", ",", "KMF", 0, "174", "CF", "$1")),
                ("KPW", Currency(".", ",", "KPW", 2, "408", "\u{20a9}", "$1")),
                ("KRW", Currency(".", ",", "KRW", 0, "410", "\u{20a}", "$1")),
                ("KWD", Currency(".", ",", "KWD", 3, "414", ".\u{062f}.\u{0643}", "1 $")),
                ("KYD", Currency(".", ",", "KYD", 2, "136", "$", "$1")),
                ("KZT", Currency(".", ",", "KZT", 2, "398", "\u{20b8}", "$1")),
                ("LAK", Currency(".", ",", "LAK", 2, "418", "\u{20ad}", "$1")),
                ("LBP", Currency(".", ",", "LBP", 2, "422", "\u{00a3}", "$1")),
                ("LKR", Currency(".", ",", "LKR", 2, "144", "\u{20a8}", "$1")),
                ("LRD", Currency(".", ",", "LRD", 2, "430", "$", "$1")),
                ("LSL", Currency(".", ",", "LSL", 2, "426", "L", "$1")),
                ("LTL", Currency(".", ",", "LTL", 2, "", "Lt", "$1")),
                ("LVL", Currency(".", ",", "LVL", 2, "", "Ls", "1 $")),
                ("LYD", Currency(".", ",", "LYD", 3, "434", ".\u{062f}.\u{0644}", "1 $")),
                ("MAD", Currency(".", ",", "MAD", 2, "504", ".\u{062f}.\u{0645}", "1 $")),
                ("MDL", Currency(".", ",", "MDL", 2, "498", "lei", "1 $")),
                ("MGA", Currency(".", ",", "MGA", 2, "969", "Ar", "1$")),
                ("MKD", Currency(".", ",", "MKD", 2, "807", "\u{0434}\u{0435}\u{043d}", "$1")),
                ("MMK", Currency(".", ",", "MMK", 2, "104", "K", "$1")),
                ("MNT", Currency(".", ",", "MNT", 2, "496", "\u{20ae}", "$1")),
                ("MOP", Currency(".", ",", "MOP", 2, "446", "P", "1 $")),
                ("MRU", Currency(".", ",", "MRU", 2, "929", "UM", "$1")),
                ("MUR", Currency(".", ",", "MUR", 2, "480", "\u{20a8}", "$1")),
                ("MVR", Currency(".", ",", "MVR", 2, "462", "MVR", "1 $")),
                ("MWK", Currency(".", ",", "MWK", 2, "454", "MK", "$1")),
                ("MXN", Currency(".", ",", "MXN", 2, "484", "$", "$1")),
                ("MYR", Currency(".", ",", "MYR", 2, "458", "RM", "$1")),
                ("MZN", Currency(".", ",", "MZN", 2, "943", "MT", "$1")),
                ("NAD", Currency(".", ",", "NAD", 2, "516", "$", "$1")),
                ("NGN", Currency(".", ",", "NGN", 2, "566", "\u{20a6}", "$1")),
                ("NIO", Currency(".", ",", "NIO", 2, "558", "C$", "$1")),
                ("NOK", Currency(".", ",", "NOK", 2, "578", "kr", "1 $")),
                ("NPR", Currency(".", ",", "NPR", 2, "524", "\u{20a8}", "$1")),
                ("NZD", Currency(".", ",", "NZD", 2, "554", "$", "$1")),
                ("OMR", Currency(".", ",", "OMR", 3, "512", "\u{fdfc}", "1 $")),
                ("PAB", Currency(".", ",", "PAB", 2, "590", "B/.", "$1")),
                ("PEN", Currency(".", ",", "PEN", 2, "604", "S/", "$1")),
                ("PGK", Currency(".", ",", "PGK", 2, "598", "K", "1 $")),
                ("PHP", Currency(".", ",", "PHP", 2, "608", "\u{20b1}", "$1")),
                ("PKR", Currency(".", ",", "PKR", 2, "586", "\u{20a8}", "$1")),
                ("PLN", Currency(".", ",", "PLN", 2, "985", "z\u{0142}", "1 $")),
                ("PYG", Currency(".", ",", "PYG", 0, "600", "Gs", "1$")),
                ("QAR", Currency(".", ",", "QAR", 2, "634", "\u{fdfc}", "1 $")),
                ("RON", Currency(".", ",", "RON", 2, "946", "lei", "$1")),
                ("RSD", Currency(".", ",", "RSD", 2, "941", "\u{0414}\u{0438}\u{043d}.", "$1")),
                ("RUB", Currency(".", ",", "RUB", 2, "643", "\u{20bd}", "1 $")),
                ("RUR", Currency(".", ",", "RUR", 2, "", "\u{20bd}", "1 $")),
                ("RWF", Currency(".", ",", "RWF", 0, "646", "FRw", "1 $")),
                ("SAR", Currency(".", ",", "SAR", 2, "682", "\u{fdfc}", "1 $")),
                ("SBD", Currency(".", ",", "SBD", 2, "090", "$", "$1")),
                ("SCR", Currency(".", ",", "SCR", 2, "690", "\u{20a8}", "$1")),
                ("SDG", Currency(".", ",", "SDG", 2, "938", "\u{00a3}", "$1")),
                ("SEK", Currency(".", ",", "SEK", 2, "752", "kr", "1 $")),
                ("SGD", Currency(".", ",", "SGD", 2, "702", "$", "$1")),
                ("SHP", Currency(".", ",", "SHP", 2, "654", "\u{00a3}", "$1")),
                ("SKK", Currency(".", ",", "SKK", 2, "", "Sk", "$1")),
                ("SLE", Currency(".", ",", "SLE", 2, "925", "Le", "1 $")),
                ("SLL", Currency(".", ",", "SLL", 2, "694", "Le", "1 $")),
                ("SOS", Currency(".", ",", "SOS", 2, "706", "Sh", "1 $")),
                ("SRD", Currency(".", ",", "SRD", 2, "968", "$", "$1")),
                ("SSP", Currency(".", ",", "SSP", 2, "728", "\u{00a3}", "1 $")),
                ("STD", Currency(".", ",", "STD", 2, "", "Db", "1 $")),
                ("STN", Currency(".", ",", "STN", 2, "930", "Db", "1 $")),
                ("SVC", Currency(".", ",", "SVC", 2, "222", "\u{20a1}", "$1")),
                ("SYP", Currency(".", ",", "SYP", 2, "760", "\u{00a3}", "1 $")),
                ("SZL", Currency(".", ",", "SZL", 2, "748", "\u{00a3}", "$1")),
                ("THB", Currency(".", ",", "THB", 2, "764", "\u{0e3f}", "$1")),
                ("TJS", Currency(".", ",", "TJS", 2, "972", "SM", "1 $")),
                ("TMT", Currency(".", ",", "TMT", 2, "934", "T", "1 $")),
                ("TND", Currency(".", ",", "TND", 3, "788", ".\u{062f}.\u{062a}", "1 $")),
                ("TOP", Currency(".", ",", "TOP", 2, "776", "T$", "$1")),
                ("TRL", Currency(".", ",", "TRL", 2, "", "\u{20a4}", "$1")),
                ("TRY", Currency(".", ",", "TRY", 2, "949", "\u{20ba}", "$1")),
                ("TTD", Currency(".", ",", "TTD", 2, "780", "TT$", "$1")),
                ("TWD", Currency(".", ",", "TWD", 2, "901", "NT$", "$1")),
                ("TZS", Currency(".", ",", "TZS", 0, "834", "TSh", "$1")),
                ("UAH", Currency(".", ",", "UAH", 2, "980", "\u{20b4}", "1 $")),
                ("UGX", Currency(".", ",", "UGX", 0, "800", "USh", "1 $")),
                ("USD", Currency(".", ",", "USD", 2, "840", "$", "$1")),
                ("UYU", Currency(".", ",", "UYU", 2, "858", "$U", "$1")),
                ("UZS", Currency(".", ",", "UZS", 2, "860", "so\u{2019}m", "$1")),
                ("VEF", Currency(".", ",", "VEF", 2, "937", "Bs", "$1")),
                ("VES", Currency(".", ",", "VES", 2, "928", "Bs.S", "$1")),
                ("VND", Currency(".", ",", "VND", 0, "704", "\u{20ab}", "1 $")),
                ("VUV", Currency(".", ",", "VUV", 0, "548", "Vt", "$1")),
                ("WST", Currency(".", ",", "WST", 2, "882", "T", "1 $")),
                ("XAF", Currency(".", ",", "XAF", 0, "950", "Fr", "1 $")),
                ("XAG", Currency(".", ",", "XAG", 0, "961", "oz t", "1 $")),
                ("XAU", Currency(".", ",", "XAU", 0, "959", "oz t", "1 $")),
                ("XCD", Currency(".", ",", "XCD", 2, "951", "$", "$1")),
                ("XDR", Currency(".", ",", "XDR", 0, "960", "SDR", "1 $")),
                ("XOF", Currency(".", ",", "XOF", 0, "952", "CFA", "1 $")),
                ("XPF", Currency(".", ",", "XPF", 0, "953", "₣", "1 $")),
                ("YER", Currency(".", ",", "YER", 2, "886", "\u{fdfc}", "1 $")),
                ("ZAR", Currency(".", ",", "ZAR", 2, "710", "R", "$1")),
                ("ZMW", Currency(".", ",", "ZMW", 2, "967", "ZK", "$1")),
                ("ZWD", Currency(".", ",", "ZWD", 2, "716", "Z$", "$1")),
                ("ZWL", Currency(".", ",", "ZWL", 2, "932", "Z$", "$1"))
            ]
        )
    }
}
