//
//  DateManager.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 20.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    private init() {}
    private let dateFormatIso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    func dateFormatFromIso8601(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatIso8601
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        return date
    }
    func dateFormatCurrentDayFromIso8601(from date: Date?) -> Int? {
        guard let dateForFormat = date else { return nil }
        let calendar = Calendar.current
        return calendar.component(.day, from: dateForFormat)
    }
    func dateFormatCurrentHourFromIso8601(from date: Date?) -> Int? {
        guard let dateForFormat = date else { return nil }
        let calendar = Calendar.current
        return calendar.component(.hour, from: dateForFormat)
    }
    func dateFormatCurrentDateForSection(from date: Date?) -> String? {
        guard let dateForFormat = date else { return nil }
        let calendar = Calendar.current
        let day = calendar.component(.day, from: dateForFormat)
        let month = calendar.component(.month, from: dateForFormat)
        let year = calendar.component(.year, from: dateForFormat)
        return "\(day)-\(month)-\(year)"
    }
    
}
