Class {
	#name : 'UpSession',
	#superclass : 'WASession',
	#instVars : [
		'layerHost',
		'layers',
		'notification'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'add/remove' }
UpSession >> addLayer: aLayer [

	aLayer parent: self topLayer.

	^self layers addLast: aLayer
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

{ #category : 'initialization' }
UpSession >> initialize [

	super initialize.

	layers := OrderedCollection new
]

{ #category : 'accessing' }
UpSession >> layerHost [

	"The UpComponent which hosts new layers"

	^layerHost
]

{ #category : 'accessing' }
UpSession >> layerHost: anUpComponent [

	"The UpComponent which hosts new layers"

	layerHost := anUpComponent
]

{ #category : 'accessing' }
UpSession >> layerWithID: aString [

	^self layers detect: [ :each | each id = aString]
]

{ #category : 'accessing' }
UpSession >> layers [

	^layers
]

{ #category : 'accessing' }
UpSession >> nextLayerIdOn: html [

	| id |

	"Skip the 'id' part"
	id := html nextId allButFirst: 2.

	^self layers isEmpty 
		ifTrue: ['layer', id]
		ifFalse: [self layers last id, '.', id]
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

{ #category : 'accessing' }
UpSession >> topLayer [

	"A stack"

	^self layers isEmpty 
		ifTrue: [nil]
		ifFalse: [self layers last]
]

{ #category : 'handling' }
UpSession >> unknownRequest [

	"Force a full-page refresh"

	self requestContext response
		status: WAResponse statusUnauthorized;
		respond
]
