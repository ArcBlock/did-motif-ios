//
//  File.swift
//  
//
//  Created by zY on 2022/3/16.
//

import Foundation

private protocol Encoding {
    static var zeroAlphabet: Character { get }
    static var base: Int { get }

    // log(256) / log(base), rounded up
    static func sizeFromByte(size: Int) -> Int
    // log(base) / log(256), rounded up
    static func sizeFromBase(size: Int) -> Int

    // Public
    static func encode(_ bytes: Data, _ baseAlphabets: String) -> String
    static func decode(_ string: String, _ baseAlphabets: String) -> Data?
}

private struct _Base58: Encoding {
    static var zeroAlphabet: Character = "1"
    static var base: Int = 58

    static func sizeFromByte(size: Int) -> Int {
        return size * 138 / 100 + 1
    }
    static func sizeFromBase(size: Int) -> Int {
        return size * 733 / 1000 + 1
    }
}

public struct Base58 {
    public static func encode(_ bytes: Data, _ baseAlphabets: String) -> String {
        return _Base58.encode(bytes, baseAlphabets)
    }
    public static func decode(_ string: String, _ baseAlphabets: String) -> Data? {
        return _Base58.decode(string, baseAlphabets)
    }
}

public enum Base58String {
    public static let btcAlphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    public static let flickrAlphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
}

extension Data {
    public init?(base58Encoded string: String, alphabet: String = Base58String.btcAlphabet) {
        guard let data = Base58.decode(string, alphabet) else {
            return nil
        }
        self = data
    }
    
    public var bytes: Array<UInt8> {
      Array(self)
    }
}

extension Encoding {
    static func convertBytesToBase(_ bytes: Data) -> [UInt8] {
        var length = 0
        let size = sizeFromByte(size: bytes.count)
        var encodedBytes: [UInt8] = Array(repeating: 0, count: size)

        for b in bytes {
            var carry = Int(b)
            var i = 0
            for j in (0...encodedBytes.count - 1).reversed() where carry != 0 || i < length {
                carry += 256 * Int(encodedBytes[j])
                encodedBytes[j] = UInt8(carry % base)
                carry /= base
                i += 1
            }

            assert(carry == 0)

            length = i
        }

        var zerosToRemove = 0
        for b in encodedBytes {
            if b != 0 { break }
            zerosToRemove += 1
        }

        encodedBytes.removeFirst(zerosToRemove)
        return encodedBytes
    }

    static func encode(_ bytes: Data, _ baseAlphabets: String) -> String {
        var bytes = bytes
        var zerosCount = 0

        for b in bytes {
            if b != 0 { break }
            zerosCount += 1
        }

        bytes.removeFirst(zerosCount)

        let encodedBytes = convertBytesToBase(bytes)

        var str = ""
        while 0 < zerosCount {
            str += String(zeroAlphabet)
            zerosCount -= 1
        }

        for b in encodedBytes {
            str += String(baseAlphabets[String.Index(encodedOffset: Int(b))])
        }

        return str
    }

    static func decode(_ string: String, _ baseAlphabets: String) -> Data? {
        var zerosCount = 0
        var length = 0
        for c in string {
            if c != zeroAlphabet { break }
            zerosCount += 1
        }
        let size = sizeFromBase(size: string.lengthOfBytes(using: .utf8) - zerosCount)
        var decodedBytes: [UInt8] = Array(repeating: 0, count: size)
        for c in string {
            guard let baseIndex = baseAlphabets.index(of: c) else { return nil }

            var carry = baseIndex.encodedOffset
            var i = 0
            for j in (0...decodedBytes.count - 1).reversed() where carry != 0 || i < length {
                carry += base * Int(decodedBytes[j])
                decodedBytes[j] = UInt8(carry % 256)
                carry /= 256
                i += 1
            }

            assert(carry == 0)
            length = i
        }

        // skip leading zeros
        var zerosToRemove = 0

        for b in decodedBytes {
            if b != 0 { break }
            zerosToRemove += 1
        }
        decodedBytes.removeFirst(zerosToRemove)

        return Data(repeating: 0, count: zerosCount) + Data(decodedBytes)
    }
}
