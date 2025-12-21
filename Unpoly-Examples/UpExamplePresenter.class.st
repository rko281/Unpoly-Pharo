Class {
	#name : 'UpExamplePresenter',
	#superclass : 'UpComponent',
	#instVars : [
		'model'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'instance creation' }
UpExamplePresenter class >> on: anUpExampleModel [

	^self new
		model: anUpExampleModel;
		yourself
]

{ #category : 'operations' }
UpExamplePresenter >> delete [

	self exampleWait.
	self answer: #deleted
]

{ #category : 'operations' }
UpExamplePresenter >> edit [

	| editor |

	editor := self editorClass on: self model copy.

	self show: editor onAnswer: 
		[ :confirmed |
		confirmed ifTrue: 
			[self exampleWait.
			self model updateFrom: editor model.
			self session notification: [ :html | html alert beSuccess; with: ('<1s> saved successfully' expandMacrosWith: editor model class description)]]]
]

{ #category : 'accessing' }
UpExamplePresenter >> editorClass [

	^self model editorClass
]

{ #category : 'accessing' }
UpExamplePresenter >> model [
	^model
]

{ #category : 'accessing' }
UpExamplePresenter >> model: anObject [
	model := anObject
]

{ #category : 'rendering' }
UpExamplePresenter >> renderContentOn: html [

	html row
		alignItemsCenter;
		marginBottom: 4;
		with: 
			[html column variableWidth with: [html heading level2 with: ('<1s> #<2p>' expandMacrosWithArguments: {self model class description. self model id})].
			html column 
				smallVariableWidth
				with: 
					[html linkButton 
						bePrimary; 
						upPreview: 'main-spinner';
						callback: [self edit];
						with: 'Edit'.
					html linkButton 
						beDanger;
						upConfirm: 'Really delete?';
						upPreview: 'btn-spinner';
						callback: [self delete];
						with: 'Delete']]
]
