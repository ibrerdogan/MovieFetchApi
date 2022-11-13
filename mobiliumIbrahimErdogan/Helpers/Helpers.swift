//
//  Helpers.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation

func formatRelaseDate(relase : String) -> String
{
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"

    let dateFormatterSet = DateFormatter()
    dateFormatterSet.dateFormat = "dd.MM.yyyy"

    if let date = dateFormatterGet.date(from: relase) {
        return dateFormatterSet.string(from: date)

    } else {
        return "10.10.2020"
    }
}

func setTitle(name : String , relase : String) -> String
{
    let date = relase.split(separator: "-")
    let year = date[0]
    return name + " (\(year))"
}

func rateFormat(value : Double) -> String
{
    let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 1
            let number = NSNumber(value: value)
            let formattedValue = formatter.string(from: number)!
            return formattedValue
           
}
