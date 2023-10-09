//
//  MarketDataModel.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import Foundation

/*
 coingecko API info:
 https://api.coingecko.com/api/v3/global
 
 JASON data example:
 {
   "data": {
     "active_cryptocurrencies": 10242,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 876,
     "total_market_cap": {
       "btc": 41013487.22211729,
       "eth": 679691168.8121608,
       "ltc": 17082734828.06399,
       "bch": 4842670824.1241455,
       "bnb": 5264574689.469515,
       "eos": 1866916123953.0315,
       "xrp": 2195670495332.1982,
       "xlm": 10150296947257.885,
       "link": 149375183068.34543,
       "dot": 275091971438.3309,
       "yfi": 215241845.48182163,
       "usd": 1125294844946.296,
       "aed": 4133207965487.744,
       "ars": 393864336150168,
       "aud": 1786295287457.4375,
       "bdt": 124122288866688.64,
       "bhd": 424223778301.46045,
       "bmd": 1125294844946.296,
       "brl": 5774675555810.918,
       "cad": 1542841123637.8418,
       "chf": 1036550717589.2941,
       "clp": 1030848848609949.6,
       "cny": 8099984823407.933,
       "czk": 26354352379784.51,
       "dkk": 8017579481912.499,
       "eur": 1075107820156.5356,
       "gbp": 931512320877.4731,
       "hkd": 8813269840299.793,
       "huf": 418468858421943.75,
       "idr": 17561886436932984,
       "ils": 4329178062735.1304,
       "inr": 93651145447909.47,
       "jpy": 167682716758848.53,
       "krw": 1532450565148111.2,
       "kwd": 347866896597.6277,
       "lkr": 364661542934088.44,
       "mmk": 2364177608713657,
       "mxn": 20169255912240.254,
       "myr": 5315330200103.807,
       "ngn": 861975851228861.9,
       "nok": 12350999906213.076,
       "nzd": 1906665826431.6506,
       "php": 63975827422898.89,
       "pkr": 321524869572279.8,
       "pln": 4975648698208.3125,
       "rub": 111606738220594.14,
       "sar": 4220466703649.3916,
       "sek": 12503795816144.43,
       "sgd": 1545718502556.3708,
       "thb": 41746188157817.695,
       "try": 30958760682170.816,
       "twd": 36435245482314.26,
       "uah": 41257172152934.016,
       "vef": 112675772824.4726,
       "vnd": 27446241853623204,
       "zar": 21740286797038.844,
       "xdr": 856174956303.164,
       "xag": 53131324992.71636,
       "xau": 616897886.9480089,
       "bits": 41013487222117.29,
       "sats": 4101348722211729
     },
     "total_volume": {
       "btc": 1606944.6370885493,
       "eth": 26630900.042319406,
       "ltc": 669316631.6264796,
       "bch": 189740118.11936206,
       "bnb": 206270684.03081325,
       "eos": 73147421896.44002,
       "xrp": 86028308399.60669,
       "xlm": 397697595328.0154,
       "link": 5852651544.742413,
       "dot": 10778346298.984163,
       "yfi": 8433365.526829239,
       "usd": 44090045463.2565,
       "aed": 161942736986.5411,
       "ars": 15431952403589.842,
       "aud": 69988626348.4642,
       "bdt": 4863220856038.786,
       "bhd": 16621462149.147655,
       "bmd": 44090045463.2565,
       "brl": 226256886303.7938,
       "cad": 60449877282.62506,
       "chf": 40612972207.88762,
       "clp": 40389567947525.24,
       "cny": 317364556249.0666,
       "czk": 1032586792517.3295,
       "dkk": 314135842219.7917,
       "eur": 42123673525.64071,
       "gbp": 36497475094.210915,
       "hkd": 345311692916.6328,
       "huf": 16395979307681.871,
       "idr": 688090214668917.5,
       "ils": 169621018403.96677,
       "inr": 3669334556208.1855,
       "jpy": 6569956877082.138,
       "krw": 60042766027954.11,
       "kwd": 13629732114.238314,
       "lkr": 14287761184432.096,
       "mmk": 92630565864160.53,
       "mxn": 790249252562.0406,
       "myr": 208259329745.6912,
       "ngn": 33772974824854.45,
       "nok": 483923080095.1549,
       "nzd": 74704850331.57773,
       "php": 2506629397879.878,
       "pkr": 12597628239988.94,
       "pln": 194950308622.1524,
       "rub": 4372850532685.5938,
       "sar": 165361611381.8975,
       "sek": 489909758738.2927,
       "sgd": 60562615528.87467,
       "thb": 1635652506595.8901,
       "try": 1212991574690.9263,
       "twd": 1427565083937.457,
       "uah": 1616492427809.0627,
       "vef": 4414736252.235872,
       "vnd": 1075367986049498,
       "zar": 851803629573.5657,
       "xdr": 33545690640.49137,
       "xag": 2081732218.8690186,
       "xau": 24170603.82341185,
       "bits": 1606944637088.5493,
       "sats": 160694463708854.94
     },
     "market_cap_percentage": {
       "btc": 47.55289374535943,
       "eth": 17.69119968082459,
       "usdt": 7.405523640785009,
       "bnb": 2.9215697665770155,
       "xrp": 2.4258969018127434,
       "usdc": 2.239312774067284,
       "steth": 1.2940603471949812,
       "sol": 0.8864928228922037,
       "ada": 0.8137907055882811,
       "doge": 0.7722587073182506
     },
     "market_cap_change_percentage_24h_usd": -1.7055050092490878,
     "updated_at": 1696355830
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()

        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asNumberString()
        }
        return ""
    }
    
}

