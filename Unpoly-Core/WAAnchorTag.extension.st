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
WAAnchorTag >> showLayer: anUpLayer in: anUpComponent [

	"When this link is followed show anUpLayer with its configured component and behavior"

	anUpLayer 
		id: self session nextLayerId;
		configureAnchorTag: self in: anUpComponent
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upBefore [

	self callbackKey notNil ifTrue: 
		["If we are not following an explicit URL then we don't want to update the location"
		self upLocation isNil ifTrue: [self upLocation: false].
		self upNoTab ifTrue: [url addField: '_notab']].

	super upBefore
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upInitialize [

	super upInitialize.

	self upFollow: true
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upLocation [

	^self attributeAt: 'up-location' ifAbsent: [nil]
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upNoTab [

	"Pseudo attribute - set to true to restrict actions to the same tab"

	^self attributeAt: 'data-up-no-tab' ifAbsent: [self upNoTabDefault]
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upNoTab: aBoolean [

	"Pseudo attribute - set to true to restrict actions to the same tab"

	self attributeAt: 'data-up-no-tab' put: aBoolean
]

{ #category : '*Unpoly-Core' }
WAAnchorTag >> upNoTabDefault [

	"Private - By default we allow links to open in new tabs"

	^false
]
