Class {
	#name : 'UpMultiCounter',
	#superclass : 'WAMultiCounter',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'initialization' }
UpMultiCounter >> initialize [

	super initialize.

	counters := (1 to: 9) collect: [:each | UpCounter new]
]

{ #category : 'rendering' }
UpMultiCounter >> renderContentOn: html [

	html row: 
		[counters do: 
			[ :each | 
			(html columnUnits: 4 size: #small)
				textCenter;
				marginBottom: 2;
				with: [ html render: each ]]]
]

{ #category : 'rendering' }
UpMultiCounter >> rendererClass [

	^UpHtmlCanvas
]
