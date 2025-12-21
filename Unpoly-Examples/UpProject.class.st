Class {
	#name : 'UpProject',
	#superclass : 'UpExampleModel',
	#instVars : [
		'budget',
		'company'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'accessing' }
UpProject class >> description [

	^'Project'
]

{ #category : 'constants' }
UpProject class >> editorClass [

	^UpProjectEditor
]

{ #category : 'instance creation' }
UpProject class >> new [

	^super new
		budget: 0s2;
		yourself
]

{ #category : 'constants' }
UpProject class >> presenterClass [

	^UpProjectPresenter
]

{ #category : 'instance creation' }
UpProject class >> template [

	^self new
		name: 'Big Plan';
		budget: 1234.56s2;
		company: UpCompany template;
		yourself
]

{ #category : 'accessing' }
UpProject >> budget [
	^budget
]

{ #category : 'accessing' }
UpProject >> budget: anObject [
	budget := anObject
]

{ #category : 'accessing' }
UpProject >> budgetString [

	^self budget isNil 
		ifTrue: ['']
		ifFalse: [self budget asFloat asString]
]

{ #category : 'accessing' }
UpProject >> budgetString: aString [

	| validString |

	validString := aString select: [ :each | each isDigit or: [each = self currency first]].

	validString isEmpty 
		ifTrue: [self budget: nil]
		ifFalse: [self budget: ((Number readFrom: validString readStream) ifNotNil: [ :number | number asScaledDecimal: 2])]


]

{ #category : 'accessing' }
UpProject >> budgetStringWithCurrency [

	^self currency, self budgetString
]

{ #category : 'accessing' }
UpProject >> company [
	^company
]

{ #category : 'accessing' }
UpProject >> company: anObject [
	company := anObject
]

{ #category : 'accessing' }
UpProject >> currency [

	^'€'
]

{ #category : 'operations' }
UpProject >> updateFrom: anotherProject [

	super updateFrom: anotherProject.

	self budget: anotherProject budget.

	self company ~= anotherProject company ifTrue: 
		[self company removeProject: self.
		anotherProject company addProject: self]
]
