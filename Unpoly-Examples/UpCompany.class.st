Class {
	#name : 'UpCompany',
	#superclass : 'UpExampleModel',
	#instVars : [
		'address',
		'projects'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'constants' }
UpCompany class >> description [

	^'Company'
]

{ #category : 'constants' }
UpCompany class >> editorClass [

	^UpCompanyEditor
]

{ #category : 'instance creation' }
UpCompany class >> new [

	^super new
		projects: OrderedCollection new;
		yourself
]

{ #category : 'constants' }
UpCompany class >> presenterClass [

	^UpCompanyPresenter
]

{ #category : 'instance creation' }
UpCompany class >> template [

	^self new
		name: 'Acme Corporation';
		address: '123 Some Street<N>Some Town<N>Somewhere' expandMacros;
		yourself
]

{ #category : 'add/remove' }
UpCompany >> addProject: aProject [

	aProject company: self.

	^self projects add: aProject
]

{ #category : 'add/remove' }
UpCompany >> addProjects: aCollection [

	^aCollection do: [ :each | self addProject: each]
]

{ #category : 'accessing' }
UpCompany >> address [
	^address
]

{ #category : 'accessing' }
UpCompany >> address: anObject [
	address := anObject
]

{ #category : 'testing' }
UpCompany >> matches: aString [

	^(super matches: aString) or: [aString match: self address]
]

{ #category : 'accessing' }
UpCompany >> projects [
	^projects
]

{ #category : 'accessing' }
UpCompany >> projects: anObject [
	projects := anObject
]

{ #category : 'add/remove' }
UpCompany >> removeProject: aProject [

	^self projects remove: aProject
]

{ #category : 'add/remove' }
UpCompany >> removeProject: aProject ifAbsent: aBlock [

	^self projects remove: aProject ifAbsent: aBlock
]

{ #category : 'operations' }
UpCompany >> updateFrom: anotherCompany [

	super updateFrom: anotherCompany.
	self address: anotherCompany address
]
