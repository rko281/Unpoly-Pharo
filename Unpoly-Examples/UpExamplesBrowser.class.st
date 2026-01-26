Class {
	#name : 'UpExamplesBrowser',
	#superclass : 'UpComponent',
	#instVars : [
		'currentExample'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'testing' }
UpExamplesBrowser class >> canBeRoot [

	^true
]

{ #category : 'accessing' }
UpExamplesBrowser class >> contextRoot [

	^'unpoly'
]

{ #category : 'class initialization' }
UpExamplesBrowser class >> initialize [

	self register
]

{ #category : 'class initialization' }
UpExamplesBrowser class >> register [

	^super register
		addLibrary: UpExamplesLibrary;
		yourself
]

{ #category : 'rendering' }
UpExamplesBrowser >> acceptToolbar [

	| rq |

	rq := self requestContext request.
	self hasExampleDelay: (rq postFields at: 'extraLatency' ifAbsent: ['off']) = 'on'
]

{ #category : 'accessing' }
UpExamplesBrowser >> children [

	^self currentExample
		ifNil: [#()]
		ifNotNil: [ :child | Array with: child]
]

{ #category : 'accessing' }
UpExamplesBrowser >> currentExample [

	^currentExample contents
]

{ #category : 'accessing' }
UpExamplesBrowser >> currentExample: anUpComponent [

	currentExample contents: anUpComponent
]

{ #category : 'accessing' }
UpExamplesBrowser >> defaultPath [
	
	^WAUrl new path: {self class contextRoot. self exampleClasses first subPath}
]

{ #category : 'accessing' }
UpExamplesBrowser >> exampleClasses [

	^UpExample allExamples sort: [ :a :b | a ordering = b ordering ifTrue: [a name <= b name] ifFalse: [a ordering < b ordering]]
]

{ #category : 'hooks' }
UpExamplesBrowser >> initialRequest: request [

	| url subPath |

	url := request url.
	subPath := url path last.
	subPath = self class contextRoot ifTrue: [^self requestContext redirectTo: self defaultPath].

	self navigateToExampleClass: 
		(self exampleClasses
			detect: [ :each |
				each subPath = subPath ]
			ifNone: [ self exampleClasses first ])
]

{ #category : 'initialization' }
UpExamplesBrowser >> initialize [

	super initialize.

	(self addDecoration: UpNotificationDecoration new) anchorRight.
			
	self exampleClasses do: [ :each | each initializeSession: self session].
	currentExample := WAValueHolder new
]

{ #category : 'operations' }
UpExamplesBrowser >> navigateToExampleClass: aClass [

	self currentExample: aClass new
]

{ #category : 'operations' }
UpExamplesBrowser >> newSession [

	self session unregister.
	self requestContext redirectTo: self defaultPath
]

{ #category : 'rendering' }
UpExamplesBrowser >> renderContentOn: html [

	html div 
		class: 'example-browser';
		with: 
			[self renderNavigationBarOn: html.

			html container
				class: 'current-example';
				with: 
					[html main: 
						[self renderExampleOn: html] ].

			self renderToolbarOn: html]
]

{ #category : 'rendering' }
UpExamplesBrowser >> renderExampleOn: html [

	self currentExample ifNotNil: [ :child | html render: child]
]

{ #category : 'rendering' }
UpExamplesBrowser >> renderNavigationBarOn: html [

	html navigationBar 
		expandMiddle;
		beLight;
		lightBackground;
		class: 'fixed-top';
		with: 
			[html navigationBarBrand
				url: (WAUrl absolute: self class contextRoot);
				upFollow: true;
				with: 'Unpoly Demo'.
			html navigationBarNavigation:
				[self exampleClasses do: 
					[ :cls || item|
					item := html navigationLink.
					item 
						callback: [ self navigateToExampleClass: cls ];
						class: 'nav-item';
						upTarget: '.current-example';
						url: (WAUrl new path: {self class contextRoot. cls subPath});
						with: cls exampleName ]].
			html div 
				class: 'flashes-explainer'; 
				upAnchored: 'right'; 
				with: 'Notifications go here'].

	"Required - rferenced from example js"
	html div 
		id: 'new-version';
		attributeAt: 'hidden' put: true
]

{ #category : 'rendering' }
UpExamplesBrowser >> renderToolbarOn: html [

	html navigationBar 
		expandMiddle;
		beLight;
		lightBackground;
		class: 'fixed-bottom';
		with: 
			[html navigationBarNavigation:
				[html navigationLink
					class: 'nav-item';
					upTarget: '.example-browser';
					upLocation: self defaultPath;
					callback: [ self newSession ];
					with: 'New Session' ].

				html space.

				html form
					upSubmit: true;
					upAutoSubmit: true;
					upTarget: '.fixed-bottom';
					with: 
						[html formGroup
							formCheck;
							marginTopAndBottom: 0;
							with: 
								[html formCheckbox
									name: 'extraLatency';
									id: 'configExtraLatency';
									on: #hasExampleDelay of: self; 
									with: 'Extra server delay']]]
]

{ #category : 'accessing' }
UpExamplesBrowser >> states [

	^super states, {currentExample}
]

{ #category : 'hooks' }
UpExamplesBrowser >> style [

	^self currentExample
		ifNil: [super style] 
		ifNotNil: [ :child | child style]
]

{ #category : 'accessing' }
UpExamplesBrowser >> topLevelIdentifier [

	^'.example-browser'
]

{ #category : 'updating' }
UpExamplesBrowser >> updateRoot: htmlRoot [

	super updateRoot: htmlRoot.

	htmlRoot title: 'Unpoly for Seaside' translated
]
