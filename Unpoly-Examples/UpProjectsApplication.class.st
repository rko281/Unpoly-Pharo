Class {
	#name : 'UpProjectsApplication',
	#superclass : 'UpExampleApplication',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'constants' }
UpProjectsApplication class >> exampleName [
	^'Projects'
]

{ #category : 'constants' }
UpProjectsApplication class >> ordering [
	^40
]

{ #category : 'constants' }
UpProjectsApplication class >> subPath [
	^'projects'
]

{ #category : 'adding' }
UpProjectsApplication >> add: aProject [

	self database addProject: aProject
]

{ #category : 'adding' }
UpProjectsApplication >> delete: aProject [

	self database removeProject: aProject
]

{ #category : 'accessing' }
UpProjectsApplication >> list [

	^self database projects
]

{ #category : 'constants' }
UpProjectsApplication >> modelClass [

	^UpProject
]

{ #category : 'rendering' }
UpProjectsApplication >> renderAdditionalColumnHeadingsOn: html [

	html tableHeading: 'Company'
]

{ #category : 'rendering' }
UpProjectsApplication >> renderAdditionalColumnsFor: aProject on: html [

	html tableData: aProject company name
]
