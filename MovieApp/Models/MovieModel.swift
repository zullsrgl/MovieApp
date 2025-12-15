//
//  MovieModel.swift
//  MovieApp
//
//  Created by Zülal Sarıoğlu on 14.12.2025.
//



struct MovieResponse: Decodable {
    let page: Int?
    let results: [Movie]
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let genreIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
    }
}


enum MovieGenreType: Int, CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case sciFi = 878
    case thriller = 53
    case war = 10752
    case western = 37
    
    var title: String {
        switch self {
        case .action: return "Aksiyon"
        case .adventure: return "Macera"
        case .animation: return "Animasyon"
        case .comedy: return "Komedi"
        case .crime: return "Suç"
        case .documentary: return "Belgesel"
        case .drama: return "Dram"
        case .family: return "Aile"
        case .fantasy: return "Fantastik"
        case .history: return "Tarih"
        case .horror: return "Korku"
        case .music: return "Müzik"
        case .mystery: return "Gizem"
        case .romance: return "Romantik"
        case .sciFi: return "Bilim Kurgu"
        case .thriller: return "Gerilim"
        case .war: return "Savaş"
            case .western: return "Western" }
    }
}
