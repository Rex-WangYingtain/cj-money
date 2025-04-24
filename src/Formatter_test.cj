package cj_money

import std.unittest.*
import std.unittest.testmacro.*

struct FormatTestCase {
    let fraction: Int64
    let decimal: String
    let thousand: String
    let grapheme: String
    let template: String
    let amount: Int64
    let expected: String

    public FormatTestCase(
        fraction: Int64,
        decimal: String,
        thousand: String,
        grapheme: String,
        template: String,
        amount: Int64,
        expected: String
    ) {
        this.fraction = fraction
        this.decimal = decimal
        this.thousand = thousand
        this.grapheme = grapheme
        this.template = template
        this.amount = amount
        this.expected = expected
    }
}

@Test
class FormatTest {
    let testcases = Array<FormatTestCase>(
        [
            FormatTestCase(2, ".", ",", "$", "1 $", 0, "0.00 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 1, "0.01 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 12, "0.12 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 123, "1.23 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 1234, "12.34 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 12345, "123.45 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 123456, "1,234.56 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 1234567, "12,345.67 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 12345678, "123,456.78 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", 123456789, "1,234,567.89 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -1, "-0.01 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -12, "-0.12 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -123, "-1.23 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -1234, "-12.34 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -12345, "-123.45 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -123456, "-1,234.56 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -1234567, "-12,345.67 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -12345678, "-123,456.78 $"),
            FormatTestCase(2, ".", ",", "$", "1 $", -123456789, "-1,234,567.89 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 1, "0.001 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 12, "0.012 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 123, "0.123 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 1234, "1.234 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 12345, "12.345 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 123456, "123.456 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 1234567, "1234.567 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 12345678, "12345.678 $"),
            FormatTestCase(3, ".", "", "$", "1 $", 123456789, "123456.789 $"),
            FormatTestCase(2, ".", ",", "£", "$1", 1, "£0.01"),
            FormatTestCase(2, ".", ",", "£", "$1", 12, "£0.12"),
            FormatTestCase(2, ".", ",", "£", "$1", 123, "£1.23"),
            FormatTestCase(2, ".", ",", "£", "$1", 1234, "£12.34"),
            FormatTestCase(2, ".", ",", "£", "$1", 12345, "£123.45"),
            FormatTestCase(2, ".", ",", "£", "$1", 123456, "£1,234.56"),
            FormatTestCase(2, ".", ",", "£", "$1", 1234567, "£12,345.67"),
            FormatTestCase(2, ".", ",", "£", "$1", 12345678, "£123,456.78"),
            FormatTestCase(2, ".", ",", "£", "$1", 123456789, "£1,234,567.89"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 1, "NT$1"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 12, "NT$12"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 123, "NT$123"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 1234, "NT$1,234"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 12345, "NT$12,345"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 123456, "NT$123,456"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 1234567, "NT$1,234,567"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 12345678, "NT$12,345,678"),
            FormatTestCase(0, ".", ",", "NT$", "$1", 123456789, "NT$123,456,789"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -1, "-NT$1"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -12, "-NT$12"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -123, "-NT$123"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -1234, "-NT$1,234"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -12345, "-NT$12,345"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -123456, "-NT$123,456"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -1234567, "-NT$1,234,567"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -12345678, "-NT$12,345,678"),
            FormatTestCase(0, ".", ",", "NT$", "$1", -123456789, "-NT$123,456,789")
        ]
    )
    @TestCase
    public func runTest() {
        for (format_test_case in this.testcases) {
            let formatter = Formatter(
                format_test_case.fraction,
                format_test_case.decimal,
                format_test_case.thousand,
                format_test_case.grapheme,
                format_test_case.template
            )
            let output = formatter.format(format_test_case.amount)
            @Expect(format_test_case.expected, output)
        }
    }
}

struct ToMajorUnitsTestCase {
    let fraction: Int64
    let decimal: String
    let thousand: String
    let grapheme: String
    let template: String
    let amount: Int64
    let expected: Float64

    public ToMajorUnitsTestCase(
        fraction: Int64,
        decimal: String,
        thousand: String,
        grapheme: String,
        template: String,
        amount: Int64,
        expected: Float64
    ) {
        this.fraction = fraction
        this.decimal = decimal
        this.thousand = thousand
        this.grapheme = grapheme
        this.template = template
        this.amount = amount
        this.expected = expected
    }
}
