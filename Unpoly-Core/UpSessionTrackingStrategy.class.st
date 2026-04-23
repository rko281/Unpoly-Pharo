Class {
	#name : 'UpSessionTrackingStrategy',
	#superclass : 'WACookieOnlySessionTrackingStrategy',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'public' }
UpSessionTrackingStrategy >> noHandlerFoundForKey: aString in: anApplication context: aRequestContext [
	"Overridden to handle as an unauthorized request; this is trapped by an Unpoly event handler to force a full page redirect and refresh"

	| request queryField |
	request := aRequestContext request. 

	"If this is a navigation request then handle as usual"
	((request headerAt: 'Sec-Fetch-Mode') = 'navigate' and: [(request headerAt: 'Sec-Fetch-Dest') = 'document']) ifTrue: [^super noHandlerFoundForKey: aString in: anApplication context: aRequestContext].

	queryField := self queryFieldKeyFromContext: aRequestContext.

	aString = queryField ifFalse: [
		"Don't delete the session cookie if we have an expired document halder.
		Only delete the session cookie if we actually have an expired session."
		self deleteSessionCookieOf: anApplication from: aRequestContext ].
	aRequestContext response
		status: WAResponse statusUnauthorized;
		respond
]
