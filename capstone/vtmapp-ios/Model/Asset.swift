//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/8/24.
//
import SwiftUI

struct Asset: Identifiable, Codable {
    let id: Int
    let uuid: String
    let token: String
    let teamID: Int
    let userID: Int
    let legacyVideoID: Int?
    let title: String
    let slug: String?
    let locale: String
    let channel: String
    let type: String
    let contentDetails: ContentDetails?
    let status: Status
    let statistics: Statistics
    let description: String?
    let summary: String?
    let fileID: Int
    let isPDF: Bool
    let isVideo: Bool
    let thumbnailPath: String?
    let thumbnailPathHash: String?
    let thumbnailFileID: Int?
    let watchURL: String?
    let width: Int
    let height: Int
    let aspectRatio: Double
    let duration: Int?
    let durationMS: Int?
    let formattedDuration: String?
    let metadata: Metadata?
    let createdAt: String
    let createdAtDiff: String
    let updatedAt: String
    let updatedAtDiff: String
    let thumbnail: Thumbnail?
    let file: File?

    enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case token
        case teamID = "team_id"
        case userID = "user_id"
        case legacyVideoID = "legacy_video_id"
        case title
        case slug
        case locale
        case channel
        case type
        case contentDetails = "content_details"
        case status
        case statistics
        case description
        case summary
        case fileID = "file_id"
        case isPDF = "is_pdf"
        case isVideo = "is_video"
        case thumbnailPath = "thumbnail_path"
        case thumbnailPathHash = "thumbnail_path_hash"
        case thumbnailFileID = "thumbnail_file_id"
        case watchURL = "watch_url"
        case width
        case height
        case aspectRatio = "aspect_ratio"
        case duration
        case durationMS = "duration_ms"
        case formattedDuration = "formatted_duration"
        case metadata
        case createdAt = "created_at"
        case createdAtDiff = "created_at_diff"
        case updatedAt = "updated_at"
        case updatedAtDiff = "updated_at_diff"
        case thumbnail
        case file
    }

    struct ContentDetails: Codable {
        let duration: String?
        let dimension: String?
        let definition: String?
        let caption: String?
    }

    struct Status: Codable {
        let status: String
        let isDraft: Bool
        let isActive: Bool
        let isInactive: Bool
        let isError: Bool
        let uploadStatus: String?
        let failureReason: String?
        let rejectionReason: String?
        let privacyStatus: String?
        let publishAt: String?

        enum CodingKeys: String, CodingKey {
            case status
            case isDraft = "is_draft"
            case isActive = "is_active"
            case isInactive = "is_inactive"
            case isError = "is_error"
            case uploadStatus = "upload_status"
            case failureReason = "failure_reason"
            case rejectionReason = "rejection_reason"
            case privacyStatus = "privacy_status"
            case publishAt = "publish_at"
        }
    }

    struct Statistics: Codable {
        let comments: Int
        let favorites: Int
        let views: Int
        let likes: Int
        let dislikes: Int
        let votes: Int
    }

    struct Metadata: Codable {
        let dimensions: Dimensions?
        let duration: Duration?

        struct Dimensions: Codable {
            let width: Int
            let height: Int
        }

        struct Duration: Codable {
            let ms: Int
            let s: Int
        }
    }

    struct Thumbnail: Codable {
        let id: Int
        let teamID: Int
        let assetID: Int
        let path: String
        let pathHash: String
        let mimeType: String
        let sha1Hash: String
        let size: Int
        let url: String
        let createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case teamID = "team_id"
            case assetID = "asset_id"
            case path
            case pathHash = "path_hash"
            case mimeType = "mime_type"
            case sha1Hash = "sha1_hash"
            case size
            case url
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

    struct File: Codable {
        let id: Int
        let teamID: Int
        let assetID: Int
        let path: String
        let pathHash: String
        let mimeType: String
        let sha1Hash: String
        let size: Int
        let url: String
        let createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case teamID = "team_id"
            case assetID = "asset_id"
            case path
            case pathHash = "path_hash"
            case mimeType = "mime_type"
            case sha1Hash = "sha1_hash"
            case size
            case url
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}
