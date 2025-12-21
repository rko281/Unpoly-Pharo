Class {
	#name : 'UpEvent',
	#superclass : 'WAObject',
	#instVars : [
		'type',
		'layer',
		'properties'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'instance creation' }
UpEvent class >> fromResponseString: aString [

	^self new
		parseResponseString: aString;
		yourself
]

{ #category : 'public' }
UpEvent class >> icon [

	^Event icon
]

{ #category : 'instance creation' }
UpEvent class >> type: typeString [

	^self new
		type: typeString;
		yourself
]

{ #category : 'printing' }
UpEvent >> displayOn: aStream [

	aStream nextPutAll: 'type: '; nextPutAll: self type.
	self properties keysAndValuesDo: 
		[ :key :value |
		aStream 
			nextPutAll: '; ';
			nextPutAll: key;
			nextPutAll: ': ';
			print: value]

]

{ #category : 'testing' }
UpEvent >> hasComponent [

	^self properties includesKey: #component
]

{ #category : 'testing' }
UpEvent >> hasLayer [

	^self layer notNil
]

{ #category : 'testing' }
UpEvent >> hasResult [

	^self properties includesKey: #result
]

{ #category : 'testing' }
UpEvent >> hasTarget [

	^self properties includesKey: #target
]

{ #category : 'initialize/release' }
UpEvent >> initialize [

	super initialize.

	self properties: IdentityDictionary new
]

{ #category : 'testing' }
UpEvent >> isDismissal [

	^self type = 'up:layer:dismissed'
]

{ #category : 'accessing' }
UpEvent >> layer [

	^layer ifNil: 
		[self propertyAt: #layerID ifPresent: 
			[ :id | 
			layer := self session layerWithID: id]]
]

{ #category : 'accessing' }
UpEvent >> layer: anUpLayerOrNil [

	(layer := anUpLayerOrNil) isNil
		ifTrue: [self propertyAt: #layer put: nil; propertyAt: #layerID put: nil]
		ifFalse: [self propertyAt: #layer put: 'current' "we only support events on the current layer"; propertyAt: #layerID put: layer id]
]

{ #category : 'accessing' }
UpEvent >> layerID [

	^layer isNil 
		ifTrue: [self propertyAt: #layerID ifAbsent: [nil]]
		ifFalse: [layer id]
]

{ #category : 'parsing' }
UpEvent >> parseResponseString: aString [

	"Parse the reponse string. This is a Stringified array of 'key1,value1,key2,value2' etc.
	As a minimum it should contain the type of the event"

	| readStream |

	readStream := aString readStream.

	[readStream atEnd] whileFalse: 
		[| key value |
		key := (readStream upTo: $,) asSymbol.
		value := readStream upTo: $,.
		key = #type 
			ifTrue: [self type: value]
			ifFalse: [self propertyAt: key put: value]].

	self type isNil ifTrue: [self error: 'malformed response string']
]

{ #category : 'printing' }
UpEvent >> printOn: aStream [

	aStream
		basicPrint: self;
		nextPut: $(;
		display: self;
		nextPut: $)
]

{ #category : 'accessing' }
UpEvent >> properties [
	^properties
]

{ #category : 'accessing' }
UpEvent >> properties: anObject [
	properties := anObject
]

{ #category : 'accessing' }
UpEvent >> propertyAt: aSymbol [

	^self properties at: aSymbol
]

{ #category : 'accessing' }
UpEvent >> propertyAt: aSymbol ifAbsent: aBlock [

	^self properties at: aSymbol ifAbsent: aBlock
]

{ #category : 'accessing' }
UpEvent >> propertyAt: aSymbol ifPresent: aBlock [

	^self properties at: aSymbol ifPresent: aBlock
]

{ #category : 'accessing' }
UpEvent >> propertyAt: aSymbol put: aStringOrNil [

	^aStringOrNil isNil
		ifTrue: [self properties removeKey: aSymbol ifAbsent:[]]
		ifFalse: [self properties at: aSymbol put: aStringOrNil]
]

{ #category : 'responding' }
UpEvent >> respond: aString [

	"Assume plain text"

	self respond: aString contentType: WAMimeType textPlain

	
]

{ #category : 'responding' }
UpEvent >> respond: aString contentType: aMimeType [

	self requestContext respond: 
		[ :response | 
		response 
			doNotCache;
			contentType: aMimeType.
		response stream nextPutAll: aString]
]

{ #category : 'accessing' }
UpEvent >> target [

	^self propertyAt: #target ifAbsent: [nil]
]

{ #category : 'accessing' }
UpEvent >> target: aString [

	self propertyAt: #target put: aString
]

{ #category : 'accessing' }
UpEvent >> type [
	^type
]

{ #category : 'accessing' }
UpEvent >> type: aString [

	type := aString
]

{ #category : 'accessing' }
UpEvent >> value [

	^self propertyAt: #value ifAbsent: [nil]
]

{ #category : 'accessing' }
UpEvent >> value: anObject [

	self propertyAt: #value put: anObject
]

{ #category : 'printing' }
UpEvent >> writeRelaxedJsonOn: aStream [

	"Unpoly expects events in 'relaxed json' format, specifically no quotes on the keys.
	We also filter out any properties without a valid JSON representation"

	aStream 
		nextPutAll: '{type:'; 
		print: self type.

	self properties keysAndValuesDo: 
		[ :key :value |
		([value upJson] on: Error do: [ :exc | exc return: nil]) ifNotNil: 
			[ :json |
			aStream 
				nextPut: $,;
				nextPutAll: key;
				nextPut: $:;
				nextPutAll: json]].

	aStream nextPut: $}
]
