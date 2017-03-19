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

func formatPrices(json: String) -> [String] {
	let jsonParsed = parseJSON(json: json)

	let prices = getValidPrices(values: jsonParsed)

	var labels = [String]()

	for p in prices {
		let label: String

		if p == 0 {
			label = "Free"
		} else {
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			formatter.locale = Locale(identifier: "es_ES")

			label = formatter.string(from: NSNumber(value: p))!
		}

		labels.append(label)
	}

	return labels
}

formatPrices(json: "[10,5,null,20,0]")

