Class {
	#name : 'UpLayer',
	#superclass : 'WAObject',
	#instVars : [
		'id',
		'mode',
		'componentBlock',
		'component',
		'context',
		'parent',
		'placeholder',
		'onClosed',
		'onClosedReload',
		'upDismissable'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'constants' }
UpLayer class >> closeEventType [

	^'layer:closed'
]

{ #category : 'public' }
UpLayer class >> icon [

	^Icon fromId: 16753 in: ShellLibrary default
]

{ #category : 'instance creation' }
UpLayer class >> modal [

	^self new 
		beModal;
		yourself
]

{ #category : 'instance creation' }
UpLayer class >> popup [

	^self new 
		bePopup;
		yourself
]

{ #category : 'initialization' }
UpLayer >> beModal [

	self mode: #modal
]

{ #category : 'initialization' }
UpLayer >> bePopup [

	self mode: #popup
]

{ #category : 'operations' }
UpLayer >> callOnAnswer: aBlock [

	| session |

	session := self session.

	componentBlock isNil ifFalse: [self component: componentBlock value].

	session addLayer: self.
	session layerHost call: component onAnswer: aBlock
]

{ #category : 'accessing' }
UpLayer >> closeEventType [

	^self class closeEventType
]

{ #category : 'accessing' }
UpLayer >> component [

	"The component to be shown in this layer.
	Either set directly or generated from the componentBlock each time the layer is opened"

	^component
]

{ #category : 'accessing' }
UpLayer >> component: anObject [

	"The component to be shown in this layer.
	Either set directly or generated from the componentBlock each time the layer is opened"

	component := anObject.
	component addDecoration: (UpLayerDecoration new layer: self)
]

{ #category : 'accessing' }
UpLayer >> componentBlock [

	"Private - aBlock (or other zero-arg valuable) which evaluates to an UpComponent to show in this layer.
	This is evaluated each time this layer is opened and the result stored in component"

	^componentBlock
]

{ #category : 'accessing' }
UpLayer >> componentBlock: aBlock [

	"Private - aBlock (or other zero-arg valuable) which evaluates to an UpComponent to show in this layer.
	This is evaluated each time this layer is opened and the result stored in component"

	componentBlock := aBlock
]

{ #category : 'operations' }
UpLayer >> configureAnchorTag: aWAAnchorTag [

	aWAAnchorTag
		upLocation: false;
		upLayer: 'new ', self mode;
		upDismissEvent: self closeEventType;
		upOnOpened: self onOpenedSnippet;
		upOnDismissed: self onClosedSnippet;
		upOnError: self onErrorSnippet.

	self upDismissable ifNotNil: [ :value | aWAAnchorTag upDismissable: value].
	self placeholder ifNotNil: [ :upPlaceholder | aWAAnchorTag upPlaceholder: upPlaceholder].
	self context isEmpty ifFalse: [aWAAnchorTag upContext: self context upJson].

	aWAAnchorTag callback: [self show]
]

{ #category : 'initialization' }
UpLayer >> containing: anUpComponentOrBlock [

	"Configure the receiver to show either an UpComponent or to generate its component from a Block (or other zero-arg valuable) each time the layer is opened"

	anUpComponentOrBlock isBlock
	ifTrue: 
		[componentBlock := anUpComponentOrBlock.
		component := nil]
	ifFalse: 
		[self component: anUpComponentOrBlock.
		componentBlock := nil]
]

{ #category : 'accessing' }
UpLayer >> context [
	^context
]

{ #category : 'accessing' }
UpLayer >> context: anObject [
	context := anObject
]

{ #category : 'accessing' }
UpLayer >> contextAt: aSymbol [

	^self context at: aSymbol
]

{ #category : 'accessing' }
UpLayer >> contextAt: aSymbol ifAbsent: aBlock [

	parent == self ifTrue: [self error: 'loop detected'].

	^self context at: aSymbol ifAbsent: 
		[self parent isNil 
			ifTrue: [aBlock value]
			ifFalse: [self parent contextAt: aSymbol ifAbsent: aBlock]]
]

{ #category : 'accessing' }
UpLayer >> contextAt: aSymbol ifPresent: aBlock [

	parent == self ifTrue: [self error: 'loop detected'].

	self context at: aSymbol ifPresent: [ :val | ^aBlock value: val].

	^self parent isNil ifFalse: [self parent contextAt: aSymbol ifPresent: aBlock]
]

{ #category : 'accessing' }
UpLayer >> contextAt: aSymbol put: aStringOrNil [

	^aStringOrNil isNil
		ifTrue: [self context removeKey: aSymbol ifAbsent:[]]
		ifFalse: [self context at: aSymbol put: aStringOrNil]
]

{ #category : 'accessing' }
UpLayer >> id [

	^id ifNil: [self contextAt: #layerID ifAbsent: [nil]]
]

{ #category : 'accessing' }
UpLayer >> id: anObject [

	id := anObject.

	"Also store in the context"
	self contextAt: #layerID put: anObject
]

{ #category : 'initialization' }
UpLayer >> initialize [

	super initialize.

	context := Dictionary new
]

{ #category : 'accessing' }
UpLayer >> mode [

	"mode stores a Symbol specifying the type of layer to be opened:

		#modal	A modal dialog box
		#drawer	A drawer sliding in from the side
		#popup	A popup menu anchored to a link
		#cover	An overlay covering the entire screen"

	^mode
]

{ #category : 'accessing' }
UpLayer >> mode: aSymbol [

	"mode stores a Symbol specifying the type of layer to be opened:

		#modal	A modal dialog box
		#drawer	A drawer sliding in from the side
		#popup	A popup menu anchored to a link
		#cover	An overlay covering the entire screen"

	mode := aSymbol
]

{ #category : 'accessing' }
UpLayer >> onClosed [

	"A Block to be evaluated when the layer is closed.
	The single argument is the close event"

	^onClosed
]

{ #category : 'accessing' }
UpLayer >> onClosed: aOneArgBlock [

	"A Block to be evaluated when the layer is closed.
	The single argument is the close event"

	onClosed := aOneArgBlock
]

{ #category : 'accessing' }
UpLayer >> onClosedReload [

	"A reference to a page component to reload when this layer is closed.
	Must be preceeded by the appropriate character (# for id, . for class etc.)"

	^onClosedReload
]

{ #category : 'accessing' }
UpLayer >> onClosedReload: aString [

	"A reference to a page component to reload when this layer is closed.
	Must be preceeded by the appropriate character (# for id, . for class etc.)"

	onClosedReload := aString
]

{ #category : 'constants' }
UpLayer >> onClosedSnippet [

	"Return a javascript snippet to be run when the receiver is closed on the client.
	This calls the layer close handler defined in UpLayerHostDecoration - this notifies the server which in turn answers the component to reload"

	^'upLayerClosed(event)'
]

{ #category : 'constants' }
UpLayer >> onErrorSnippet [

	"Return a javascript snippet to be run when the receiver experiences an error - usually cancelled whilst opening"

	^'upLayerCancelled(''<1s>'')' expandMacrosWith: self id
]

{ #category : 'event handling' }
UpLayer >> onLayerClosed: anUpEvent [

	self parent: nil.
	self component answer: anUpEvent.

	anUpEvent respond: self onClosedReload
]

{ #category : 'event handling' }
UpLayer >> onLayerOpened: anUpEvent [

	anUpEvent respond: self id
]

{ #category : 'constants' }
UpLayer >> onOpenedSnippet [

	"Return a javascript snippet to be run when the receiver is opened on the client.
	This calls the layer close handler defined in UpLayerHostDecoration - this notifies the server which in turn sets the current layer id"

	^'upLayerOpened(event)'
]

{ #category : 'accessing' }
UpLayer >> parent [
	^parent
]

{ #category : 'accessing' }
UpLayer >> parent: anObject [
	parent := anObject
]

{ #category : 'accessing' }
UpLayer >> placeholder [

	"A reference to a component to be shown as a placeholder in this layer whilst it is opening.
	May be nil"

	^placeholder
]

{ #category : 'accessing' }
UpLayer >> placeholder: aString [

	"A reference to a component to be shown as a placeholder in this layer whilst it is opening.
	May be nil"

	placeholder := aString
]

{ #category : 'operations' }
UpLayer >> show [

	"Show this layer with the configured component.
	When the layer is closed evaluate resultBlock (if not nil) with the closing event"

	self callOnAnswer: 
		[ :answer || closeEvent | 
		"If #answer: was invoked in response to the layer being dismissed (e.g. user clicked X button) then answer will be the actual dismissal event.
		If newComponent invoked #answer: itself then we must trigger an event to close the layer"
 		(answer isKindOf: UpEvent)
		ifTrue: 
			[closeEvent := answer]
		ifFalse: 
			[closeEvent := 
				(UpEvent type: self closeEventType)
					layer: self;
					value: answer;
					yourself].

		onClosed isNil ifFalse: [onClosed value: closeEvent].
		closeEvent isDismissal ifFalse: [self requestContext respond: [ :response | response upEvent: closeEvent]]] 
]

{ #category : 'accessing' }
UpLayer >> upDismissable [

	"upDismissable optionally stores either:
	 - aString representing the dismiss controls on the layer
	 - aBoolean enabling/disabling whether the receiver can be dismissed

	Unpoly default behaviour is equivalent to true/all controls.

	https://unpoly.com/up-layer-new#up-dismissable"

	^upDismissable
]

{ #category : 'accessing' }
UpLayer >> upDismissable: aStringOrBoolean [

	"upDismissable optionally stores either:
	 - aString representing the dismiss controls on the layer
	 - aBoolean enabling/disabling whether the receiver can be dismissed

	Unpoly default behaviour is equivalent to true/all controls.

	https://unpoly.com/up-layer-new#up-dismissable"

	upDismissable := aStringOrBoolean
]
