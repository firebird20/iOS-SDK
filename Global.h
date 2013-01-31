//
//  global.h
//  PayoneMobileSdk
//
//  Created by Rainer Grinninger on 19.06.12.
//  Copyright (c) 2012 Exozet GmbH. All rights reserved.
//

//region Default parameters
// Extended debug output
#if DEBUG
    #define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else

#define DebugLog( s, ... ) 

#endif

#if DEBUG
    #define ASIHTTPREQUEST_DEBUG 1
    #define DEBUG_FORM_DATA_REQUEST 1
    #define DEBUG_REQUEST_STATUS 1
    #define DEBUG_THROTTLING 1
    #define DEBUG_PERSISTENT_CONNECTIONS 1
#endif

/*#define PayoneParameters_MID               @"mid" 
#define PayoneParameters_PORTALID               @"portalid"
#define PayoneParameters_MODE               @"mode"
#define PayoneParameters_REQUEST               @"request"
#define PayoneParameters_RESPONSETYPE               @"responsetype"
#define PayoneParameters_HASH               @"hash"
#define PayoneParameters_SUCCESSURL               @"successurl"
#define PayoneParameters_ERRORURL               @"errorurl"
#define PayoneParameters_BACKURL               @"backurl"
#define PayoneParameters_EXITURL               @"exiturl"

//region parameters

#define PayoneParameters_AID               @"aid"
#define PayoneParameters_CARDPAN               @"cardpan"
#define PayoneParameters_CARDTYPE               @"cardtype"
#define PayoneParameters_CARDEXPIREDATE               @"cardexpiredate"
#define PayoneParameters_CARDCVC2               @"cardcvc2"
#define PayoneParameters_CARDHOLDER               @"cardholder"
#define PayoneParameters_ENCODING               @"encoding"
#define PayoneParameters_STORECARDDATA               @"storecarddata"
#define PayoneParameters_LANGUAGE               @"language"
#define PayoneParameters_CLEARINGTYPE               @"clearingtype"
#define PayoneParameters_REFERENCE               @"reference"
#define PayoneParameters_AMOUNT               @"amount"
#define PayoneParameters_CURRENCY               @"currency"
#define PayoneParameters_PARAM               @"param"
#define PayoneParameters_CUSTOMERID               @"customerid"
#define PayoneParameters_USERID               @"userid"
#define PayoneParameters_SALUTATION               @"salutation"
#define PayoneParameters_TITLE               @"title"
#define PayoneParameters_FIRSTNAME               @"firstname"
#define PayoneParameters_LASTNAME               @"lastname"
#define PayoneParameters_COMPANY               @"company"
#define PayoneParameters_STREET               @"street"
#define PayoneParameters_ADDRESSADDITION               @"addressaddition"
#define PayoneParameters_ZIP               @"zip"
#define PayoneParameters_CITY               @"city"
#define PayoneParameters_COUNTRY               @"country"
#define PayoneParameters_EMAIL               @"email"
#define PayoneParameters_TELEPHONENUMBER               @"telephonenumber"
#define PayoneParameters_BIRTHDAY               @"birthday"
#define PayoneParameters_VATID               @"Vatid"
#define PayoneParameters_IP               @"ip"
#define PayoneParameters_PSEUDOCARDPAN               @"pseudocardpan"
#define PayoneParameters_TRUNCATEDCARDPAN               @"truncatedcardpan"
#define PayoneParameters_SHIPPING_FIRSTNAME               @"shipping_firstname"
#define PayoneParameters_SHIPPING_LASTNAME               @"shipping_lastname"
#define PayoneParameters_SHIPPING_COMPANY               @"shipping_company"
#define PayoneParameters_SHIPPING_STREET               @"shipping_street"
#define PayoneParameters_SHIPPING_ZIP               @"shipping_zip"
#define PayoneParameters_SHIPPING_CITY               @"shipping_city"
#define PayoneParameters_SHIPPING_COUNTRY               @"shipping_country"
#define PayoneParameters_BANKCOUNTRY               @"bankcountry"
#define PayoneParameters_BANKACCOUNT               @"bankaccount"
#define PayoneParameters_BANKCODE               @"bankcode"
#define PayoneParameters_BANKACCOUNTHOLDER               @"Bankaccountholder"
#define PayoneParameters_ONLINEBANKTRANSFERTYPE               @"onlinebanktransfertype"
#define PayoneParameters_BANKGROUPTYPE               @"bankgrouptype"
#define PayoneParameters_WALLETTYPE               @"wallettype"
#define PayoneParameters_TXID               @"txid"
#define PayoneParameters_REDIRECTURL               @"redirecturl"
#define PayoneParameters_CLEARING_BANKACCOUNTHOLDER               @"clearing_bankaccountholder"
#define PayoneParameters_CLEARING_BANKCOUNTRY               @"clearing_bankcountry"
#define PayoneParameters_CLEARING_BANKACCOUNT               @"clearing_bankaccount"
#define PayoneParameters_CLEARING_BANKCODE               @"clearing_bankcode"
#define PayoneParameters_CLEARING_BANKIBAN               @"clearing_bankiban"
#define PayoneParameters_CLEARING_BANKBIC               @"clearing_bankbic"
#define PayoneParameters_CLEARING_BANKCITY               @"clearing_bankcity"
#define PayoneParameters_CLEARING_BANKNAME               @"clearing_bankname"

#define PayoneParameters_NARRATIVE_TEXT               @"narrative_text"
#define PayoneParameters_VREFERENCE               @"vreference"
#define PayoneParameters_VACCOUNTNAME               @"vaccountname"
#define PayoneParameters_SETTLETIME               @"settletime"
#define PayoneParameters_SETTLEPERIOD               @"settleperiod"
#define PayoneParameters_ACCESS_VAT               @"access_vat"
#define PayoneParameters_ACCESS_PERIOD               @"access_period"
#define PayoneParameters_ACCESS_ABOPERIOD               @"access_aboperiod"
#define PayoneParameters_ACCESS_PRICE               @"access_price"
#define PayoneParameters_ACCESS_ABOPRICE               @"access_aboprice"
#define PayoneParameters_ACCESS_STARTTIME               @"access_starttime"
#define PayoneParameters_ACCESS_CANCELTIME               @"access_canceltime"
#define PayoneParameters_ACCESS_EXPIRETIME               @"access_expiretime"
#define PayoneParameters_ACCESSCODE               @"accesscode"
#define PayoneParameters_ACCESSNAME               @"accessname"
#define PayoneParameters_PRODUCTID               @"productid"
#define PayoneParameters_ECI               @"eci"
#define PayoneParameters_INVOICE_DELIVERYMODE               @"invoice_deliverymode"
#define PayoneParameters_INVOICEAPPENDIX               @"invoiceappendix"
#define PayoneParameters_INVOICEID               @"invoiceid"
#define PayoneParameters_CONSUMERSCORETYPE               @"consumerscoretype"
#define PayoneParameters_ADDRESSCHECKTYPE               @"addresschecktype"
#define PayoneParameters_DUE_TIME               @"due_time"        
#define PayoneParameters_CHECKTYPE               @"checktype"

//region Response parameters
#define PayoneParameters_STATUS               @"status"
#define PayoneParameters_ERRORCODE               @"errorcode"
#define PayoneParameters_ERRORMESSAGE               @"errormessage"
#define PayoneParameters_CUSTOMERMESSAGE               @"customermessage"

//region Modul invoicing placeholder parameter
#define PayoneParameters_ID_REGEX_PLACEHOLDER               @"id\\[(\\d+)\\]"
#define PayoneParameters_PR_REGEX_PLACEHOLDER               @"pr\\[(\\d+)\\]"
#define PayoneParameters_NO_REGEX_PLACEHOLDER               @"no\\[(\\d+)\\]"
#define PayoneParameters_DE_REGEX_PLACEHOLDER               @"de\\[(\\d+)\\]"
#define PayoneParameters_VA_REGEX_PLACEHOLDER               @"va\\[(\\d+)\\]"

#define PayoneParameters_ID_PLACEHOLDER               @"id[%d]"
#define PayoneParameters_PR_PLACEHOLDER               @"pr[%d]"
#define PayoneParameters_NO_PLACEHOLDER               @"no[%d]"
#define PayoneParameters_DE_PLACEHOLDER               @"de[%d]"
#define PayoneParameters_VA_PLACEHOLDER               @"va[%d]"

//  ResponseErrorCodes
#define PayoneParameters_ResponseErrorCodes_VALID               @"VALID"
#define PayoneParameters_ResponseErrorCodes_INVALID               @"INVALID"
#define PayoneParameters_ResponseErrorCodes_APPROVED               @"APPROVED"
#define PayoneParameters_ResponseErrorCodes_REDIRECT               @"REDIRECT"
#define PayoneParameters_ResponseErrorCodes_ERROR               @"ERROR"


//public static class CreditCardVariations_

#define PayoneParameters_CreditCardVariations_MASTERCARD               @"M"
#define PayoneParameters_CreditCardVariations_VISA               @"V"
#define PayoneParameters_CreditCardVariations_AMEX               @"A"
#define PayoneParameters_CreditCardVariations_DINERS               @"D"
#define PayoneParameters_CreditCardVariations_JCB               @"J"
#define PayoneParameters_CreditCardVariations_MAESTRO_INTERNATIONAL               @"O"
#define PayoneParameters_CreditCardVariations_MAESTRO_UK               @"U"
#define PayoneParameters_CreditCardVariations_DISCOVER               @"C"
#define PayoneParameters_CreditCardVariations_CARTE_BLEUE               @"B"


// RequestParameter_
#define PayoneParameters_RequestParameter_CREDITCARDCHECK               @"creditcardcheck"
#define PayoneParameters_RequestParameter_PREAUTHORIZATION               @"preauthorization"
#define PayoneParameters_RequestParameter_AUTHORIZATION               @"authorization"


// ResponseTypeParameter_
#define PayoneParameters_ResponseTypeParameter_JSON               @"JSON"
#define PayoneParameters_ResponseTypeParameter_REDIRECT               @"REDIRECT"


// EncodingParameter_
#define PayoneParameters_UTF_8               @"UTF-8"
#define PayoneParameters_ISO_8859_1               @"ISO-8859-1"


// ModeParameter_
#define PayoneParameters_ModeParameter_TEST               @"test"
#define PayoneParameters_ModeParameter_LIVE               @"live"


// StoreCardDataParameter_
#define PayoneParameters_StoreCardDataParameter_YES               @"yes"
#define PayoneParameters_StoreCardDataParameter_NO               @"no"


// ClearingTypeParameter_
#define PayoneParameters_ClearingTypeParameter_DEBIT               @"elv"
#define PayoneParameters_ClearingTypeParameter_CREDITCARD               @"cc"
#define PayoneParameters_ClearingTypeParameter_PREPAYMENT               @"vor"
#define PayoneParameters_ClearingTypeParameter_BILL               @"rec"
#define PayoneParameters_ClearingTypeParameter_ONLINETRANSFER               @"sb"
#define PayoneParameters_ClearingTypeParameter_EWALLET               @"wlt"


// BankCountryParameter_
#define PayoneParameters_BankCountryParameter_DE               @"DE"
#define PayoneParameters_BankCountryParameter_AT               @"AT"
#define PayoneParameters_BankCountryParameter_NL               @"NL"            


// OnlineBankTransferTypeParameter_
#define PayoneParameters_OnlineBankTransferTypeParameter_DIRECT_TRANSFER               @"PNT"
#define PayoneParameters_OnlineBankTransferTypeParameter_GIROPAY               @"GPY"
#define PayoneParameters_OnlineBankTransferTypeParameter_EPS_ONLINETRANSFER               @"EPS"
#define PayoneParameters_OnlineBankTransferTypeParameter_POSTFINANCE_EFINANCE               @"PFF"
#define PayoneParameters_OnlineBankTransferTypeParameter_POSTFINANCE_CARD               @"PFC"


// WalletTypeParameter_
#define PayoneParameters_WalletTypeParameter_PAYPAL_EXPRESS               @"PPE"


// InvoiceDeliveryMode_
#define PayoneParameters_InvoiceDeliveryMode_MAIL               @"M"
#define PayoneParameters_InvoiceDeliveryMode_PDF               @"P"

*/
