//
//  Extensions.swift
//  Trajectory
//
//  Created by Jeremy Bost on 3/20/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

extension UIImage {
    static func compress(image: UIImage, maxFileSizeInKb: Int, compression: CGFloat = 1.0, maxCompression: CGFloat = 0.4) -> Data? {
        if let data = UIImageJPEGRepresentation(image, compression) {
            
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(data.count))
            print("Data size is: \(string)")
            
            if data.count > (maxFileSizeInKb * 1024) && (compression > maxCompression) {
                let newCompression = compression - 0.1
                let compressedData = self.compress(image: image, maxFileSizeInKb: maxFileSizeInKb, compression: newCompression, maxCompression: maxCompression)
                return compressedData
            }
            
            return data
        }
        
        return nil
    }
}
