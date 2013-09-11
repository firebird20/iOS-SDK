iOS-SDK
=======

PAYONE iOS InApp Payment SDK


Payone Mobile SDK IOS Dokumentation:

Der aktuelle Stand beinhaltet die Punkte die im Kostenvoranschlag zwischen Exozet und Payone vereinbart wurden (Kostenvoranschlag: 201205010).
Inhalt sind die PayoneMobileSDK Bibliothek sowie eine Testapplikation, die die Bibliothek nutzt und ihre Funktionalität aufzeigt.


PayoneMobileSDK Bibliothek:

Intention der PayoneMobileSDK Bibliothek ist eine vereinfachte und direkte Ansteuerung der folgenden WebRequests:
	Creditcardcheck;
	Preauthorization
	Authorization
Hierbei dient, wie vereinbart, die Bibliothek nur als Datendurchreiche und hat keinerlei Fehlerkorrekturen oder Problembehandlungen.


Wie binde ich die PayoneMobileSDK Bibliothek in mein IOS Projekt ein?

Zuerst muss der Ordner PayoneMobileSdk.framework in den Ordner des Projekts kopiert werden. Danach 'Xcode/Project Target/Build Pahses/Link Binary With Library/ + / Add Other ' Das Framework auswählen und hinzufügen. Damit Xcode die Header findet muss unter den Build Settings noch der Eintrag User Header Search Paths' wie folgt angepasst werden. 

%ProjektOrdner%/%Framework%/Versions/A/Headers
Der Eintrag sieht dann etwa so aus, wenn das Framework auf einer Ebene mit dem Projekt liegt:
 "$(SRCROOT)/PayoneMobileSdk.framework/Versions/A/Headers/"

Zusätzlich müssen folgende Frameworks dem Projekt unter "Target/Buildphases/Link with Libraries" hinzugefügt werden:

MobileCoreServices.framework
SystemConfiguration.framework
CFNetwork.framework
libz.dylib


Wie verwende Ich die PayoneMobileSDK API?

Nachdem das Projekt mit der Bibliothek verbunden ist, kann man durch hinzufügen der entsprechenden imports nun die
Funktionen und Klassen der API nutzen. 

ObjC Code:
	#import "PayoneMobileSdk.h"
	#import "PayoneRequestFactory.h"

Um über das Ergebnis der Anfrage informiert zu werden, muss das Protokol " <PayoneSdkProtocol>" implementiert werden.
Hierfür muss die Methode "onRequestResult"  der eigenen Klasse hinzugefügt werden. Darin kann dann nach eigenem Bedarf
auf das Ergebnis der Anfrage reagiert werden.

ObjC Code:

-(void) onRequestResult:(ParameterCollection*) result
{
	...
}

In der statischen Klasse "PayoneRequestFactory" sind nun alle unterstützten Anfragen enhalten:

ObjC Code:
	// request a creditcardcheck
	[PayoneRequestFactory createCreditCardCheckRequest:%delegate% withValue: %M5Hash_Key% andParameters: %parameters%];

	// request a preauthorization
	[PayoneRequestFactory createPreAuthorizationRequest:%delegate% withValue: %M5Hash_Key% andParameters %parameters%];

	// request an authorization
	[PayoneRequestFactory createAuthorizationRequest:%delegate% withValue: %M5Hash_Key% andParameters %parameters%];


Die einzelnen Übergabeparameter der Methode erklären sich wie folgt:

%delegate%:
	Der Methode onRequestResult des Delegates wird aufgerufen, sobald die Anfrage ein mögliches Resultat (ob valide, invalide oder fehlerhaft) 
	dem Benutzer zur Verfügung stellen kann.
	Der Rückgabe wird eine ParameterCollection beigefügt. Diese beinhaltet, ähnlich wie ein Dictionary, alle Key-Value Paare, die
	der Benutzer nun nutzen kann, um die Anfrage dementsprechend zu analysieren und visualisieren.

%M5Hash_Key%
	Dieser Schlüssel wird von Payone als Zusatz bei der Hash-Summen-Berechnung angehangen. Durch betreten des Payone Merchant Portals
	kann Einsicht auf diesen Wert genommen werden und im Anschluss dieser an die Anfrage angehangen werden.

%parameters%
	Hier werden alle für die Anfrage wichtigen Parameter eingetragen und im Anschluss an die Anfrage übergeben.
	Je nach Anfrage unterscheiden sich hier die Parameterwerte (dazu bitte die Payone Client Dokumentation einsehen).


ObjC Code (inside class that implements RequestListener):

	- (void) doMyRequest
	{
	    ParameterCollection* parameters = [[ParameterCollection new] autorelease];
	    [parameters addKey:PayoneParameters_AID withValue:  @"12345"];
	    [parameters addKey:PayoneParameters_MID withValue:  @"67890"];
	    [parameters addKey:PayoneParameters_PORTALID withValue:  @"2222222"];
	    [parameters addKey:PayoneParameters_MODE withValue:  PayoneParameters_ModeParameter_TEST];
	    [parameters addKey:PayoneParameters_REQUEST withValue:  PayoneParameters_RequestParameter_CREDITCARDCHECK];
	    [parameters addKey:PayoneParameters_RESPONSETYPE withValue:  PayoneParameters_ResponseTypeParameter_JSON];
	    [parameters addKey:PayoneParameters_CARDPAN withValue:  @"5500000000000004"];
	    [parameters addKey:PayoneParameters_CARDTYPE withValue:  PayoneParameters_CreditCardVariations_MASTERCARD];
	    [parameters addKey:PayoneParameters_CARDEXPIREDATE withValue:  @"1401"];
	    [parameters addKey:PayoneParameters_CARDCVC2 withValue:  @"1234"];
	    [parameters addKey:PayoneParameters_ENCODING withValue:  PayoneParameters_UTF_8];
	    [parameters addKey:PayoneParameters_STORECARDDATA withValue:  PayoneParameters_StoreCardDataParameter_YES];
	    [parameters addKey:PayoneParameters_LANGUAGE withValue:  @"de"];
	    
	    NSString* m5_key = @"your_personal_key";
	    
	    [PayoneRequestFactory createCreditCardCheckRequest: self  withValue: m5_key andParameters: parameters];
	}

	-(void) onRequestResult:(ParameterCollection*) result
	{
	    NSMutableString* string = [[[NSMutableString alloc]init]autorelease];
	 
	    [string appendFormat:@" ------------- \n" ];
	    
	    for (NSString* key in [result.collection allKeys]) 
	    {
	        [string appendFormat:@"%@: %@\n", key, [result valueForKey:key]];
	    }
	    
	    [string appendFormat:@" ------------- \n" ];
	
	    
	    if([[result valueForKey:PayoneParameters_STATUS] isEqualToString:PayoneParameters_ResponseErrorCodes_ERROR])
	    {
	        // something went wrong…
	    }
	    else 
	    {
	       // request succsess
	    }
	}

	

Durch das verwenden der PayoneParameters-Klasse können mögliche Parameter, sowie Unterelemente schnell und vor allem
korrekt angesteuert oder ausgewertet werden. Die PayoneParameters-Klasse enthält alle zur Verfügung stehenden Parameter.



Die PayoneMobileSDK-Test Applikation.

Um einen kleinen Einblick in die Handhabung der API zu bekommen, wird eine TestApplikation zur Verfügung gestellt.
Diese enthält drei Buttons, mit denen man die drei Anfragen senden und auswerten kann.
Durch entweder grünen, roten oder gelben Text und Analyse der Textausgabe kann man nun die Anfrage ausprobieren und einsehen.
