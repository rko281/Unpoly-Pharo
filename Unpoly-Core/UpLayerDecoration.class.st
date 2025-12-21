Class {
	#name : 'UpLayerDecoration',
	#superclass : 'UpDecoration',
	#instVars : [
		'layer'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'accessing' }
UpLayerDecoration >> layer [
	^layer
]

{ #category : 'accessing' }
UpLayerDecoration >> layer: anObject [
	layer := anObject
]

{ #category : 'rendering' }
UpLayerDecoration >> renderContentOn: html [

	"Each layer should have an up-main"

	html upMain: [self renderNextOn: html]
]

{ #category : 'accessing' }
UpLayerDecoration >> upLayerDecoration [

	^self
]
