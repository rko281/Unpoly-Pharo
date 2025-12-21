Extension { #name : 'WABasicFormTag' }

{ #category : '*Unpoly-Core' }
WABasicFormTag >> upInitialize [

	super upInitialize.

	self 
		upSubmit: true;
		upHistory: false
]
