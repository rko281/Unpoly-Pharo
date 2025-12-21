Extension { #name : 'WACallbackRegistry' }

{ #category : '*Unpoly-Core' }
WACallbackRegistry >> callbacks [

	^callbacks
]

{ #category : '*Unpoly-Core' }
WACallbackRegistry >> removeKeysNotIn: aCollection [

	(callbacks keys difference: aCollection) do: [ :each | callbacks removeKey: each]
]
