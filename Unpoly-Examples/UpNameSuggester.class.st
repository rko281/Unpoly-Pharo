Class {
	#name : 'UpNameSuggester',
	#superclass : 'UpComponent',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'public' }
UpNameSuggester >> renderContentOn: html [

	| random names |

	random := Random new.
	names := self class environment keys asOrderedCollection.

	html div: 
		[10 timesRepeat: 
			[| name |
			name := names at: (random next * names size) truncated + 1.
			html linkButton 
				beInfo;
				lightText;
				marginStart: 1;
				marginBottom: 2;
				callback: [self answer: name];
				with: name]]
]
