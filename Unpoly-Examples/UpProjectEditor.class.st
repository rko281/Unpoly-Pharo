Class {
	#name : 'UpProjectEditor',
	#superclass : 'UpExampleEditor',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'accessing' }
UpProjectEditor >> allCompanies [

	^(self session properties at: #database) companies
]

{ #category : 'accessing' }
UpProjectEditor >> allModels [

	^(self session properties at: #database) projects
]

{ #category : 'accessing' }
UpProjectEditor >> budgetErrorMessage [

	self model budget isNil ifTrue: [^'is not a number'].
	self model budget < 100 ifTrue: [^'must be greater than or equal to 100'].

	^nil
]

{ #category : 'accessing' }
UpProjectEditor >> companyErrorMessage [

	^self model company isNil 
		ifTrue: ['can''t be blank']
		ifFalse: [nil]
]

{ #category : 'testing' }
UpProjectEditor >> isFromCompanyPresenter [

	^self layerContextAt: 'from-company' ifAbsent: [false]
]

{ #category : 'accessing' }
UpProjectEditor >> nameSuggester [

	^UpLayer popup
		containing: UpNameSuggester new;
		onAnswer: [ :name | self model name: name];
		onClosedReload: '#name-field';
		yourself
]

{ #category : 'accessing' }
UpProjectEditor >> newCompanyLayer [

	^UpLayer modal
		containing: 
			[UpCompanyEditor on: UpCompany new];
		onClosed: [ :event | self onNewCompanyEditorClosed: event];
		onClosedReload: '#company';
		yourself
]

{ #category : 'event handling' }
UpProjectEditor >> onNewCompanyEditorClosed: closeEvent [

	| newCompany |

	(closeEvent isDismissal not and: [closeEvent value]) ifTrue: 
		[newCompany := closeEvent layer component model.
		self database addCompany: newCompany.
		self model company: newCompany]
]

{ #category : 'operations' }
UpProjectEditor >> refreshErrorMessages [

	super refreshErrorMessages.

	self budgetErrorMessage ifNotNil: [ :message | errorMessages at: #budget put: message].
	self companyErrorMessage ifNotNil: [ :message | errorMessages at: #company put: message]
]

{ #category : 'rendering' }
UpProjectEditor >> renderFormFieldsOn: html [

	self
		renderFieldSet:  
			[html label: 'Name'. 
			html inputGroup:
				[html formTextInput 
					id: 'name-field';
					on: #name of: self model.
				html linkButton
					beOutline;
					beSecondary;
					showLayer: self nameSuggester in: self;
					with: 'Suggest Name']]
		for: #name
		on: html.

	self isFromCompanyPresenter ifFalse:  
		[self
			renderFieldSet:  
				[html label: 'Company'. 
				html inputGroup: 
					[html formSelect
						id: 'company';
						labels: [ :each | each ifNil: ['<select a company>'] ifNotNil: [ :company | company name]];
						list: ({nil}, self allCompanies);
						selected: self model company;
						callback: [ :value | self model company: value ] .
					html linkButton
						beOutline;
						beSecondary;
						showLayer: self newCompanyLayer in: self;
						with: 'New Company']]
			for: #company
			on: html].

	self
		renderFieldSet:  
			[html label: 'Budget'. 
			html inputGroup: 
				[html formTextInput on: #budgetString of: self model.
				html inputGroupAppend: [html inputGroupText: self model currency]]]
		for: #budget
		on: html
]
