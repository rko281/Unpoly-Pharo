Class {
	#name : 'UpComponentExample',
	#superclass : 'UpExample',
	#instVars : [
		'component'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'testing' }
UpComponentExample class >> isAbstract [
	^self name = #UpComponentExample
]

{ #category : 'constants' }
UpComponentExample >> componentClass [

	^self subclassResponsibility
]

{ #category : 'accessing' }
UpComponentExample >> exampleSource [

	^(self componentClass>>#renderContentOn:) sourceCode
]

{ #category : 'initialize/release' }
UpComponentExample >> initialize [

	super initialize.
	component := self componentClass new
]

{ #category : 'rendering' }
UpComponentExample >> renderContentOn: html [

	self renderDescriptionOn: html.

	html row
		alignItemsCenter;
		marginTop: 4;
		marginBottom: 4;
		gutterX: 2;
		with: 
			[html column variableWidth with: [html render: component]].

	html break;break.
	html heading level2; with: 'Smalltalk source code'.
	html horizontalRule.
	html preformatted style: 'width: 100%'; with: [html code dataAttributeAt: 'highlighted' put: 'yes'; with: self exampleSource]
]

{ #category : 'rendering' }
UpComponentExample >> renderDescriptionOn: html [

	self subclassResponsibility
]
