Class {
	#name : 'UpInitialRenderLoopContinuation',
	#superclass : 'WAInitialRenderLoopContinuation',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'processing' }
UpInitialRenderLoopContinuation >> basicPerformAction [
	| root |
	root := self session properties at: #presenter ifAbsentPut: [self createRoot].
	self prepareRoot: root
]
