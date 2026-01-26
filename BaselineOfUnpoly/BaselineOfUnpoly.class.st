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
			package: 'Unpoly-Core' with: [ spec requires: #('Bootstrap5-Core' 'Seaside3-default' 'SeasideExtras-Bootstrap' 'SeasideExtras-Javascript') ];
			package: 'Unpoly-Placeholders' with: [ spec requires: #('Unpoly-Core') ];
			package: 'Unpoly-Examples' with: [ spec requires: #('Unpoly-Placeholders'  ) ].

		spec
			group: 'Core' with: #('Unpoly-Core');
			group: 'Placeholders' with: #('Unpoly-Placeholders');
			group: 'Examples' with: #('Unpoly-Examples');
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
		project: 'Seaside3-default' copyFrom: 'Seaside3' with: [ spec loads: #( 'default' ) ]
]

{ #category : 'baselines' }
BaselineOfUnpoly >> seasideExtras: spec [

	spec
		baseline: 'SeasideExtras' with: [ spec repository: 'github://rko281/SeasideExtras-Pharo:main' ];
		project: 'SeasideExtras-Bootstrap' copyFrom: 'SeasideExtras' with: [ spec loads: #( 'Bootstrap' ) ];
		project: 'SeasideExtras-Javascript' copyFrom: 'SeasideExtras' with: [ spec loads: #( 'Javascript' ) ]
]
