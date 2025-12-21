Class {
	#name : 'UpPlaceholderTag',
	#superclass : 'WATagBrush',
	#instVars : [
		'tagBrush'
	],
	#category : 'Unpoly-Placeholders',
	#package : 'Unpoly-Placeholders'
}

{ #category : 'helpers' }
UpPlaceholderTag >> doesNotUnderstand: failedMessage [

	"Ignore messages specific to the tagBrush's class"

	^(tagBrush class canUnderstand: failedMessage selector)
		ifTrue: [self]
		ifFalse: [super doesNotUnderstand: failedMessage]
]

{ #category : 'helpers' }
UpPlaceholderTag >> openTag [

	"Restrict to appropriate attributes"

	| placeholderAttributes |

	placeholderAttributes := WAHtmlAttributes new.
	attributes keysAndValuesDo: 
		[ :key :value | 
		(#('class' 'cols' 'rows' ) includes: key) ifTrue: [placeholderAttributes at: key put: value]].

	(#('div' 'form' 'fieldset') includes: tagBrush tag) ifFalse: [placeholderAttributes addClass: 'placeholder'].

	self document openTag: self tag attributes: placeholderAttributes closed: self isClosed
]

{ #category : 'accessing' }
UpPlaceholderTag >> tag [

	^(#('div' 'form' 'fieldset' 'a' 'dt' 'label' 'input' 'textarea') includes: tagBrush tag)
		ifTrue: [tagBrush tag]
		ifFalse: ['span']
]

{ #category : 'accessing' }
UpPlaceholderTag >> tagBrush [
	^tagBrush
]

{ #category : 'accessing' }
UpPlaceholderTag >> tagBrush: anObject [
	tagBrush := anObject
]
