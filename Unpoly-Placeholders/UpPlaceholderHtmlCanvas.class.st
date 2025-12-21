Class {
	#name : 'UpPlaceholderHtmlCanvas',
	#superclass : 'UpHtmlCanvas',
	#instVars : [
		'parentCanvas'
	],
	#category : 'Unpoly-Placeholders',
	#package : 'Unpoly-Placeholders'
}

{ #category : 'instance creation' }
UpPlaceholderHtmlCanvas class >> _context: aRenderContext [

	^self on: (UpHtmlCanvas _context: aRenderContext)
]

{ #category : 'instance creation' }
UpPlaceholderHtmlCanvas class >> on: html [

	^self new 
		parentCanvas: html; 
		yourself
]

{ #category : 'public' }
UpPlaceholderHtmlCanvas >> brush: aBrush [

	| placeholder | 

	(#('dt' 'dl' 'br' 'p') includes: aBrush tag) ifTrue: [^super brush: aBrush].
	((aBrush tag = 'div') and: [(aBrush attributes includesKey: 'class') not]) ifTrue: [^super brush: aBrush].

	(#('dd' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6' ) includes: aBrush tag) ifTrue: [^super brush: (aBrush class: 'placeholder')].

	placeholder := super brush: UpPlaceholderTag new.
	placeholder tagBrush: aBrush.

	placeholder attributes: aBrush attributes.

	(Dictionary new
		at: 'button' put: 'btn';
		yourself) at: aBrush tag ifPresent: [ :cls | placeholder class: cls].

	^placeholder
]

{ #category : 'accessing' }
UpPlaceholderHtmlCanvas >> parentCanvas [
	^parentCanvas
]

{ #category : 'accessing' }
UpPlaceholderHtmlCanvas >> parentCanvas: anObject [
	parentCanvas := anObject.
	context := parentCanvas context
]

{ #category : 'public' }
UpPlaceholderHtmlCanvas >> render: anObject [

	^anObject isString 
		ifTrue: [parentCanvas span class: 'placeholder'; with: anObject]
		ifFalse: [super render: anObject]
]
