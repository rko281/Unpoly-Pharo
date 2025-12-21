Extension { #name : 'WARenderContext' }

{ #category : '*Unpoly-Core' }
WARenderContext >> upOverrideRendererClass [

	^self properties at: #upOverrideRendererClass ifAbsent: [nil]
]

{ #category : '*Unpoly-Core' }
WARenderContext >> upRenderWithClass: aRendererClass during: aBlock [

	| previous |

	previous := properties at: #upOverrideRendererClass ifAbsent: [nil].

	properties at: #upOverrideRendererClass put: aRendererClass.
	aBlock ensure: 
		[previous isNil 
			ifTrue: [properties removeKey: #upOverrideRendererClass]
			ifFalse: [properties at: #upOverrideRendererClass put: previous]]
]
