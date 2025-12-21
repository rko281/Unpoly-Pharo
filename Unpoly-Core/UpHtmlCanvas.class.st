Class {
	#name : 'UpHtmlCanvas',
	#superclass : 'SBSHtmlCanvas',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'instance creation' }
UpHtmlCanvas class >> _context: aRenderContext [

	^super context: aRenderContext
]

{ #category : 'instance creation' }
UpHtmlCanvas class >> context: aRenderContext [

	^(aRenderContext upOverrideRendererClass ifNil: [self]) _context: aRenderContext
]

{ #category : 'accessing' }
UpHtmlCanvas >> brush: aBrush [

	aBrush upInitialize.

	^super brush: aBrush
]

{ #category : 'tags' }
UpHtmlCanvas >> text: aString [ 

	self document isRendering ifTrue: [super text: aString]
]

{ #category : 'tags' }
UpHtmlCanvas >> upMain: aBlock [

	self div 
		upMain: true;
		with: aBlock
]
