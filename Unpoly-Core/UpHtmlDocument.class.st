Class {
	#name : 'UpHtmlDocument',
	#superclass : 'WAHtmlDocument',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'writing' }
UpHtmlDocument >> openTag: aString attributes: anAttributes closed: aBoolean [

	anAttributes ifNotNil: [ :attr | attr at: #_tag_ ifPresent: [ :tag | tag upBefore]].

	^super openTag: aString attributes: anAttributes closed: aBoolean
]
