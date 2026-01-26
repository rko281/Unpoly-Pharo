Class {
	#name : 'UpComponent',
	#superclass : 'SBSComponent',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'accessing' }
UpComponent class >> contextRoot [
	"Return a string representing the context root name (part of the URL) to access this component as a standalone application"

	^self error: 'root component classes must implement contextRoot'
]

{ #category : 'utilities' }
UpComponent class >> openBrowser [
	WebBrowser openOn: 'http://localhost:8080/', self contextRoot
]

{ #category : 'utilities' }
UpComponent class >> register [

	| app decorators |

	app := WAAdmin register: self asApplicationAt: self contextRoot.

	app
		addLibrary: SBSDeploymentLibrary;
		addLibrary: UpDeploymentLibrary;
		addLibrary: UpBootstrap5Library.

	"UpDeploymentLibrary breaks the standard Seaside toolbar (needs investigating)"
	decorators := app preferenceAt: #rootDecorationClasses.
	app preferenceAt: #rootDecorationClasses put: (decorators reject: [:each | each key = #WAToolDecoration]).

	^app 
		sessionClass: UpSession;
		preferenceAt: #renderPhaseContinuationClass put: UpRenderPhaseContinuation;
		preferenceAt: #initialContinuationClass put: UpInitialRenderLoopContinuation;
		preferenceAt: #trackingStrategy put: UpSessionTrackingStrategy new;
		yourself
]

{ #category : 'accessing' }
UpComponent >> database [

	^self session properties at: #database
]

{ #category : 'accessing' }
UpComponent >> expiredSessionUrl [

	"Answer the URL of the page to show when a session has expired.
	Default - just go back to the root"

	^self class contextRoot
]

{ #category : 'initialization' }
UpComponent >> initialize [

	super initialize.

	self isRoot ifTrue: [self addDecoration: UpRootComponentDecoration new]
]

{ #category : 'testing' }
UpComponent >> isRoot [

	"Am I a root application?
	Default - if I can be a root, I am"

	^self class canBeRoot
]

{ #category : 'accessing' }
UpComponent >> layerContextAt: aSymbol [

	^self layerContextAt: aSymbol ifAbsent: [self error: 'not found']
]

{ #category : 'accessing' }
UpComponent >> layerContextAt: aSymbol ifAbsent: aBlock [

	^self session currentLayer
		ifNil: [aBlock value]
		ifNotNil: [ :layer | layer contextAt: aSymbol ifAbsent: aBlock]
]

{ #category : 'rendering' }
UpComponent >> rendererClass [

	^UpHtmlCanvas
]

{ #category : 'testing' }
UpComponent >> shouldDisableUnpolyCaching [

	"Answer whether the receiver should disable all Unpoly caching.
	By default caching is DISABLED.
	The reasoning is that Seaside workflow typically involves callbacks with side-effects so caching is undesirable.
	Disabling caching also disables preloading of links which can be dangerous where following a link invokes a callaback causing a state change on the server.

	Override to return false to enable default Unpoly caching; note you may then need to set the following on individual elements to prevent unsafe behaviour:
		upCache:
		upPreload:
		upMethod: 

	https://unpoly.com/caching
	https://unpoly.com/preloading"

	^true
]

{ #category : 'delegation' }
UpComponent >> show: aComponent onAnswer: aBlock [

	self session currentLayer ifNotNil: [ :layer | layer component: aComponent].

	^super show: aComponent onAnswer: aBlock
]

{ #category : 'hooks' }
UpComponent >> states [

	"Include the current layer state. Subclass implementations must super send this message"

	^{self session currentLayerState}
]
