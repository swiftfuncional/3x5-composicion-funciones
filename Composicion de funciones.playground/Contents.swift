import UIKit

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

func formatPrice(price: Int) -> String {
	guard price > 0 else {
		return "Free"
	}

	return getFormatter(locale: "es_ES").string(from: NSNumber(value: price))!
}

func parseAndGetValid(json: String) -> [Int] {
	return getValidPrices(values: parseJSON(json: json))
}

func formatAll(prices: [Int]) -> [String] {
	return prices.map(formatPrice)
}

// parseJSON String -> [Int]
// formatAll [Int] -> [String]

func formatPrices(json: String) -> [String] {
	return formatAll(prices: parseAndGetValid(json: json))
}

formatPrices(json: "[10,5,null,20,0]")

