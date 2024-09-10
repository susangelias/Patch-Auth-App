// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ValidateOtpMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ValidateOTP($code: String!) {
      validateOTP(code: $code) {
        __typename
        code
        expiresAt
        refreshToken
        token
        twilioSid
        userId
        validated
      }
    }
    """

  public let operationName: String = "ValidateOTP"

  public var code: String

  public init(code: String) {
    self.code = code
  }

  public var variables: GraphQLMap? {
    return ["code": code]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("validateOTP", arguments: ["code": GraphQLVariable("code")], type: .object(ValidateOtp.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(validateOtp: ValidateOtp? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "validateOTP": validateOtp.flatMap { (value: ValidateOtp) -> ResultMap in value.resultMap }])
    }

    public var validateOtp: ValidateOtp? {
      get {
        return (resultMap["validateOTP"] as? ResultMap).flatMap { ValidateOtp(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "validateOTP")
      }
    }

    public struct ValidateOtp: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["OTP"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(String.self))),
          GraphQLField("expiresAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("refreshToken", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
          GraphQLField("twilioSid", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("validated", type: .nonNull(.scalar(Bool.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, expiresAt: String, refreshToken: String, token: String, twilioSid: String, userId: String? = nil, validated: Bool) {
        self.init(unsafeResultMap: ["__typename": "OTP", "code": code, "expiresAt": expiresAt, "refreshToken": refreshToken, "token": token, "twilioSid": twilioSid, "userId": userId, "validated": validated])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var expiresAt: String {
        get {
          return resultMap["expiresAt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "expiresAt")
        }
      }

      public var refreshToken: String {
        get {
          return resultMap["refreshToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "refreshToken")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var twilioSid: String {
        get {
          return resultMap["twilioSid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "twilioSid")
        }
      }

      public var userId: String? {
        get {
          return resultMap["userId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var validated: Bool {
        get {
          return resultMap["validated"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "validated")
        }
      }
    }
  }
}

public final class GetTwilioAccessTokenMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation GetTwilioAccessToken {
      getTwilioAccessToken {
        __typename
        factorType
        identity
        serviceSid
        token
      }
    }
    """

  public let operationName: String = "GetTwilioAccessToken"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getTwilioAccessToken", type: .object(GetTwilioAccessToken.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getTwilioAccessToken: GetTwilioAccessToken? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "getTwilioAccessToken": getTwilioAccessToken.flatMap { (value: GetTwilioAccessToken) -> ResultMap in value.resultMap }])
    }

    public var getTwilioAccessToken: GetTwilioAccessToken? {
      get {
        return (resultMap["getTwilioAccessToken"] as? ResultMap).flatMap { GetTwilioAccessToken(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getTwilioAccessToken")
      }
    }

    public struct GetTwilioAccessToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TwilioAccessToken"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("factorType", type: .nonNull(.scalar(String.self))),
          GraphQLField("identity", type: .nonNull(.scalar(String.self))),
          GraphQLField("serviceSid", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(factorType: String, identity: String, serviceSid: String, token: String) {
        self.init(unsafeResultMap: ["__typename": "TwilioAccessToken", "factorType": factorType, "identity": identity, "serviceSid": serviceSid, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var factorType: String {
        get {
          return resultMap["factorType"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "factorType")
        }
      }

      public var identity: String {
        get {
          return resultMap["identity"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "identity")
        }
      }

      public var serviceSid: String {
        get {
          return resultMap["serviceSid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "serviceSid")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}
