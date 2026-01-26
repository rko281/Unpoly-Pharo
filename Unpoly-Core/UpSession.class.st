Class {
	#name : 'UpSession',
	#superclass : 'WASession',
	#instVars : [
		'layers',
		'layerCount',
		'notification',
		'currentLayer'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'add/remove' }
UpSession >> addLayer: aLayer [

	^self layers add: aLayer
]

{ #category : 'initialization' }
UpSession >> createContinuationCache [

	"Due to Unpoly performing partial updates on the client we may get callbacks from a link that was originally served long ago.
	Hence we need a much larger cache.

	Idea for improvement - use knowledge of partial updates to selectively preserve non-updated callbacks"

	^ WAHashCache
		initialSize: 7
		maximumSize: 2000
		maximumAbsoluteAge: 0
		maximumRelativeAge: 0
		overflowAction: WAHashCache removeRelativeOldest
]

{ #category : 'accessing' }
UpSession >> currentLayer [

	^currentLayer contents
]

{ #category : 'accessing' }
UpSession >> currentLayer: anUpLayerOrNil [

	currentLayer contents: anUpLayerOrNil
]

{ #category : 'accessing' }
UpSession >> currentLayerState [

	^currentLayer
]

{ #category : 'handling' }
UpSession >> handleFiltered: aRequestContext [ 

	"Select the requested layer"
	aRequestContext request isGet ifTrue: 
		[(aRequestContext request upContext ifNotNil: [ :ctx | ctx at: 'layerId' ifAbsent: [nil]])
			ifNil: [self currentLayer: nil]
			ifNotNil: [ :layerId | self currentLayer: (self layerWithId: layerId)]].

	^super handleFiltered: aRequestContext 
]

{ #category : 'initialization' }
UpSession >> initialize [

	super initialize.

	currentLayer := WAValueHolder new.
	layers := OrderedCollection new.
	layerCount := 0
]

{ #category : 'initialization' }
UpSession >> initializeFilters [
	super initializeFilters.
	self addFilter: UpNoTabFilter new
]

{ #category : 'accessing' }
UpSession >> layerWithId: aString [

	^self layers detect: [ :each | each id = aString] ifNone: [nil]
]

{ #category : 'accessing' }
UpSession >> layers [

	^layers
]

{ #category : 'accessing' }
UpSession >> nextLayerId [

	^'layer', (layerCount := layerCount + 1) asString
]

{ #category : 'accessing' }
UpSession >> notification: anObject [

	"A renderable object to be shown as a notification.
	A canvas is passed as a parameter if anObject is a block.
	Add an UpNotificationDecoration to your root component to show this automatically"

	notification := anObject
]

{ #category : 'event handling' }
UpSession >> onLayerClosed: upEvent [

	upEvent layer ifNotNil: 
		[ :layer | 
		(self removeLayer: layer) onLayerClosed: upEvent]
]

{ #category : 'event handling' }
UpSession >> onLayerOpened: upEvent [

	upEvent layer ifNotNil: 
		[ :layer | 
		layer onLayerOpened: upEvent]
]

{ #category : 'accessing' }
UpSession >> popNotification [

	^notification ifNotNil: 
		[ :poppedNotification |
		notification := nil.
		poppedNotification]
]

{ #category : 'add/remove' }
UpSession >> removeLayer: aLayer [

	^self layers remove: aLayer
]

{ #category : 'handling' }
UpSession >> unknownRequest [

	"Force a full-page refresh"

	self requestContext response
		status: WAResponse statusUnauthorized;
		respond
]
