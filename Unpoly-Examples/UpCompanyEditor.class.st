Class {
	#name : 'UpCompanyEditor',
	#superclass : 'UpExampleEditor',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'accessing' }
UpCompanyEditor >> allModels [

	^(self session properties at: #database) companies
]

{ #category : 'accessing' }
UpCompanyEditor >> companyAddressErrorMessage [

	self model address ifNotNil: [ :address | address isEmpty ifTrue: [^'can''t be blank']].
	^nil
]

{ #category : 'operations' }
UpCompanyEditor >> refreshErrorMessages [

	super refreshErrorMessages.

	self companyAddressErrorMessage ifNotNil: [ :message | errorMessages at: #address put: message]
]

{ #category : 'rendering' }
UpCompanyEditor >> renderFormFieldsOn: html [

	self
		renderFieldSet:  [html label: 'Name'. html formTextInput on: #name of: self model]
		for: #name
		on: html.

	self
		renderFieldSet:  [html label: 'Address'. html formTextArea rows: 6; on: #address of: self model]
		for: #address
		on: html
]
