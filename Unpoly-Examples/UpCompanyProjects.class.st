Class {
	#name : 'UpCompanyProjects',
	#superclass : 'UpProjectsApplication',
	#instVars : [
		'company'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'testing' }
UpCompanyProjects class >> isAbstract [

	"Not really abstract but needs excluding from the list of examples"

	^true
]

{ #category : 'instance creation' }
UpCompanyProjects class >> on: anUpCompany [

	^self new
		company: anUpCompany;
		yourself
]

{ #category : 'accessing' }
UpCompanyProjects >> company [
	^company
]

{ #category : 'accessing' }
UpCompanyProjects >> company: anObject [
	company := anObject
]

{ #category : 'accessing' }
UpCompanyProjects >> list [

	^self company projects
]

{ #category : 'accessing' }
UpCompanyProjects >> newModel [

	^super newModel
		company: self company;
		yourself
]

{ #category : 'accessing' }
UpCompanyProjects >> newModelEditorLayer [

	^super newModelEditorLayer
		contextAt: 'from-company' put: true;
		yourself
]

{ #category : 'accessing' }
UpCompanyProjects >> presenterLayerFor: aProject [

	^(super presenterLayerFor: aProject)
		contextAt: 'from-company' put: true;
		yourself
]

{ #category : 'rendering' }
UpCompanyProjects >> renderAdditionalColumnHeadingsOn: html [

	html tableHeading: 'Budget'
]

{ #category : 'rendering' }
UpCompanyProjects >> renderAdditionalColumnsFor: aProject on: html [

	html tableData
		align: 'right';
		with: aProject budgetStringWithCurrency
]

{ #category : 'rendering' }
UpCompanyProjects >> renderHeaderOn: html [

	html row 
		alignItemsCenter;
		marginBottom: 2;
		gutterX: 2;
		with: 
			[html column variableWidth with: [html heading level4 with: self class exampleName].
			html column smallVariableWidth with: 
				[html linkButton
					bePrimary;
					beSmall;
					showLayer: self newModelEditorLayer in: self;
					with: 'Add ', self modelClass description]]
]

{ #category : 'rendering' }
UpCompanyProjects >> renderPlaceholdersOn: html [

	"Not required"
]
