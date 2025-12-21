Extension { #name : 'WAFormInputTag' }

{ #category : '*Unpoly-Core' }
WAFormInputTag >> callbackKey [

	^attributes at: 'name' ifAbsent: [nil]
]
