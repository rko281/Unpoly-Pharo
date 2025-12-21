Class {
	#name : 'UpBootstrap5Library',
	#superclass : 'SBSFileLibrary',
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'public' }
UpBootstrap5Library >> cssunpolybootstrap5Css [
	^ WAFileLibraryResource
		filepath: 'css/unpoly.bootstrap5.css'
		mimeType: (WAMimeType main: 'text' sub: 'css')
		cacheDuration: (Duration days: 0 hours: 0 minutes: 30 seconds: 0)
		contents: (GRDelayedSend receiver: self selector: #cssunpolybootstrap5CssContent)
]

{ #category : 'public' }
UpBootstrap5Library >> cssunpolybootstrap5CssContent [

	^'up-modal .container,up-modal .container-fluid,up-drawer .container,up-drawer .container-fluid,up-popup .container,up-popup .container-fluid{padding-left:0;padding-right:0;max-width:none}'
]

{ #category : 'accessing' }
UpBootstrap5Library >> selectorsToInclude [

	^#(#cssunpolybootstrap5Css)
]
