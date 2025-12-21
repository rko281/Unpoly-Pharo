Class {
	#name : 'BaselineOfUnpoly',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfUnpoly',
	#package : 'BaselineOfUnpoly'
}

{ #category : 'baselines' }
BaselineOfUnpoly >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		self 
			seaside: spec;
			bootstrap5: spec;
			seasideExtras: spec.

		spec
			package: 'Unpoly-Core2' with: [ spec requires: #('Bootstrap5-Core' 'SeasideExtras-Bootstrap' 'SeasideExtras-Javascript') ];
			package: 'Unpoly-Placeholders2' with: [ spec requires: #('Unpoly-Core2') ];
			package: 'Unpoly-Examples2' with: [ spec requires: #('Unpoly-Placeholders2' 'Seaside3-Welcome' ) ].

		spec
			group: 'Core' with: #('Unpoly-Core2');
			group: 'Placeholders' with: #('Unpoly-Placeholders2');
			group: 'Examples' with: #('Unpoly-Examples2');
			group: 'default' with: #('Examples') ]
]

{ #category : 'baselines' }
BaselineOfUnpoly >> bootstrap5: spec [

	spec
		baseline: 'Bootstrap5' with: [ spec repository: 'github://astares/Seaside-Bootstrap5:master/src' ];
		project: 'Bootstrap5-Core' copyFrom: 'Bootstrap5' with: [ spec loads: #( 'Core' ) ] 
]

{ #category : 'baselines' }
BaselineOfUnpoly >> seaside: spec [

	spec
		baseline: 'Seaside3' with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ];
		project: 'Seaside3-Welcome' copyFrom: 'Seaside3' with: [ spec loads: #( 'Welcome' ) ]
]

{ #category : 'baselines' }
BaselineOfUnpoly >> seasideExtras: spec [

	spec
		baseline: 'SeasideExtras' with: [ spec repository: 'github://rko281/SeasideExtras-Pharo:main' ];
		project: 'SeasideExtras-Bootstrap' copyFrom: 'SeasideExtras' with: [ spec loads: #( 'Bootstrap' ) ];
		project: 'SeasideExtras-Javascript' copyFrom: 'SeasideExtras' with: [ spec loads: #( 'Javascript' ) ]
]
