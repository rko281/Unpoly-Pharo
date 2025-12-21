Extension { #name : 'WAComponent' }

{ #category : '*Unpoly-Examples' }
WAComponent >> exampleWait [

	^self session properties at: #exampleWaitDuration ifPresent: [ :duration | duration wait]
]

{ #category : '*Unpoly-Examples' }
WAComponent >> hasExampleDelay [

	^self session properties includesKey: #exampleWaitDuration
]

{ #category : '*Unpoly-Examples' }
WAComponent >> hasExampleDelay: aBoolean [

	aBoolean 
		ifTrue: [self session properties at: #exampleWaitDuration put: 2 seconds]
		ifFalse: [self session properties removeKey: #exampleWaitDuration]
]
