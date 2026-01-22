Class {
	#name : 'UpProjectPresenter',
	#superclass : 'UpExamplePresenter',
	#instVars : [
		'project'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'rendering' }
UpProjectPresenter >> renderContentOn: html [

	super renderContentOn: html.

	html definitionList id: 'project'; with: 
		[html definitionTerm marginBottom: 1; with: 'Name'.
		html definitionData marginBottom: 2; with: self model name.
		html definitionTerm marginBottom: 1; with: 'Company'.
		html definitionData marginBottom: 2; with: 
			[html anchor
				upNoTab: true;
				upPlaceholder: UpCompanyPresenter asPlaceholder;
				callback: [self viewCompany];
				with: self model company name].
		html definitionTerm marginBottom: 1; with: 'Budget'.
		html definitionData marginBottom: 2; with: self model budgetStringWithCurrency]
]

{ #category : 'rendering' }
UpProjectPresenter >> viewCompany [

	self exampleWait.

	self show: (UpCompanyPresenter on: self model company) onAnswer: 
		[ :result | 
		result = #deleted ifTrue: 
			[self database removeCompany: self model company.
			self answer]]
]
