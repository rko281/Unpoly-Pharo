Extension { #name : 'WAResponse' }

{ #category : '*Unpoly-Core' }
WAResponse >> upEvent: anUpEvent [

	self upEvents: {anUpEvent}
]

{ #category : '*Unpoly-Core' }
WAResponse >> upEvents: aCollection [

	| stream |

	stream := WriteStream on: String new.
	stream nextPut: $[.
	aCollection do: [ :each | each writeRelaxedJsonOn: stream].
	stream nextPut: $].

	self headerAt: 'X-Up-Events' put: stream contents



]
