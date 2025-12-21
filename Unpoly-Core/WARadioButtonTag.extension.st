Extension { #name : 'WARadioButtonTag' }

{ #category : '*Unpoly-Core' }
WARadioButtonTag >> callbackKey [

	^attributes at: 'value' ifAbsent: [nil]
]
