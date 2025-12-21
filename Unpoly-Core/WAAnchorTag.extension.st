Extension { #name : 'WAAnchorTag' }

{ #category : '*Unpoly-Core' }
WAAnchorTag >> callbackKey [

	(url notNil and: [url isString not and: [url path = canvas actionUrl path]]) ifTrue: 
		[url _queryFields ifNotNil: 
			[ :queryFields |
			queryFields keysAndValuesDo: [ :key :value | (value isNil and: [key allSatisfy: [ :char | char isDigit]]) ifTrue: [^key]]]].

	^nil
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> showLayer: anUpLayer [

	"When this link is followed show anUpLayer with its configured component and behavior"

	anUpLayer 
		id: (self session nextLayerIdOn: canvas);
		configureAnchorTag: self
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upInitialize [

	super upInitialize.

	self upFollow: true
]
