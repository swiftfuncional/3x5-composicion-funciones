import UIKit

func parseJSON(json: String) -> [AnyObject] {
	return try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [AnyObject]
}

func getValidPrices(values: [AnyObject]) -> [Int] {
	var prices = [Int]()

	for v in values {
		if let price = v as? NSNumber {
			prices.append(price.intValue)
		}
	}

	return prices
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
	let jsonParsed = parseJSON(json: json)

	let prices = getValidPrices(values: jsonParsed)

	var labels = [String]()

	for p in prices {
		let label = formatPrice(locale: "es_ES", price: p)
		labels.append(label)
	}

	return labels
}

formatPrices(json: "[10,5,null,20,0]")

