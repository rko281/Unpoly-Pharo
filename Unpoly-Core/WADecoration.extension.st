Extension { #name : 'WADecoration' }

{ #category : '*Unpoly-Core' }
WADecoration >> upLayerDecoration [

	^self next isDecoration 
		ifTrue: [self next upLayerDecoration]
		ifFalse: [nil]
]
