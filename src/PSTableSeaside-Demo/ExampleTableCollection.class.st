"
Description
-----------

I am a second example table without blocks to execute
"
Class {
	#name : #ExampleTableCollection,
	#superclass : #PSTableCollectionComponent,
	#category : #'PSTableSeaside-Demo'
}

{ #category : #rendering }
ExampleTableCollection >> render: html with: anObject [
	"Render object on html"

	anObject do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
]

{ #category : #'rendering-searching' }
ExampleTableCollection >> validateFilterOf: anObject [

	| objectsMatch objectContainer |
	objectContainer := anObject copy.
	objectsMatch := objectContainer 
		select: [ :elem | (elem asString) includesSubstring: self searchingText caseSensitive: false ].
	^ (objectsMatch isNotEmpty)
]
