"
Description
-----------

I am a second example table without blocks to execute
"
Class {
	#name : #ExampleTableTwo,
	#superclass : #PSTableCollectionComponent,
	#category : #'PSTableSeaside-Demo'
}

{ #category : #rendering }
ExampleTableTwo >> render: html with: anObject [
	"Render object on html"

	anObject do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
]
