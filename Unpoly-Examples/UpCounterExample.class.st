Class {
	#name : 'UpCounterExample',
	#superclass : 'UpComponentExample',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'constants' }
UpCounterExample class >> exampleName [
	^'Counter'
]

{ #category : 'constants' }
UpCounterExample class >> ordering [
	^10
]

{ #category : 'constants' }
UpCounterExample class >> subPath [
	^'counter'
]

{ #category : 'constants' }
UpCounterExample >> componentClass [

	^UpCounter
]

{ #category : 'rendering' }
UpCounterExample >> renderDescriptionOn: html [

	html 
		paragraph: 'The venerable Seaside Counter example enhanced with Bootstrap and Unpoly.'; 
		paragraph: [html withLineBreaks: 'The counter is configured as an Unpoly target which is updated without refreshing the entire page.<N>This also prevents the address bar updating with the full Seaside URL.' expandMacros]; 
		paragraph: [html withLineBreaks: 'Note this removes the ability to update the counter with the Back/Forward buttons.<N>Thus the counter behaves like the JQuery Counter example but without needing any JQuery in the Seaside code' expandMacros]
]
