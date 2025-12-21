Class {
	#name : 'UpExample',
	#superclass : 'UpComponent',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'accessing' }
UpExample class >> allExamples [

	^self allSubclasses reject: [ :each | each isAbstract]
]

{ #category : 'accessing' }
UpExample class >> exampleName [

	^self subclassResponsibility
]

{ #category : 'accessing' }
UpExample class >> exampleSource [

	^self
]

{ #category : 'initializing' }
UpExample class >> initializeSession: anUpSession [
]

{ #category : 'testing' }
UpExample class >> isAbstract [
	^self name = #UpExample
]

{ #category : 'accessing' }
UpExample class >> ordering [

	^SmallInteger maximum
]

{ #category : 'constants' }
UpExample class >> subPath [

	^self subclassResponsibility
]
