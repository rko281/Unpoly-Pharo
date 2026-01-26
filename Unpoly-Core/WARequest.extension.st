Extension { #name : 'WARequest' }

{ #category : '*Unpoly-Core' }
WARequest >> isUpValidating [

	^self upValidate notNil
]

{ #category : '*Unpoly-Core' }
WARequest >> upContext [

	^(self headerAt: 'X-Up-Context' ifAbsent: [nil]) ifNotNil: 
		[ :ctx | 
		ctx size > 2 "Ignore {}" 
			ifTrue: [STON fromString: ctx]
			ifFalse: [##(Dictionary new)]]
]

{ #category : '*Unpoly-Core' }
WARequest >> upTarget [

	^self headerAt: 'x-up-target' ifAbsent: [nil]
]

{ #category : '*Unpoly-Core' }
WARequest >> upValidate [

	^self headerAt: 'x-up-validate' ifAbsent: [nil]
]
