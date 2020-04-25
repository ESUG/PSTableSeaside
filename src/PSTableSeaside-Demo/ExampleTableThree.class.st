"
Description
-----------

I am third example table to use in a dictionary
"
Class {
	#name : #ExampleTableThree,
	#superclass : #PSTableDictionaryComponent,
	#instVars : [
		'dictToRenderDownloadButton',
		'blockToExecute',
		'listToRenderButton'
	],
	#category : #'PSTableSeaside-Demo'
}

{ #category : #rendering }
ExampleTableThree >> render: html with: anObject [
	"Render object on html"

	anObject do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
]
