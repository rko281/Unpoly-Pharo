Extension { #name : 'WAOptionTag' }

{ #category : '*Unpoly-Core' }
WAOptionTag >> callbackKey [

	^attributes at: 'value' ifAbsent: [nil]
]
