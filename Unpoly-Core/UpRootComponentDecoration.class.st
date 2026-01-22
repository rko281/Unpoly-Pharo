Class {
	#name : 'UpRootComponentDecoration',
	#superclass : 'UpDecoration',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'updating' }
UpRootComponentDecoration >> addUnauthorizedRequestHandlerToRoot: htmlRoot [

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
})' expandMacrosWith: self decoratedComponent expiredSessionUrl)
]

{ #category : 'rendering' }
UpRootComponentDecoration >> renderContentOn: html [

	self 
		renderLayerOpenedFunctionOn: html;
		renderLayerClosedFunctionOn: html;
		renderLayerCancelledFunctionOn: html;
		renderNextOn: html.
]

{ #category : 'rendering' }
UpRootComponentDecoration >> renderLayerCancelledFunctionOn: html [

	| function script |

	function := JSFunction named: 'upLayerCancelled' arguments: #('id').

	script := html javascript.
	script 
		fetchCallback: [ :string | self session onLayerClosed: (UpEvent fromResponseString: string)]
		then: '(response => response.text()).then(toReload => {if (toReload !== '''') {up.reload(toReload)}})'
		values: {html javascript alias: '[''type'',''cancelled'',''layerID'',id]'}
		method: 'POST'.
	
	function add: script.
	html script: function
]

{ #category : 'rendering' }
UpRootComponentDecoration >> renderLayerClosedFunctionOn: html [

	| function script |

	function := JSFunction named: 'upLayerClosed' arguments: #('event').

	script := html javascript.
	script 
		fetchCallback: [ :string | self session onLayerClosed: (UpEvent fromResponseString: string)]
		then: '(response => response.text()).then(toReload => {if (toReload !== '''') {up.reload(toReload)}})'
		values: {html javascript alias: '([''type'',event.type].concat(Object.entries(event.layer.context))).concat(typeof event.value === "string" ? (["value",event.value]) : (Object.entries(event.value)))'}
		method: 'POST'.
	
	function add: script.
	html script: function
]

{ #category : 'rendering' }
UpRootComponentDecoration >> renderLayerOpenedFunctionOn: html [

	| function script |

	function := JSFunction named: 'upLayerOpened' arguments: #('event').

	script := html javascript.
	script 
		fetchCallback: [ :string | self session onLayerOpened: (UpEvent fromResponseString: string)]
		then: '(response => response.text()).then(layerId => {up.layer.current.id = layerId})'
		values: {html javascript alias: '[''type'',event.type].concat(Object.entries(event.layer.context))'}
		method: 'POST'.		
	
	function add: script.
	html script: function
]

{ #category : 'updating' }
UpRootComponentDecoration >> updateRoot: htmlRoot [

	super updateRoot: htmlRoot.

	"Use Unpoly for all links and forms"
	htmlRoot 
		addScript: 'up.link.config.followSelectors.push(''a[href]'')';
		addScript: 'up.link.config.noInstantSelectors.push(''a[href]'')';
		addScript: 'up.form.config.submitSelectors.push([''form''])'.

	self decoratedComponent shouldDisableUnpolyCaching ifTrue: [htmlRoot addScript: 'up.network.config.autoCache = function(request) {return false}'].

	self addUnauthorizedRequestHandlerToRoot: htmlRoot
]
