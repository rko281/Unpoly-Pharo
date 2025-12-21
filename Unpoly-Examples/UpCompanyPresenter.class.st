Class {
	#name : 'UpCompanyPresenter',
	#superclass : 'UpExamplePresenter',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

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
		with: [html render: (UpCompanyProjects on: self model)]
]
