Class {
	#name : 'UpExampleEditor',
	#superclass : 'UpComponent',
	#instVars : [
		'model',
		'errorMessages'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'instance creation' }
UpExampleEditor class >> on: anUpExampleModel [

	^self new
		model: anUpExampleModel;
		yourself
]

{ #category : 'operations' }
UpExampleEditor >> accept [

	| isValid isValidating |

	self refreshErrorMessages.

	isValidating  := self requestContext request isUpValidating.
	isValid := errorMessages isEmpty.

	(isValidating not and: [isValid]) ifTrue: [self answer: true]
]

{ #category : 'accessing' }
UpExampleEditor >> allModels [

	^self subclassResponsibility
]

{ #category : 'operations' }
UpExampleEditor >> cancel [

	self answer: false
]

{ #category : 'initializing' }
UpExampleEditor >> initialize [

	super initialize.

	self initializeErrorMessages
]

{ #category : 'initializing' }
UpExampleEditor >> initializeErrorMessages [

	errorMessages := IdentityDictionary new
]

{ #category : 'accessing' }
UpExampleEditor >> model [
	^model
]

{ #category : 'accessing' }
UpExampleEditor >> model: anObject [
	model := anObject
]

{ #category : 'accessing' }
UpExampleEditor >> nameErrorMessage [

	self model name ifNotNil: 
		[ :name | 
		name isEmpty ifTrue: [^'can''t be blank'].
		(self allModels anySatisfy: [ :each | each ~= self model and: [each name match: name ]]) ifTrue: [^'has already been taken']].

	^nil
]

{ #category : 'operations' }
UpExampleEditor >> refreshErrorMessages [

	self initializeErrorMessages.

	self nameErrorMessage ifNotNil: [ :message | errorMessages at: #name put: message]
]

{ #category : 'rendering' }
UpExampleEditor >> renderContentOn: html [

	html heading
		level2;
		marginBottom: 4;
		with: ((self model id ifNil: ['New <1s>'] ifNotNil: [ :id | 'Edit <1s> ', id displayString]) expandMacrosWith: self model class description).

	html form
		upSubmit: true;
		upValidate: true;
		upDisable: true;
		upHistory: false;
		upPreview: 'btn-spinner';
		with: 
			[self renderFormFieldsOn: html.

			html div
				displayFlex;
				marginTop: 4;
				alignItemsCenter;
				with: 
					[html div 
						flexGrow: 1;
						with: 
							[html formButton
								beSubmit;
								bePrimary;
								callback: [self accept];
								with: 'Save'].
					html div with: 
							[html linkButton
								upPreview: 'main-spinner';
								class: 'btn-outline-secondary';
								callback: [self cancel];
								with: 'Cancel']]]
]

{ #category : 'rendering' }
UpExampleEditor >> renderFieldSet: aBlock for: aSymbol on: html [ 

	| fieldSet |

	fieldSet := html fieldSet id: aSymbol.

	(errorMessages at: aSymbol ifAbsent: [nil]) 
	ifNil: 
		[fieldSet with: aBlock]
	ifNotNil: 
		[ :errorMessage | 
		fieldSet with:
			[html div
				class: 'field_with_errors';
				with: aBlock.
			html small 
				class: 'form-text form-error';
				with: errorMessage]]
]

{ #category : 'rendering' }
UpExampleEditor >> renderFormFieldsOn: html [

	self subclassResponsibility
]
