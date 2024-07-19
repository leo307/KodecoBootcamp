//
//  AssetUnitTests.swift
//  vtmapp-iosTests
//
//  Created by Leo DelPrete on 7/18/24.
//
import XCTest
@testable import vtmapp_ios

class AssetTests: XCTestCase {
    func testDecodeAsset() {
        let decoder = JSONDecoder()
        let jsonString = """
        {
            "id": 1,
            "uuid": "uuid",
            "token": "token",
            "team_id": 123,
            "user_id": 456,
            "legacy_video_id": 789,
            "title": "Sample Asset",
            "slug": "sample-asset",
            "locale": "en",
            "channel": "channel",
            "type": "video",
            "content_details": {
                "duration": "5min",
                "dimension": "720p",
                "definition": "HD",
                "caption": "English"
            },
            "status": {
                "status": "active",
                "is_draft": false,
                "is_active": true,
                "is_inactive": false,
                "is_error": false,
                "upload_status": "uploaded",
                "failure_reason": null,
                "rejection_reason": null,
                "privacy_status": "public",
                "publish_at": "2024-07-18T00:00:00Z"
            },
            "statistics": {
                "comments": 10,
                "favorites": 5,
                "views": 100,
                "likes": 20,
                "dislikes": 2,
                "votes": 30
            },
            "description": "This is a sample asset description.",
            "summary": "Summary of the asset.",
            "file_id": 101,
            "is_pdf": false,
            "is_video": true,
            "thumbnail_path": "path/to/thumbnail",
            "thumbnail_path_hash": "hash",
            "thumbnail_file_id": 202,
            "watch_url": "http://example.com/watch",
            "width": 1920,
            "height": 1080,
            "aspect_ratio": 1.78,
            "duration": 300,
            "duration_ms": 300000,
            "formatted_duration": "5 minutes",
            "metadata": {
                "dimensions": {
                    "width": 1920,
                    "height": 1080
                },
                "duration": {
                    "ms": 300000,
                    "s": 300
                }
            },
            "created_at": "2024-07-18T00:00:00Z",
            "created_at_diff": "0 days ago",
            "updated_at": "2024-07-18T00:00:00Z",
            "updated_at_diff": "0 days ago",
            "thumbnail": {
                "id": 1,
                "team_id": 123,
                "asset_id": 1,
                "path": "path/to/thumbnail",
                "path_hash": "hash",
                "mime_type": "image/jpeg",
                "sha1_hash": "sha1",
                "size": 2048,
                "url": "http://example.com/thumbnail",
                "created_at": "2024-07-18T00:00:00Z",
                "updated_at": "2024-07-18T00:00:00Z"
            },
            "file": {
                "id": 1,
                "team_id": 123,
                "asset_id": 1,
                "path": "path/to/file",
                "path_hash": "hash",
                "mime_type": "video/mp4",
                "sha1_hash": "sha1",
                "size": 104857600,
                "url": "http://example.com/video",
                "created_at": "2024-07-18T00:00:00Z",
                "updated_at": "2024-07-18T00:00:00Z"
            }
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let asset = try? decoder.decode(Asset.self, from: jsonData)

        XCTAssertNotNil(asset)
        XCTAssertEqual(asset?.id, 1)
        XCTAssertEqual(asset?.title, "Sample Asset")
        XCTAssertEqual(asset?.status.status, "active")
        XCTAssertEqual(asset?.statistics.comments, 10)
        XCTAssertEqual(asset?.metadata?.dimensions?.width, 1920)
    }

    func testDecodeAssetWithMissingFields() {
        let decoder = JSONDecoder()
        let jsonString = """
        {
            "id": 1,
            "uuid": "uuid",
            "token": "token",
            "team_id": 123,
            "user_id": 456,
            "title": "Sample Asset",
            "locale": "en",
            "channel": "channel",
            "type": "video",
            "status": {
                "status": "active",
                "is_draft": false,
                "is_active": true,
                "is_inactive": false,
                "is_error": false,
                "upload_status": "uploaded",
                "failure_reason": null,
                "rejection_reason": null,
                "privacy_status": "public",
                "publish_at": "2024-07-18T00:00:00Z"
            },
            "statistics": {
                "comments": 10,
                "favorites": 5,
                "views": 100,
                "likes": 20,
                "dislikes": 2,
                "votes": 30
            },
            "created_at": "2024-07-18T00:00:00Z",
            "created_at_diff": "0 days ago",
            "updated_at": "2024-07-18T00:00:00Z",
            "updated_at_diff": "0 days ago"
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let asset = try? decoder.decode(Asset.self, from: jsonData)

        
        XCTAssertNil(asset?.description)
    }

    func testDecodeAssetWithInvalidJSON() {
        let decoder = JSONDecoder()
        let jsonString = """
        {
            "id": "invalid_id",
            "uuid": "uuid",
            "token": "token"
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let asset = try? decoder.decode(Asset.self, from: jsonData)

        XCTAssertNil(asset)
    }
}
