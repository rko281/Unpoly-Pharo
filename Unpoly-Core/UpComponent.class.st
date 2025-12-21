Class {
	#name : 'UpComponent',
	#superclass : 'SBSComponent',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'configuring' }
UpComponent >> beLayerHost [

	"Configure the receiver as the host component for opening new layers"

	self session layerHost: self
]

{ #category : 'accessing' }
UpComponent >> database [

	^self session properties at: #database
]

{ #category : 'testing' }
UpComponent >> isInLayer [

	^self layer notNil
]

{ #category : 'accessing' }
UpComponent >> layer [

	^self upLayerDecoration ifNotNil: [ :layerDecoration | layerDecoration layer]
]

{ #category : 'accessing' }
UpComponent >> layerContextAt: aSymbol [

	^self layerContextAt: aSymbol ifAbsent: [self error: 'not found']
]

{ #category : 'accessing' }
UpComponent >> layerContextAt: aSymbol ifAbsent: aBlock [

	^self layer 
		ifNil: [aBlock value]
		ifNotNil: [ :layer | layer contextAt: aSymbol ifAbsent: aBlock]
]

{ #category : 'accessing' }
UpComponent >> layerDecoration [

	^self decoration isDecoration
		ifTrue: [self decoration upLayerDecoration]
		ifFalse: [nil]
]

{ #category : 'rendering' }
UpComponent >> rendererClass [

	^UpHtmlCanvas
]

{ #category : 'delegation' }
UpComponent >> show: aComponent onAnswer: aBlock delegation: aDelegation [

	self layer ifNotNil: [ :layer | aComponent addDecoration: (UpLayerDecoration new layer: layer)].

	^super show: aComponent onAnswer: aBlock delegation: aDelegation
]

{ #category : 'accessing' }
UpComponent >> upLayerDecoration [

	^self decoration ~~ self
		ifTrue: [self decoration upLayerDecoration]
		ifFalse: [nil]
]
