Class {
	#name : 'UpExampleApplication',
	#superclass : 'UpExample',
	#instVars : [
		'searchValue'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'testing' }
UpExampleApplication class >> isAbstract [
	^self name = #UpExampleApplication
]

{ #category : 'add/remove' }
UpExampleApplication >> add: aModel [

	^self subclassResponsibility
]

{ #category : 'add/remove' }
UpExampleApplication >> delete: aModel [

	^self subclassResponsibility
]

{ #category : 'constants' }
UpExampleApplication >> editorClass [

	^self modelClass editorClass
]

{ #category : 'accessing' }
UpExampleApplication >> filteredList [

	^self searchPattern
		ifNil: [self list]
		ifNotNil: [ :pattern | self list select: [ :each | each matches: pattern]]
]

{ #category : 'accessing' }
UpExampleApplication >> list [

	^self subclassResponsibility
]

{ #category : 'constants' }
UpExampleApplication >> modelClass [

	^self subclassResponsibility
]

{ #category : 'accessing' }
UpExampleApplication >> newModel [

	^self modelClass new
]

{ #category : 'accessing' }
UpExampleApplication >> newModelEditorLayer [

	^UpLayer modal
		containing: 
			[self exampleWait. 
			self editorClass on: self newModel];
		placeholder: self editorClass asPlaceholder;
		onClosed: [ :event | self onEditorClosed: event model: event layer component model];
		onClosedReload: '.table';
		yourself
]

{ #category : 'event handling' }
UpExampleApplication >> onEditorClosed: closeEvent model: aModel [

	(closeEvent isDismissal not and: [closeEvent value]) ifTrue: 
		[self add: closeEvent layer component model.
		self session notification: [ :html | html alert beSuccess; with: ('<1s> saved successfully' expandMacrosWith: self modelClass description)]]
]

{ #category : 'event handling' }
UpExampleApplication >> onPresenterClosed: closeEvent model: aModel [

	closeEvent value = #deleted ifTrue: [self delete: aModel]
]

{ #category : 'constants' }
UpExampleApplication >> presenterClass [

	^self modelClass presenterClass
]

{ #category : 'accessing' }
UpExampleApplication >> presenterLayerFor: aModel [

	^UpLayer modal
		containing: 
			[self exampleWait. 
			self presenterClass on: aModel];
		placeholder: self presenterClass asPlaceholder;
		onAnswer: [ :result | result = #deleted ifTrue: [self delete: aModel]];
		onClosedReload: '.table';
		yourself
]

{ #category : 'rendering' }
UpExampleApplication >> renderAdditionalColumnHeadingsOn: html [
]

{ #category : 'rendering' }
UpExampleApplication >> renderAdditionalColumnsFor: aModel on: html [
]

{ #category : 'rendering' }
UpExampleApplication >> renderContentOn: html [

	self 
		renderHeaderOn: html;
		renderTableOn: html;
		renderPlaceholdersOn: html
]

{ #category : 'rendering' }
UpExampleApplication >> renderHeaderOn: html [

	html row 
		alignItemsCenter;
		marginBottom: 4;
		gutterX: 2;
		with: 
			[html column variableWidth with: [html heading level2 with: 'All ', self class exampleName].
			html column smallVariableWidth with: 
				[html form
					class: 'd-inline-block';
					upSubmit: true ;
					upAutoSubmit: true;
					upTarget: '.table';
					upWatchDelay: 500;
					with: 
						[html searchInput
							formControl;
							name: 'query';
							placeholder: 'Search…';
							autocomplete: 'off';
							on: #searchValue of: self;
							size: 17.
						html span class: 'search-spinner']].
			html column smallVariableWidth with: 
				[html linkButton
					bePrimary;
					showLayer: self newModelEditorLayer in: self;
					with: 'New ', self modelClass description]]
]

{ #category : 'rendering' }
UpExampleApplication >> renderModel: aModel on: html [

	html tableData: 
		[html anchor
			showLayer: (self presenterLayerFor: aModel) in: self;
			with: aModel name].

	self renderAdditionalColumnsFor: aModel on: html
]

{ #category : 'rendering' }
UpExampleApplication >> renderPlaceholdersOn: html [

	UpCompanyPresenter new
		model: UpCompany template;
		renderAsPlaceholderOn: html.

	UpCompanyEditor new
		model: UpCompany template;
		renderAsPlaceholderOn: html.

	UpProjectPresenter new
		model: UpProject template;
		renderAsPlaceholderOn: html.

	UpProjectEditor new
		model: UpProject template;
		renderAsPlaceholderOn: html.
]

{ #category : 'rendering' }
UpExampleApplication >> renderTableOn: html [

	html table
		class: 'table';
		with: 
			[html tableHead: 
				[html tableRow: 
					[html tableHeading: 'Name'.
					self renderAdditionalColumnHeadingsOn: html]].
			html tableBody: 
				[self filteredList do: 
					[:each | 
					html tableRow: 
						[self
							renderModel: each
							on: html ] ] ] ]
]

{ #category : 'accessing' }
UpExampleApplication >> searchPattern [

	^(searchValue ifNil: ['']) isEmpty
		ifTrue: [nil]
		ifFalse: ['*', searchValue , '*']
]

{ #category : 'accessing' }
UpExampleApplication >> searchValue [
	^searchValue
]

{ #category : 'accessing' }
UpExampleApplication >> searchValue: aString [
	searchValue := aString.
	self exampleWait
]
