//
//  JpegModel.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/22/23.
//

import Foundation

/*
 coingecko API info:
 
 https://pro-api.coingecko.com/api/v3/nfts/markets?asset_platform_id=ethereum&order=h24_volume_native_desc&per_page=250&page=1&x_cg_pro_api_key=CG-1msFvUPTdwKeaBLi3k34ckxK
 
 JASON data example:
 
     {
         "id": "archeworld_land",
         "contract_address": "0x56d23f924cd526e5590ed94193a892e913e38079",
         "asset_platform_id": "klay-token",
         "name": "ArcheWorld_Land",
         "image": {
         "small": "https://assets.coingecko.com/nft_contracts/images/1688/small/archeworld_land.png?1663925175"
         },
         "description": "This is the official Land NFT of ArcheWorld.\nThis verifies that the Land NFT owner can permanently own the land designated on seamless open-world of ArcheWorld.\nOwners can participate in production activities directly by installing buildings in the game, or they can lease their land to others and collect rent with Blue Salt(BSLT) every month.\nOwners may generate earnings by converting Blue Salt(BSLT) to BORA.",
         "native_currency": "klay-token",
         "floor_price": {
                 "native_currency": 2105.79,
                 "usd": 396.33
         },
         "market_cap": {
                 "native_currency": 4358977,
                 "usd": 820409
         },
         "volume_24h": {
                 "native_currency": 74533,
                 "usd": 14028.03
         },
         "floor_price_in_usd_24h_percentage_change": -5.24342,
         "number_of_unique_addresses": 694,
         "number_of_unique_addresses_24h_percentage_change": -0.57307,
         "total_supply": 2070
     } ...
 
 */


//struct Jpegs: Identifiable, Codable, Hashable {
//    let id, contractAddress, assetPlatformID, name: String?
//    let image: Image?
//    let description, nativeCurrency: String?
//    let floorPrice, marketCap, volume24H: FloorPrice?
//    let floorPriceInUsd24HPercentageChange: Double?
//    let numberOfUniqueAddresses: Int?
//    let numberOfUniqueAddresses24HPercentageChange: Double?
//    let totalSupply: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case contractAddress = "contract_address"
//        case assetPlatformID = "asset_platform_id"
//        case name, image, description
//        case nativeCurrency = "native_currency"
//        case floorPrice = "floor_price"
//        case marketCap = "market_cap"
//        case volume24H = "volume_24h"
//        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
//        case numberOfUniqueAddresses = "number_of_unique_addresses"
//        case numberOfUniqueAddresses24HPercentageChange = "number_of_unique_addresses_24h_percentage_change"
//        case totalSupply = "total_supply"
//    }
//
//}
//
//struct FloorPrice: Codable {
//    let nativeCurrency, usd: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case nativeCurrency = "native_currency"
//        case usd
//    }
//}
//
//struct Image: Codable {
//    let small: String?
//}
