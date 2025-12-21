Extension { #name : 'WASelectTag' }

{ #category : '*Unpoly-Core' }
WASelectTag >> callbackKey [

	^attributes at: 'name' ifAbsent: [nil]
]
