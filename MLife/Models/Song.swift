//
//  Song.swift
//  MLife
//
//  Created by Nguyễn Hữu Toàn on 01/07/2022.
//

import Foundation

struct Song: Codable {
    let _id: String
    let album_id: String
    let artists: String
    let category_id: String
    let thumbnail: URL?
    let like: String
    let link: URL?
    let name_song: String
    let playlist_id: String
    let title: String
}

