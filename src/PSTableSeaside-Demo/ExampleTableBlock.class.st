"
Description
-----------

I am an example component that use a collection
"
Class {
	#name : #ExampleTableBlock,
	#superclass : #PSTableCollectionComponent,
	#instVars : [
		'dictToRenderDownloadButton',
		'blockToExecute',
		'listToRenderButton'
	],
	#category : #'PSTableSeaside-Demo'
}

{ #category : #accessing }
ExampleTableBlock >> blockToExecute: anObject [

	blockToExecute := anObject
	
]

{ #category : #accessing }
ExampleTableBlock >> dictToRenderDownloadButton: aDictionary [

	dictToRenderDownloadButton := aDictionary
]

{ #category : #initialization }
ExampleTableBlock >> initialize [

	super initialize
]

{ #category : #accessing }
ExampleTableBlock >> listToRenderButton: anObject [

	listToRenderButton := anObject
	
]

{ #category : #rendering }
ExampleTableBlock >> render: html with: anObject [

	| listContent |
	listContent := blockToExecute valueWithPossibleArgs: {anObject. html}.
	listContent do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
	html mdlTableCell nonNumerical; with: [ self renderButton: html with: anObject ]
]

{ #category : #rendering }
ExampleTableBlock >> renderButton: html with: anObject [

	listToRenderButton
		do: [ :dataButton | 
			html mdlAnchorButton colored; rippleEffect;
				id: (dataButton third value: anObject);
				onClick: dataButton fifth;
				disabled: (dataButton sixth ifTrue: 'disabled');
				callback: [ dataButton second value: anObject ];
				icon: dataButton first.
			html div	class: 'mdl-tooltip'; 
				attributeAt: 'data-mdl-for' put: (dataButton third value: anObject) ;
				with: dataButton fourth].
	self renderDownloadButton: html with: anObject
]

{ #category : #rendering }
ExampleTableBlock >> renderDownloadButton: html with: anObject [

	dictToRenderDownloadButton ifNotEmpty: [ 
		| downloadButton |
		downloadButton := html mdlAnchorButton colored;	rippleEffect;
			id: ((dictToRenderDownloadButton at: 'id') value: anObject).
		downloadButton isDisabled ifFalse: [ 
			downloadButton url: ((dictToRenderDownloadButton at: 'url') value: anObject);
			attributeAt: 'download' put: ((dictToRenderDownloadButton at: 'download') value: anObject)].
		downloadButton icon: (dictToRenderDownloadButton at: 'icon').
		html div	class: 'mdl-tooltip'; 
				attributeAt: 'data-mdl-for' put: ((dictToRenderDownloadButton at: 'id') value: anObject) ;
				with: 'Download invoice'].
]

{ #category : #'rendering-searching' }
ExampleTableBlock >> validateFilterOf: anObject [

	| objectsMatch objectContainer |
	objectContainer := anObject copy.
	objectsMatch := objectContainer 
		select: [ :elem | (elem asString) includesSubstring: self searchingText caseSensitive: false ].
	^ (objectsMatch isNotEmpty)
]
