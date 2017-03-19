import UIKit

func parseJSON(json: String) -> [AnyObject] {
	return try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [AnyObject]
}

func formatPrices(json: String) -> [String] {
	let prices = parseJSON(json: json)

	var labels = [String]()

	for p in prices {
		if let price = p as? NSNumber {
			let label: String

			if price == 0 {
				label = "Free"
			} else {
				let formatter = NumberFormatter()
				formatter.numberStyle = .currency
				formatter.locale = Locale(identifier: "es_ES")

				label = formatter.string(from: price)!
			}

			labels.append(label)
		}
	}

	return labels
}

formatPrices(json: "[10,5,null,20,0]")

