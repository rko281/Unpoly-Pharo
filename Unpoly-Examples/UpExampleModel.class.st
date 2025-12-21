Class {
	#name : 'UpExampleModel',
	#superclass : 'Object',
	#instVars : [
		'id',
		'name'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'accessing' }
UpExampleModel class >> allCompanies [

	| count |

	count := 0.

	^self testData collect: 
		[ :array || projCount |
		count := count + 1.
		projCount := 0.
		self new
			id: count;
			name: array first;
			address: array second expandMacros;
			addProjects: 
				(array third collect: 
					[ :projArray |
					UpProject new
						id: (count * 1000) + (projCount := projCount + 1);
						name: projArray first;
						budget: projArray second;
						yourself]);
			yourself]
]

{ #category : 'accessing' }
UpExampleModel class >> description [

	^self subclassResponsibility
]

{ #category : 'constants' }
UpExampleModel class >> editorClass [

	^self subclassResponsibility
]

{ #category : 'constants' }
UpExampleModel class >> presenterClass [

	^self subclassResponsibility
]

{ #category : 'accessing' }
UpExampleModel class >> template [

	^self subclassResponsibility
]

{ #category : 'accessing' }
UpExampleModel class >> testData [

	^#( 
		#('Bergstrom, Schroeder and Senger' 'Theresa Square 56<N>15598 East Broderick<N>Macedonia' #(#('Matsoft' 65000) #('Toughjoyfax' 14000) #('Zamit' 117000)))
		#('Bins-Heller' 'Breanna Corner 41<N>26123 Bridgetteshire<N>Anguilla' #(#('Domainer' 80000) #('Prodder' 19000) #('Stronghold' 680000)))
		#('Feil-Davis' 'Lawanna Center 5<N>89180 Corenetown<N>Saint Kitts and Nevis' #(#('Bytecard' 150000) #('Mat Lam Tam' 42000) #('Viva' 131000)))
		#('Heidenreich, Hahn and Stroman' 'Braun Walks 29<N>14980-2387 New Jana<N>Lithuania' #(#('Cardguard' 59000) #('Redhold' 120000) #('Y-find' 147000)))
		#('Weimann Inc' 'Gutkowski Pass 77<N>31656-1179 West Ellis<N>United States Minor Outlying Islands' #(#('It' 121000) #('Solarbreeze' 29000) #('Subin' 22000)))
	)
]

{ #category : 'comparing' }
UpExampleModel >> <= anotherExampleModel [

	^anotherExampleModel name <= anotherExampleModel name
]

{ #category : 'comparing' }
UpExampleModel >> = anotherExampleModel [

	^anotherExampleModel notNil and: [self id = anotherExampleModel id]
]

{ #category : 'constants' }
UpExampleModel >> editorClass [

	^self class editorClass
]

{ #category : 'comparing' }
UpExampleModel >> hash [

	^self id hash
]

{ #category : 'accessing' }
UpExampleModel >> id [
	^id
]

{ #category : 'accessing' }
UpExampleModel >> id: anObject [
	id := anObject
]

{ #category : 'testing' }
UpExampleModel >> matches: aString [

	^aString match: self name
]

{ #category : 'accessing' }
UpExampleModel >> name [
	^name
]

{ #category : 'accessing' }
UpExampleModel >> name: anObject [
	name := anObject
]

{ #category : 'constants' }
UpExampleModel >> presenterClass [

	^self class presenterClass
]

{ #category : 'operations' }
UpExampleModel >> updateFrom: anotherCompany [

	self name: anotherCompany name
]
