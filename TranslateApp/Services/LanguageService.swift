//
//  LanguageService.swift
//  TranslateApp
//
//  Created by Aydın Berovic on 9.03.2022.
//

import Foundation
import Alamofire


class LanguageService {
    
    func getLanguages(completion: @escaping ([Language]?)-> ()){
        
        let url =  "https://libretranslate.com/languages"
        print("URLRequest : \(url)")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let languages = try JSONDecoder().decode([Language].self, from: data)
                    print("languages :\(languages)")
                    completion(languages)
                    return
                } catch let err {
                    print("decoder fail \(err)")
                }
            case .failure(_):
                print("Req Error! ")
                completion(nil)
                return
            }
        }
    }
    func translateText(text: String, source: String, target: String, completion: @escaping (String?)-> ()){
        
        let url =  "https://libretranslate.de/translate"
        print("URLRequest : \(url)")
        let parameters: [String: Any] = ["q": text,
                                   "source": source,
                                   "target": target,
                                   "format": "text",
                                   "api_key": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
//                    let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                    print("text log: \(str)")
                    let textResponse = try JSONDecoder().decode(Translate.self, from: data)
                    if let text = textResponse.translatedText {
                        completion(text)
                        return
                    }
                    completion(nil)
                    return
                    
                } catch let err {
                    print("decoder fail \(err)")
                }
            case .failure(_):
                print("Req Error! ")
                completion(nil)
                return
            }
        }
    }
    
    func detectText(text: String, completion: @escaping (String?)-> ()){
        
        let url =  "https://libretranslate.de/detect"
        print("URLRequest : \(url)")
        let parameters: [String: Any] = ["q": text,
                                   "api_key": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let detectResponse = try JSONDecoder().decode([DetectResponse].self, from: data)
                    if let language = detectResponse[0].language {
                        completion(language)
                        return
                    }
                    completion(nil)
                    return
                    
                } catch let err {
                    print("decoder fail \(err)")
                }
            case .failure(_):
                print("Req Error! ")
                completion(nil)
                return
            }
        }
    }
}
