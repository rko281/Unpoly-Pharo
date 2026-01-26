Class {
	#name : 'UpRootComponentDecoration',
	#superclass : 'UpDecoration',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'rendering' }
UpRootComponentDecoration >> renderContentOn: html [

	self 
		renderUnauthorizedRequestHandlerOn: html;
		renderUpConfigOn: html;
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
		values: {html javascript alias: '[''type'',''cancelled'',''layerId'',id]'}
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

{ #category : 'rendering' }
UpRootComponentDecoration >> renderUnauthorizedRequestHandlerOn: html [

	"Private - When a callback is unmatched (e.g. expired) our tracking strategy responds with a 401 error. 
	The following ever handler then matches this and redirects to the expired page, forcing a full-page refresh
	This is necessary to avoid Unpoly only updating the target fragment of the originating button/link"

	| stream |

	stream := JSStream new.

	stream
		nextPutAll: 'up.on(''up:request:loaded'', function (event) {
  if (event.response.status === 401) {
    // Close any layers
up.layer.dismissOverlays();
    // Force Unpoly to do a full reload
window.location.reload(true);
window.location = '''; 
		nextPutAll: self decoratedComponent expiredSessionUrl;
		nextPutAll: ''' } })'.

	html script: 
		(html javascript
			add: stream;
			yourself)
]

{ #category : 'rendering' }
UpRootComponentDecoration >> renderUpConfigOn: html [

	| stream |

	stream := JSStream new.

	"Use Unpoly for all links and forms"
	stream
		nextPutAll: 'up.link.config.followSelectors.push(''a[href]'');';
		nextPutAll: 'up.link.config.noInstantSelectors.push(''a[href]'');';
		nextPutAll: 'up.form.config.submitSelectors.push([''form'']);'.

	self decoratedComponent shouldDisableUnpolyCaching ifTrue: [stream nextPutAll: 'up.network.config.autoCache = function(request) {return false};'].

	html script: 
		(html javascript
			add: stream;
			yourself)
]
