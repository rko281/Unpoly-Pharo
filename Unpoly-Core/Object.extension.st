Extension { #name : 'Object' }

{ #category : '*Unpoly-Core' }
Object >> upJson [

	"No asJson in Pharo"

	^(String new: self size * 10) writeStreamDo: 
		[ :stream | 
		STON writer 
			on: stream; 
			jsonMode: true;
			nextPut: self. 
		stream contents]
]
