Class {
	#name : 'UpSelectiveRenderingHtmlDocument',
	#superclass : 'UpHtmlDocument',
	#instVars : [
		'renderingDepth',
		'silencedStream',
		'classesToRender',
		'idsToRender',
		'callbackKeys'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'initialization' }
UpSelectiveRenderingHtmlDocument >> close [

	self removeUnusedCallbacks.
	
	super close
]

{ #category : 'writing' }
UpSelectiveRenderingHtmlDocument >> closeTag: aString [

	self isRendering ifFalse: [^self].

	super closeTag: aString.
	self decrementRenderingDepth
]

{ #category : 'helpers' }
UpSelectiveRenderingHtmlDocument >> decrementRenderingDepth [

	renderingDepth := renderingDepth - 1.
	renderingDepth = 0 ifTrue: [self stopRendering]
]

{ #category : 'testing' }
UpSelectiveRenderingHtmlDocument >> isRendering [

	^renderingDepth notNil
]

{ #category : 'initialization' }
UpSelectiveRenderingHtmlDocument >> open: aRoot [

	classesToRender := idsToRender := nil.
	callbackKeys := OrderedCollection new.

	self parseReloadHeader.
	(classesToRender isNil and: [idsToRender isNil])
	ifTrue: 
		[self startRendering]
	ifFalse: 
		[self stopRendering.
		self requestContext response headerAt: 'Vary' put: 'X-Up-Target'].

	^super open: aRoot
]

{ #category : 'writing' }
UpSelectiveRenderingHtmlDocument >> openTag: aString attributes: anAttributes closed: aBoolean [

	| tag |

	tag := anAttributes ifNotNil: [ :attr | attr at: #_tag_ ifAbsent: [nil]].

	self isRendering
	ifTrue: 
		[renderingDepth  := renderingDepth  + 1]
	ifFalse: 
		[(self shouldRenderAttributes: anAttributes) ifFalse: [^self].
		self startRendering].

	super openTag: aString attributes: anAttributes closed: aBoolean.

	tag isNil ifFalse: [tag callbackKey ifNotNil: [ :key | callbackKeys add: key]].
	aBoolean ifTrue: [self decrementRenderingDepth]
]

{ #category : 'helpers' }
UpSelectiveRenderingHtmlDocument >> parseReloadHeader [

	| reloadHeader readStream |

	reloadHeader := self requestContext request headerAt: 'x-up-target'.
	readStream := reloadHeader readStream.

	[readStream atEnd] whileFalse: 
		[| next |
		next := readStream upTo: $,.
		next first = $. 
			ifTrue: [classesToRender := (classesToRender ifNil: [#()]), {next allButFirst}]
			ifFalse: [next first = $# ifTrue: [idsToRender := (idsToRender ifNil: [#()]), {next allButFirst}]].
		readStream skipSeparators]
]

{ #category : 'helpers' }
UpSelectiveRenderingHtmlDocument >> removeUnusedCallbacks [

	root context callbacks removeKeysNotIn: callbackKeys
]

{ #category : 'testing' }
UpSelectiveRenderingHtmlDocument >> shouldRenderAttributes: anAttributes [

	anAttributes isNil ifTrue: [^false].

	"Always render"
	(anAttributes includesKey: 'up-flashes') ifTrue: [^true].

	classesToRender notNil ifTrue: 
		[(anAttributes at: 'class' ifAbsent: [nil]) ifNotNil: 
			[ :cls | 
			(cls isConcatenatedHtmlAttributeValue
				ifTrue: [classesToRender anySatisfy: [ :each | cls includes: each]]
				ifFalse: [classesToRender includes: cls]) ifTrue: [^true]]].

	idsToRender notNil ifTrue: 
		[(anAttributes at: 'id' ifAbsent: [nil]) ifNotNil: 
			[ :id | 
			(idsToRender includes: id) ifTrue: [^true]]].

	^false
]

{ #category : 'helpers' }
UpSelectiveRenderingHtmlDocument >> startRendering [

	renderingDepth := 1.
	silencedStream isNil ifFalse: [stream := silencedStream]
]

{ #category : 'helpers' }
UpSelectiveRenderingHtmlDocument >> stopRendering [

	renderingDepth := nil.
	silencedStream := stream.
	stream := NullStream new
]
