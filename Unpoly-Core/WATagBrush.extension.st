Extension { #name : 'WATagBrush' }

{ #category : '*Unpoly-Core' }
WATagBrush >> asUpTarget [

	^self id 
		ifNil: [self error: 'no id - send #beUpTarget before assigning me as an upTarget']
		ifNotNil: [ :id | '#', id]
]

{ #category : '*Unpoly-Core' }
WATagBrush >> beUpTarget [

	"an id is required"

	self ensureId
]

{ #category : '*Unpoly-Core' }
WATagBrush >> callbackKey [

	"Answer the key of the callback attached to the receiver or nil if none"

	^nil
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upAcceptEvent: aString [

	self attributeAt: 'up-accept-event' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upAlias: aString [

	self attributeAt: 'up-alias' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upAnchored: aString [

	"Only right supported - see https://unpoly.com/up-anchored-right"

	self attributeAt: 'up-anchored' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upAutoSubmit: aBoolean [

	self attributeAt: 'up-autosubmit' put: aBoolean
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upBefore [

	"Private - Unpoly-specific vairant of before. Sent immediately before writing the receiver onto the document"

	self attributes removeKey: #_tag_ ifAbsent: []
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upCache: aStringOrBoolean [

	self attributeAt: 'up-cache' put: aStringOrBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upConfirm: aString [

	self attributeAt: 'up-confirm' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upContent: aString [

	self attributeAt: 'up-content' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upContext: anObject [

	self attributeAt: 'up-context' put: anObject
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upDisable: aBoolean [

	self attributeAt: 'up-disable' put: aBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upDismissEvent: aString [

	self attributeAt: 'up-dismiss-event' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upDismissable: aBooleanOrString [

	self attributeAt: 'up-dismissable' put: aBooleanOrString asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upDuration: anInteger [

	"milliseconds"

	self attributeAt: 'up-duration' put: anInteger asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upFlashes: aBoolean [

	self attributeAt: 'up-flashes' put: aBoolean
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upFollow: aBoolean [

	self attributeAt: 'up-follow' put: aBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upHistory: aStringOrBoolean [

	self attributeAt: 'up-history' put: aStringOrBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upInitialize [

	"Private - Set any defaults for this brush when used in Unpoly"

	self attributeAt: #_tag_ put: self
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upLayer: aString [

	self attributeAt: 'up-layer' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upLocation: aStringOrBoolean [

	self attributeAt: 'up-location' put: aStringOrBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upMain: aBoolean [

	self attributeAt: 'up-main' put: aBoolean
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upMethod: aString [

	self attributeAt: 'up-method' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upMode: aString [

	self attributeAt: 'up-mode' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upOnDismissed: aJSFunction [

	self attributeAt: 'up-on-dismissed' put: aJSFunction
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upOnError: aString [

	self attributeAt: 'up-on-error' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upOnOpened: aString [

	self attributeAt: 'up-on-opened' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upPlaceholder: aString [

	"Convenience - allow the name to be specified without the required preceeding # character"

	aString first = $#
		ifTrue: [self attributeAt: 'up-placeholder' put: aString]
		ifFalse: [self upPlaceholder: '#', aString]
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upPreload: aStringOrBoolean [

	self attributeAt: 'up-preload' put: aStringOrBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upPreview: aString [

	self attributeAt: 'up-preview' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upSubmit: aBoolean [

	self attributeAt: 'up-submit' put: aBoolean
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upTarget: anObject [

	"anObject may be a String denoting an html id/class/element with the appropriate prefix (# / . / :)
	or a previously-rendered Tag object"

	self attributeAt: 'up-target' put: anObject asUpTarget
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upTitle: aStringOrBoolean [

	self attributeAt: 'up-title' put: aStringOrBoolean
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upTransition: aString [

	self attributeAt: 'up-transition' put: aString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upValidate: aStringOrBoolean [

	self attributeAt: 'up-validate' put: aStringOrBoolean asString
]

{ #category : '*Unpoly-Core' }
WATagBrush >> upWatchDelay: anInteger [

	self attributeAt: 'up-watch-delay' put: anInteger
]
