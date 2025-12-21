Class {
	#name : 'UpRootComponent',
	#superclass : 'UpComponent',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'testing' }
UpRootComponent class >> canBeRoot [

	^ true
]

{ #category : 'accessing' }
UpRootComponent class >> contextRoot [
	"Return a string representing the context root name (part of the URL) to access this
	 component as a standalone application"

	^self subclassResponsibility
]

{ #category : 'public' }
UpRootComponent class >> register [

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

{ #category : 'updating' }
UpRootComponent >> addUnauthorizedRequestHandlerToRoot: htmlRoot [

	"Private - When a callback is unmatched (e.g. expired) our tracking strategy responds with a 401 error. 
	The following ever handler then matches this and redirects to the expired page, forcing a full-page refresh
	This is necessary to avoid Unpoly only updating the target fragment of the originating button/link"

	htmlRoot addScript: 
('up.on(''up:request:loaded'', function (event) {
  if (event.response.status === 401) {
    // Close any layers
up.layer.dismissOverlays();
    // Force Unpoly to do a full reload
window.location.reload(true);
window.location = ''<1s>''
  }
})' expandMacrosWith: self expiredSessionUrl)
]

{ #category : 'accessing' }
UpRootComponent >> expiredSessionUrl [

	"Answer the URL of the page to show when a session has expired.
	Default - just go back to the root"

	^self class contextRoot
]

{ #category : 'initialization' }
UpRootComponent >> initialize [

	super initialize.	

	self addDecoration: UpLayerHostDecoration new
]

{ #category : 'accessing' }
UpRootComponent >> parentComponent [

	^nil
]

{ #category : 'testing' }
UpRootComponent >> shouldDisableUnpolyCaching [

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

{ #category : 'updating' }
UpRootComponent >> updateRoot: htmlRoot [

	super updateRoot: htmlRoot.

	self shouldDisableUnpolyCaching ifTrue: [htmlRoot addScript: 'up.network.config.autoCache = function(request) {return false}'].
htmlRoot addScript: 'console.warn(''here'')'.
	self addUnauthorizedRequestHandlerToRoot: htmlRoot.

	"Ensure we always have a layer host"
	self beLayerHost
]
