//
//  ImageLoader.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import UIKit

struct ImageLoader {

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }.resume()
    }
}
