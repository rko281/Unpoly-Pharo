Extension { #name : 'UpComponent' }

{ #category : '*Unpoly-Placeholders' }
UpComponent class >> asPlaceholder [

	"Return a reasonably nice stringified version of the receiver to use as an id for a placeholder"

	^self name asHtmlTagId, '-placeholder'
]

{ #category : '*Unpoly-Placeholders' }
UpComponent >> renderAsPlaceholder: aString class: classString on: html [

	"Render this component as a placeholder, i.e. a temporary view to be shown whilst waiting for a real view to load.
	aString is the id of the placeholder.
	classString is the style class of the placeholder (optional)"

	| placeholderCanvas |

	placeholderCanvas := UpPlaceholderHtmlCanvas on: html.

	html template
		id: aString;
		with: 
			[html div
				class: classString;
				with: [html context upRenderWithClass: UpPlaceholderHtmlCanvas during: [self renderContentOn: placeholderCanvas]]]
]

{ #category : '*Unpoly-Placeholders' }
UpComponent >> renderAsPlaceholder: aString on: html [

	"Render this component as a placeholder, i.e. a temporary view to be shown whilst waiting for a real view to load.
	aString is the id of the placeholder"

	^self renderAsPlaceholder: aString class: 'placeholder-wave' on: html
]

{ #category : '*Unpoly-Placeholders' }
UpComponent >> renderAsPlaceholderOn: html [

	"Render this component as a placeholder, i.e. a temporary view to be shown whilst waiting for a real view to load"

	^self renderAsPlaceholder: self class asPlaceholder on: html
]
