import UIKit

infix operator |>: AdditionPrecedence

func |> <T, U, V>(stepOne: @escaping (T) -> U, stepTwo: @escaping (U) -> V) -> ((T) -> V) {
	return {
		stepTwo(stepOne($0))
	}
}

func parseJSON(json: String) -> [AnyObject] {
	return try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [AnyObject]
}

func getValidPrices(values: [AnyObject]) -> [Int] {
	return values
		.map { $0 as? NSNumber }
		.filter { $0 != nil }
		.map { $0!.intValue }
}

func getFormatter(locale: String) -> NumberFormatter {
	let formatter = NumberFormatter()
	formatter.numberStyle = .currency
	formatter.locale = Locale(identifier: locale)

	return formatter
}

func formatPrice(locale: String) -> (Int) -> String {
	return {
		guard $0 > 0 else {
			return "Free"
		}

		return getFormatter(locale: locale)
				.string(from: NSNumber(value: $0))!
	}
}

func formatAll(locale: String)-> ([Int]) -> [String] {
	return { $0.map(formatPrice(locale: locale)) }
}

let formatAsSpanishCurrency = formatAll(locale: "es_ES")

let formatPricesCombined = (parseJSON |> getValidPrices |> formatAsSpanishCurrency)

formatPricesCombined("[10,5,null,20,0]")

