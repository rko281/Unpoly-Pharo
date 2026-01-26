Class {
	#name : 'UpLayer',
	#superclass : 'WAObject',
	#instVars : [
		'id',
		'mode',
		'componentBlock',
		'component',
		'context',
		'parentComponent',
		'parentLayer',
		'placeholder',
		'onClosed',
		'onClosedReload',
		'upDismissable',
		'isOpen'
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

{ #category : 'event handling' }
UpLayer >> _onLayerClosed: anUpEvent [

	isOpen := false.
	parentLayer := nil. 
	onClosed isNil ifFalse: [onClosed value: anUpEvent]
]

{ #category : 'initialization' }
UpLayer >> beModal [

	self mode: #modal
]

{ #category : 'initialization' }
UpLayer >> bePopup [

	self mode: #popup
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

	component := anObject
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
UpLayer >> configureAnchorTag: aWAAnchorTag in: anUpComponent [

	parentComponent := anUpComponent.

	aWAAnchorTag
		upLocation: false;
		upNoTab: true;  "<- since layers effectively follow call:answer: semantics opening in a new tab rarely makes sense. Idea: allow a non-layered alternative to be specified"
		upLayer: 'new ', self mode;
		upDismissEvent: self closeEventType;
		upOnOpened: self onOpenedSnippet;
		upOnDismissed: self onClosedSnippet;
		upOnError: self onErrorSnippet.

	self upDismissable ifNotNil: [ :value | aWAAnchorTag upDismissable: value].
	self placeholder ifNotNil: [ :upPlaceholder | aWAAnchorTag upPlaceholder: upPlaceholder].
	self context isEmpty ifFalse: [aWAAnchorTag upContext: self context asJson].

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

	^self context at: aSymbol ifAbsent: 
		[parentLayer isNil
			ifTrue: [aBlock value]
			ifFalse: [parentLayer contextAt: aSymbol ifAbsent: aBlock]]
]

{ #category : 'accessing' }
UpLayer >> contextAt: aSymbol ifPresent: aBlock [

	self context at: aSymbol ifPresent: [ :val | ^aBlock value: val].

	^parentLayer isNil ifFalse: [parentLayer contextAt: aSymbol ifPresent: aBlock]
]

{ #category : 'accessing' }
UpLayer >> contextAt: aSymbol put: aStringOrNil [

	^aStringOrNil isNil
		ifTrue: [self context removeKey: aSymbol ifAbsent:[]]
		ifFalse: [self context at: aSymbol put: aStringOrNil]
]

{ #category : 'accessing' }
UpLayer >> id [

	^id ifNil: [self contextAt: #layerId ifAbsent: [nil]]
]

{ #category : 'accessing' }
UpLayer >> id: anObject [

	id := anObject.

	"Also store in the context"
	self contextAt: #layerId put: anObject
]

{ #category : 'initialization' }
UpLayer >> initialize [

	super initialize.

	context := Dictionary new.
	isOpen := false
]

{ #category : 'testing' }
UpLayer >> isOpen [

	^isOpen
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
UpLayer >> onAnswer: aBlock [

	"A Block to be evaluated when the receiver's component answers.
	The single argument is the answer: argument.

	If the layer is dismissed no answer is sent, the same as if the component was in a tab which was closed.
	To additionally respond to dismissals (or otherwise interrogate the close event or layer) use onClosed: "

	self onClosed: [ :closeEvent | closeEvent isDismissal ifFalse: [aBlock value: closeEvent value]]
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

	self isOpen ifTrue: [self _onLayerClosed: anUpEvent].

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
	When the component answers close the layer on the client"

	componentBlock isNil ifFalse: [self component: componentBlock value].

	parentLayer := self session currentLayer.
	self session addLayer: self; currentLayer: self.
	isOpen := true.

	self topComponent call: component onAnswer: 
		[ :answer || closeEvent |
		closeEvent := 
			(UpEvent type: self closeEventType)
				layer: self;
				value: answer;
				yourself.

		self _onLayerClosed: closeEvent.

		"Raise the event on the client to close the layer"
		self requestContext respond: [ :response | response upEvent: closeEvent]]
]

{ #category : 'accessing' }
UpLayer >> topComponent [

	^parentLayer isNil
		ifTrue: [parentComponent]
		ifFalse: [parentLayer topComponent]
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
