Class {
	#name : 'UpCounter',
	#superclass : 'WACounter',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'actions' }
UpCounter >> decrease [

	self exampleWait.
	self session notification: [ :html | html alert beDanger; with: 'Counter Decreased'].

	super decrease
]

{ #category : 'actions' }
UpCounter >> increase [

	self exampleWait.
	self session notification: [ :html | html alert beSuccess; with: 'Counter Increased'].

	super increase
]

{ #category : 'rendering' }
UpCounter >> renderContentOn: html [

	| rq counter |

	html row with: 
		[(html columnUnits: 12)
			textCenter;
			with: [counter := html heading beUpTarget with: count]].

	html row: 
		[(html columnUnits: 6)
			textEnd;
			with: 
				[html linkButton 
					bePrimary;
					upTarget: counter;
					upTransition: 'cross-fade';
					upPreview: 'btn-spinner';
					callback: [ self increase ];
					with: '++'].

		(html columnUnits: 6)
			textStart; 
			with: 
				[html linkButton 
					beDanger; 
					upTarget: counter;
					upTransition: 'cross-fade';
					upPreview: 'btn-spinner';
					callback: [ self decrease ];
					with: '--']]
]

{ #category : 'rendering' }
UpCounter >> rendererClass [

	^UpHtmlCanvas
]
