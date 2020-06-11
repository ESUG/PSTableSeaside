"
I am a example of a table with a dictionary as rows
"
Class {
	#name : #ExampleTableDictionary,
	#superclass : #WAComponent,
	#category : #'PSTableSeaside-Demo'
}

{ #category : #rendering }
ExampleTableDictionary >> render: html with: anObject [
	"Render object on html"

	anObject do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
	
]

{ #category : #'rendering-searching' }
ExampleTableDictionary >> validateFilterOf: anObject [

	| objectsMatch objectContainer |
	objectContainer := anObject copy.
	objectsMatch := objectContainer 
		select: [ :elem | (elem asString) includesSubstring: self searchingText caseSensitive: false ].
	^ (objectsMatch isNotEmpty)
]
