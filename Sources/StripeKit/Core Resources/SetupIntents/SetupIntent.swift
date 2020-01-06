//
//  SetupIntent.swift
//  
//
//  Created by Andrew Edwards on 11/28/19.
//

import Foundation

/// The [SetupIntent Object](https://stripe.com/docs/api/setup_intents/object).
public struct StripeSetupIntent: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the Connect application that created the SetupIntent.
    public var application: String?
    /// Reason for cancellation of this SetupIntent, one of `abandoned`, `requested_by_customer`, or `duplicate`.
    public var cancellationReason: StripeSetupIntentCancellationReason?
    /// The client secret of this SetupIntent. Used for client-side retrieval using a publishable key. The client secret can be used to complete payment setup from your frontend. It should not be stored, logged, embedded in URLs, or exposed to anyone other than the customer. Make sure that you have TLS enabled on any page that includes the client secret.
    public var clientSecret: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods attached to other Customers cannot be used with this SetupIntent.
    public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// The error encountered in the previous SetupIntent confirmation.
    public var lastSetupError: StripeError?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// ID of the multi use Mandate generated by the SetupIntent.
    public var mandate: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If present, this property tells you what actions you need to take in order for your customer to continue payment setup.
    public var nextAction: StripeSetupIntentNextAction?
    /// The account (if any) for which the setup is intended.
    public var onBehalfOf: String?
    /// ID of the payment method used with this SetupIntent.
    public var paymentMethod: String?
    /// Payment-method-specific configuration for this SetupIntent.
    public var paymentMethodOptions: StripeSetupIntentPaymentMethodOptions?
    /// The list of payment method types (e.g. card) that this SetupIntent is allowed to set up.
    public var paymentMethodTypes: [String]?
    /// ID of the single_use Mandate generated by the SetupIntent.
    public var singleUseMandate: String?
    /// Status of this SetupIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `canceled`, or `succeeded`.
    public var status: StripeSetupIntentStatus?
    /// Indicates how the payment method is intended to be used in the future.
    /// Use `on_session` if you intend to only reuse the payment method when the customer is in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. If not provided, this value defaults to `off_session`.
    public var usage: String?
}

public enum StripeSetupIntentCancellationReason: String, StripeModel {
    case abandoned
    case requestedByCustomer = "requested_by_customer"
    case duplicate
}

public struct StripeSetupIntentNextAction: StripeModel {
    /// Contains instructions for authenticating by redirecting your customer to another page or application.
    public var redirectToUrl: StripeSetupIntentNextActionRedirectToUrl?
    /// Type of the next action to perform, one of redirect_to_url or use_stripe_sdk.
    public var type: StripeSetupIntentNextActionType?
}

public struct StripeSetupIntentNextActionRedirectToUrl: StripeModel {
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
    /**
     https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-use_stripe_sdk
     Stripe .net doesn't implement the `use_stripe_sdk` property (probably due to its dynamic nature) so neither am I :)
     https://github.com/stripe/stripe-dotnet/blob/master/src/Stripe.net/Entities/PaymentIntents/PaymentIntentNextAction.cs
     */
}

public enum StripeSetupIntentNextActionType: String, StripeModel {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
}

public struct StripeSetupIntentPaymentMethodOptions: StripeModel {
    /// If the SetupIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var card: StripeSetupIntentPaymentMethodOptionsCard?
}

public struct StripeSetupIntentPaymentMethodOptionsCard: StripeModel {
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Permitted values include: `automatic` or `any`. If not provided, defaults to `automatic`. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: String?
}

public enum StripeSetupIntentStatus: String, StripeModel {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case canceled
    case succeeded
}

public struct StripeSetupIntentsList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSetupIntent]?
}
