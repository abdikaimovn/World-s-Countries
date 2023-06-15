//
//  CountryApi.swift
//  WorldCountries
//
//  Created by Нурдаулет on 08.06.2023.
//

import Foundation
import UIKit

struct CountryInfoApi{
    static let shared = CountryInfoApi()
    func replaceWhitespaces(str:String)->String{
        var newStr = ""
        for i in str{
            if i != " "{
                newStr += String(i)
            }else{
                newStr += "%20"
            }
        }
        return newStr
    }
    func fetchCountryInfo(completion: @escaping ([CountryInfo]?) -> Void) {
        guard let countryName = CountryInfoViewController.countryName else {
            print("Country name is nil")
            completion(nil)
            return
        }
        let urlString = "https://restcountries.com/v3.1/name/\(replaceWhitespaces(str: countryName))"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let safeData = data else {
                print("data was nil")
                completion(nil)
                return
            }
            do {
                let countryInfo = try JSONDecoder().decode([CountryInfo].self, from: safeData)
                completion(countryInfo)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
    
}

struct CountryInfo: Codable{
    let flags: FlagOfTheCountry
    let region:String
    let capital:[String]
    let latlng:[Double]
    let population:Double
    let currencies: [String:Currency]
    let area:Double
    let timezones:[String]
}

struct Currency:Codable{
    let name:String
}
/*
 [
 {
 "name": {
 "common": "Kazakhstan",
 "official": "Republic of Kazakhstan",
 "nativeName": {
 "kaz": {
 "official": "ÒšÐ°Ð·Ð°Ò›ÑÑ‚Ð°Ð½ Ð ÐµÑÐ¿ÑƒÐ±Ð»Ð¸ÐºÐ°ÑÑ‹",
 "common": "ÒšÐ°Ð·Ð°Ò›ÑÑ‚Ð°Ð½"
 },
 "rus": {
 "official": "Ð ÐµÑÐ¿ÑƒÐ±Ð»Ð¸ÐºÐ° ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½",
 "common": "ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½"
 }
 }
 },
 "tld": [
 ".kz",
 ".Ò›Ð°Ð·"
 ],
 "cca2": "KZ",
 "ccn3": "398",
 "cca3": "KAZ",
 "cioc": "KAZ",
 "independent": true,
 "status": "officially-assigned",
 "unMember": true,
 "currencies": {
 "KZT": {
 "name": "Kazakhstani tenge",
 "symbol": "â‚¸"
 }
 },
 "idd": {
 "root": "+7",
 "suffixes": [
 "6",
 "7"
 ]
 },
 "capital": [
 "Nur-Sultan"
 ],
 "altSpellings": [
 "KZ",
 "Qazaqstan",
 "ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½",
 "Republic of Kazakhstan",
 "ÒšÐ°Ð·Ð°Ò›ÑÑ‚Ð°Ð½ Ð ÐµÑÐ¿ÑƒÐ±Ð»Ð¸ÐºÐ°ÑÑ‹",
 "Qazaqstan RespublÃ¯kasÄ±",
 "Ð ÐµÑÐ¿ÑƒÐ±Ð»Ð¸ÐºÐ° ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½",
 "Respublika Kazakhstan"
 ],
 "region": "Asia",
 "subregion": "Central Asia",
 "languages": {
 "kaz": "Kazakh",
 "rus": "Russian"
 },
 "translations": {
 "ara": {
 "official": "Ø¬Ù…Ù‡ÙˆØ±ÙŠØ© ÙƒØ§Ø²Ø§Ø®Ø³ØªØ§Ù†",
 "common": "ÙƒØ§Ø²Ø§Ø®Ø³ØªØ§Ù†"
 },
 "bre": {
 "official": "Republik Kazakstan",
 "common": "Kazakstan"
 },
 "ces": {
 "official": "Republika KazachstÃ¡n",
 "common": "KazachstÃ¡n"
 },
 "cym": {
 "official": "Republic of Kazakhstan",
 "common": "Kazakhstan"
 },
 "deu": {
 "official": "Republik Kasachstan",
 "common": "Kasachstan"
 },
 "est": {
 "official": "Kasahstani Vabariik",
 "common": "Kasahstan"
 },
 "fin": {
 "official": "Kazakstanin tasavalta",
 "common": "Kazakstan"
 },
 "fra": {
 "official": "RÃ©publique du Kazakhstan",
 "common": "Kazakhstan"
 },
 "hrv": {
 "official": "Republika Kazahstan",
 "common": "Kazahstan"
 },
 "hun": {
 "official": "Kazah KÃ¶ztÃ¡rsasÃ¡g",
 "common": "KazahsztÃ¡n"
 },
 "ita": {
 "official": "Repubblica del Kazakhstan",
 "common": "Kazakistan"
 },
 "jpn": {
 "official": "ã‚«ã‚¶ãƒ•ã‚¹ã‚¿ãƒ³å…±å’Œå›½",
 "common": "ã‚«ã‚¶ãƒ•ã‚¹ã‚¿ãƒ³"
 },
 "kor": {
 "official": "ì¹´ìžíìŠ¤íƒ„ ê³µí™”êµ­",
 "common": "ì¹´ìžíìŠ¤íƒ„"
 },
 "nld": {
 "official": "Republiek Kazachstan",
 "common": "Kazachstan"
 },
 "per": {
 "official": "Ø¬Ù…Ù‡ÙˆØ±ÛŒ Ù‚Ø²Ø§Ù‚Ø³ØªØ§Ù†",
 "common": "Ù‚Ø²Ø§Ù‚Ø³ØªØ§Ù†"
 },
 "pol": {
 "official": "Republika Kazachstanu",
 "common": "Kazachstan"
 },
 "por": {
 "official": "RepÃºblica do CazaquistÃ£o",
 "common": "CazaquistÃ£o"
 },
 "rus": {
 "official": "Ð ÐµÑÐ¿ÑƒÐ±Ð»Ð¸ÐºÐ° ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½",
 "common": "ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½"
 },
 "slk": {
 "official": "KazaÅ¡skÃ¡ republika",
 "common": "Kazachstan"
 },
 "spa": {
 "official": "RepÃºblica de KazajstÃ¡n",
 "common": "KazajistÃ¡n"
 },
 "srp": {
 "official": "Ð ÐµÐ¿ÑƒÐ±Ð»Ð¸ÐºÐ° ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½",
 "common": "ÐšÐ°Ð·Ð°Ñ…ÑÑ‚Ð°Ð½"
 },
 "swe": {
 "official": "Republiken Kazakstan",
 "common": "Kazakstan"
 },
 "tur": {
 "official": "Kazakistan Cumhuriyeti",
 "common": "Kazakistan"
 },
 "urd": {
 "official": "Ø¬Ù…ÛÙˆØ±ÛŒÛ Ù‚Ø§Ø²Ù‚Ø³ØªØ§Ù†",
 "common": "Ù‚Ø§Ø²Ù‚Ø³ØªØ§Ù†"
 },
 "zho": {
 "official": "å“ˆè¨å…‹æ–¯å¦å…±å’Œå›½",
 "common": "å“ˆè¨å…‹æ–¯å¦"
 }
 },
 "latlng": [
 48.0196,
 66.9237
 ],
 "landlocked": true,
 "borders": [
 "CHN",
 "KGZ",
 "RUS",
 "TKM",
 "UZB"
 ],
 "area": 2724900,
 "demonyms": {
 "eng": {
 "f": "Kazakhstani",
 "m": "Kazakhstani"
 },
 "fra": {
 "f": "Kazakhstanaise",
 "m": "Kazakhstanais"
 }
 },
 "flag": "🇰🇿",
 "maps": {
 "googleMaps": "https://goo.gl/maps/8VohJGu7ShuzZYyeA",
 "openStreetMaps": "https://www.openstreetmap.org/relation/214665"
 },
 "population": 18754440,
 "gini": {
 "2018": 27.8
 },
 "fifa": "KAZ",
 "car": {
 "signs": [
 "KZ"
 ],
 "side": "right"
 },
 "timezones": [
 "UTC+05:00",
 "UTC+06:00"
 ],
 "continents": [
 "Asia"
 ],
 "flags": {
 "png": "https://flagcdn.com/w320/kz.png",
 "svg": "https://flagcdn.com/kz.svg",
 "alt": "The flag of Kazakhstan has a turquoise field, at the center of which is a gold sun with thirty-two rays above a soaring golden steppe eagle. A thin vertical band displays a national ornamental pattern â€” koshkar-muiz â€” in gold near the hoist end."
 },
 "coatOfArms": {
 "png": "https://mainfacts.com/media/images/coats_of_arms/kz.png",
 "svg": "https://mainfacts.com/media/images/coats_of_arms/kz.svg"
 },
 "startOfWeek": "monday",
 "capitalInfo": {
 "latlng": [
 51.16,
 71.45
 ]
 },
 "postalCode": {
 "format": "######",
 "regex": "^(\\d{6})$"
 }
 }
 ]
 */
