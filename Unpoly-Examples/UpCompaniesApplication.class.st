Class {
	#name : 'UpCompaniesApplication',
	#superclass : 'UpExampleApplication',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'constants' }
UpCompaniesApplication class >> exampleName [
	^'Companies'
]

{ #category : 'initializing' }
UpCompaniesApplication class >> initializeSession: anUpSession [

	anUpSession properties at: #database put: UpExampleDatabase new
]

{ #category : 'constants' }
UpCompaniesApplication class >> ordering [
	^30
]

{ #category : 'constants' }
UpCompaniesApplication class >> subPath [
	^'companies'
]

{ #category : 'add/remove' }
UpCompaniesApplication >> add: aCompany [

	self database addCompany: aCompany
]

{ #category : 'add/remove' }
UpCompaniesApplication >> delete: aCompany [

	self database removeCompany: aCompany
]

{ #category : 'accessing' }
UpCompaniesApplication >> list [

	^self database companies
]

{ #category : 'constants' }
UpCompaniesApplication >> modelClass [

	^UpCompany
]
