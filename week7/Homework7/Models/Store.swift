/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class Store: ObservableObject {
  static let shared = Store()
  
  @Published var apiResponse: ApiResponse?
  
  private init() {
    self.apiResponse = readJSON()
    if let apiResponse = apiResponse {
      writeJSON(apiResponse: apiResponse)
    } else {
      print("Failed writing to local dir")
    }
    
  }
  
  func readJSON() -> ApiResponse? {
    if let apiResponse = readFromBundle() {
      return apiResponse
    }
    
    if let apiResponse = readFromDocumentsDirectory() {
      return apiResponse
    }
    
    print("Data cannot be loaded from either the bundle or the local dir")
    return nil
  }
  
  
  private func readFromBundle() -> ApiResponse? {
    let decoder = JSONDecoder()
    
    guard let url = Bundle.main.url(forResource: "apilist", withExtension: "json") else {
      return nil
    }
    // Debug
    print(url)
    
    do {
      let data = try Data(contentsOf: url)
      let apiResponse = try decoder.decode(ApiResponse.self, from: data)
      return apiResponse
    } catch {
      print("Error reading from app bundle.", error)
      return nil
    }
  }
  
  private func readFromDocumentsDirectory() -> ApiResponse? {
    let URL = getUserDocsDirectory()
    let decoder = JSONDecoder()
    
    do {
      if FileManager.default.fileExists(atPath: URL.path) {
        let data = try Data(contentsOf: URL)
        let apiResponse = try decoder.decode(ApiResponse.self, from: data)
        return apiResponse
      } else {
        // Debug
        print("File couldn't be found in 'Documents'")
        return nil
      }
    } catch {
      print("Error reading from local dir", error)
      return nil
    }
  }
  
  func writeJSON(apiResponse: ApiResponse) {
    let encoder = JSONEncoder()
    let URL = getUserDocsDirectory()
    
    do {
      let jsonData = try encoder.encode(apiResponse)
      try jsonData.write(to: URL)
      print("Wrote to \(URL)")
    } catch {
      print("Error writing JSON to local dir")
    }
  }
  
  
  private func getUserDocsDirectory() -> URL {
    let fileManager = FileManager.default
    let docsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let URL = docsDirectory.appendingPathComponent("apilist.json")
    return URL
  }
}
