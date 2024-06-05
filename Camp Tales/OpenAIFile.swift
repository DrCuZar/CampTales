//
//  OpenAIFile.swift
//  Camp Tales
//
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

class OpenAIService {
    
    static let shared = OpenAIService()
    
    private init() {}
    
    private func generateAIRequest(httpMethod: HTTPMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        //Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        //Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(API.key)", forHTTPHeaderField: "Authorization")
        //Body
        //system message being sent to chatgpt before
        let systemMessage = GPTMessage(role: "system", content: "I want you to generate eight words that correspond with a genre.  I will give you the genre and you will give something cohesive to the introduction of the story.  You will not make a summary, but only the introduction.  Please try to incorporate at least 2 words that aren't commonly used that match the genre.  Don't reuse the same words when another request is made.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let genre = GPTFunctionProperty(type: "string", description: "The selected genre is \(message). Give me the genre.")
        let words = GPTFunctionProperty(type: "string", description: "The recommended words to give.")
        
        let params: [String: GPTFunctionProperty] = [
            "genre": genre,
            "words": words
        ]
        
        let functionParam = GPTFunctionParam(type: "object", properties: params, required: ["genre", "words"])
        let function = GPTFunction(name: "get_recipe", description: "Get the recipe with the given ingredients", parameters: functionParam)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        return urlRequest
    }
    
    //Encoding

    struct GPTChatPayload: Encodable {
        let model: String
        let messages: [GPTMessage]
        let functions: [GPTFunction]
    }
    struct GPTMessage: Encodable {
        let role: String
        let content: String
    }

    struct GPTFunction: Encodable {
        let name: String
        let description: String
        let parameters: GPTFunctionParam
    }

    struct GPTFunctionParam: Encodable {
        let type: String
        let properties: [String: GPTFunctionProperty]?
        let required: [String]?
    }

    struct GPTFunctionProperty: Encodable {
        let type: String
        let description: String
    }

    //Decoding

    struct GPTResponse: Decodable {
        let choices: [GPTCompletion]
    }

    struct GPTCompletion: Decodable {
        let message: GPTResponseMessage
    }

    struct GPTResponseMessage: Decodable {
        let functionCall: GPTFunctionCall
        
        enum CodingKeys: String, CodingKey {
            case functionCall = "function_call"
        }
    }

    struct GPTFunctionCall: Decodable {
        let name: String
        let arguments: String
    }
    
    struct GenreResponse: Decodable {
        let genre: String
        let words: String
    }

}
