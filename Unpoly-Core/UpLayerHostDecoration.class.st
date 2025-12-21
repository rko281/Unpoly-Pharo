Class {
	#name : 'UpLayerHostDecoration',
	#superclass : 'UpDecoration',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'rendering' }
UpLayerHostDecoration >> renderContentOn: html [

	self 
		renderLayerOpenedFunctionOn: html;
		renderLayerClosedFunctionOn: html;
		renderLayerCancelledFunctionOn: html;
		renderNextOn: html.
]

{ #category : 'rendering' }
UpLayerHostDecoration >> renderLayerCancelledFunctionOn: html [

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
UpLayerHostDecoration >> renderLayerClosedFunctionOn: html [

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
UpLayerHostDecoration >> renderLayerOpenedFunctionOn: html [

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
