Class {
	#name : 'UpNotificationDecoration',
	#superclass : 'UpDecoration',
	#instVars : [
		'div'
	],
	#category : 'Unpoly-Core',
	#package : 'Unpoly-Core'
}

{ #category : 'initializing' }
UpNotificationDecoration >> anchorRight [

	div upAnchored: 'right'
]

{ #category : 'accessing' }
UpNotificationDecoration >> div [
	^div
]

{ #category : 'accessing' }
UpNotificationDecoration >> div: anObject [
	div := anObject
]

{ #category : 'initializing' }
UpNotificationDecoration >> initialize [

	super initialize.

	div := WAGenericTag tag: 'div'.
	div upFlashes: true
]

{ #category : 'rendering' }
UpNotificationDecoration >> renderContentOn: html [

	html div 
		attributes: div attributes;
		with: self session popNotification.

	self renderNextOn: html
]
