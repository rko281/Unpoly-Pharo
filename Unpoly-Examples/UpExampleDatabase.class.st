Class {
	#name : 'UpExampleDatabase',
	#superclass : 'Object',
	#instVars : [
		'companies',
		'projects'
	],
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'instance creation' }
UpExampleDatabase class >> new [

	^super new initialize
]

{ #category : 'constants' }
UpExampleDatabase class >> testData [

	^#( 
		#('Bergstrom, Schroeder and Senger' 'Theresa Square 56<N>15598 East Broderick<N>Macedonia' #(#('Matsoft' 65000) #('Toughjoyfax' 14000) #('Zamit' 117000)))
		#('Bins-Heller' 'Breanna Corner 41<N>26123 Bridgetteshire<N>Anguilla' #(#('Domainer' 80000) #('Prodder' 19000) #('Stronghold' 680000)))
		#('Feil-Davis' 'Lawanna Center 5<N>89180 Corenetown<N>Saint Kitts and Nevis' #(#('Bytecard' 150000) #('Mat Lam Tam' 42000) #('Viva' 131000)))
		#('Heidenreich, Hahn and Stroman' 'Braun Walks 29<N>14980-2387 New Jana<N>Lithuania' #(#('Cardguard' 59000) #('Redhold' 120000) #('Y-find' 147000)))
		#('Weimann Inc' 'Gutkowski Pass 77<N>31656-1179 West Ellis<N>United States Minor Outlying Islands' #(#('It' 121000) #('Solarbreeze' 29000) #('Subin' 22000)))
	)
]

{ #category : 'add/remove' }
UpExampleDatabase >> addCompany: aCompany [

	aCompany id: (companies inject: 0 into: [ :max :each | max max: each id]) + 1.
	^companies add: aCompany
]

{ #category : 'add/remove' }
UpExampleDatabase >> addProject: aProject [

	aProject id: (projects inject: 0 into: [ :max :each | max max: each id]) + 1.
	aProject company addProject: aProject.
	^projects add: aProject
]

{ #category : 'accessing' }
UpExampleDatabase >> companies [

	^companies
]

{ #category : 'initializing' }
UpExampleDatabase >> initialize [

	| count |

	companies := SortedCollection new.
	count := 0.

	self class testData do: 
		[ :array || projCount |
		count := count + 1.
		projCount := 0.
		companies add: 
			(UpCompany new
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
				yourself)].

	projects := companies inject: SortedCollection new into: [ :all :each | all addAll: each projects; yourself]
]

{ #category : 'accessing' }
UpExampleDatabase >> projects [

	^projects
]

{ #category : 'add/remove' }
UpExampleDatabase >> removeCompany: aCompany [

	aCompany projects copy do: [ :each | self removeProject: each].
	^companies remove: aCompany
]

{ #category : 'add/remove' }
UpExampleDatabase >> removeProject: aProject [

	aProject company ifNotNil: [ :company | company removeProject: aProject].
	^projects remove: aProject
]
