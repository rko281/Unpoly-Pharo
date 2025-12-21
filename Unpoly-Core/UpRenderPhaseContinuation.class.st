Class {
	#name : 'UpRenderPhaseContinuation',
	#superclass : 'WARenderPhaseContinuation',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'processing' }
UpRenderPhaseContinuation >> documentClass [

	^self requestContext request upTarget notNil
		ifTrue: [UpSelectiveRenderingHtmlDocument]
		ifFalse: [UpHtmlDocument]
]
