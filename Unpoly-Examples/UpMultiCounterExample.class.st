Class {
	#name : 'UpMultiCounterExample',
	#superclass : 'UpComponentExample',
	#instVars : [
		'counters'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'constants' }
UpMultiCounterExample class >> exampleName [
	^'Multi-Counter'
]

{ #category : 'constants' }
UpMultiCounterExample class >> ordering [
	^20
]

{ #category : 'constants' }
UpMultiCounterExample class >> subPath [
	^'multicounter'
]

{ #category : 'constants' }
UpMultiCounterExample >> componentClass [
	^UpMultiCounter
]

{ #category : 'rendering' }
UpMultiCounterExample >> renderDescriptionOn: html [

	html text: 'The Seaside Multi-Counter example enhanced with Bootstrap and Unpoly.'
]
