Extension { #name : 'WARequest' }

{ #category : '*Unpoly-Core' }
WARequest >> isUpValidating [

	^self upValidate notNil
]

{ #category : '*Unpoly-Core' }
WARequest >> upTarget [

	^self headerAt: 'x-up-target' ifAbsent: [nil]
]

{ #category : '*Unpoly-Core' }
WARequest >> upValidate [

	^self headerAt: 'x-up-validate' ifAbsent: [nil]
]
