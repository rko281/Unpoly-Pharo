Class {
	#name : 'UpCompanyPresenter',
	#superclass : 'UpExamplePresenter',
	#instVars : [
		'companyProjects'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'hooks' }
UpCompanyPresenter >> children [

	^super children, {self companyProjects}
]

{ #category : 'accessing' }
UpCompanyPresenter >> companyProjects [

	^companyProjects ifNil: [companyProjects := UpCompanyProjects on: self model]
]

{ #category : 'rendering' }
UpCompanyPresenter >> renderContentOn: html [
	
	super renderContentOn: html.

	html definitionList with: 
		[html definitionTerm marginBottom: 1; with: 'Name'.
		html definitionData marginBottom: 2; with: self model name.
		html definitionTerm marginBottom: 1; with: 'Address'.
		html definitionData marginBottom: 2; with: [html withLineBreaks: (self model address ifNil: ['-'])]].

	html div 
		id: 'projects';
		with: [html render: self companyProjects]
]
