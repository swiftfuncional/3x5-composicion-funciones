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

func formatPrice(locale: String, price: Int) -> String {
	guard price > 0 else {
		return "Free"
	}

	return getFormatter(locale: locale).string(from: NSNumber(value: price))!
}

func formatPrices(json: String) -> [String] {

	return getValidPrices(values: parseJSON(json: json)).map {
		formatPrice(locale: "es_ES", price: $0)
	}
}

formatPrices(json: "[10,5,null,20,0]")

