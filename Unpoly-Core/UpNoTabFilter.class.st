Class {
	#name : 'UpNoTabFilter',
	#superclass : 'WARequestFilter',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'processing' }
UpNoTabFilter >> handleFiltered: aRequestContext [ 
	"Prevent callbacks from being opened in a new tab/window where specified"

	| request |

	request := aRequestContext request.

	^(request upTarget isNil and: [request fields includesKey: '_notab']) 
		ifTrue: [aRequestContext redirectTo: (aRequestContext request headerAt: 'referer')]
		ifFalse: [super handleFiltered: aRequestContext]
]
