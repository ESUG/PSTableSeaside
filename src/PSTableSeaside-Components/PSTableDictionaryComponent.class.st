"
Description
-----------

I am the principal component to create a paginated table with dictionaries
"
Class {
	#name : #PSTableDictionaryComponent,
	#superclass : #PSTableComponent,
	#instVars : [
		'filterListObject'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #adding }
PSTableDictionaryComponent >> addObjectOfIndex: anIndex to: aList [
	"Add a object with an index into a dictionary list"

	aList at: (self keyAtIndex: anIndex) put: (self rowAtIndex: anIndex).
]

{ #category : #initialization }
PSTableDictionaryComponent >> initialize [
	
	super initialize.
	listObject := OrderedDictionary new.
	filterListObject := OrderedDictionary new
]

{ #category : #initialization }
PSTableDictionaryComponent >> initializeList [
	"Initialize a dictionary list"

	^ OrderedDictionary new
]

{ #category : #accessing }
PSTableDictionaryComponent >> keyAtIndex: anIndex [
	"Return key at given index on a list object"

	^ self filteredListObject keyAtIndex: anIndex
]

{ #category : #rendering }
PSTableDictionaryComponent >> render: html with: anObject [
	"Render object on html"

	self subclassResponsibility
]

{ #category : #rendering }
PSTableDictionaryComponent >> renderRowsOfPageOn: html [
	"Render rows of a page on html"

	(self rowsOfPage)
		keysAndValuesDo: [ :keyObject :object | 
			html
				tableRow: [ 
					html mdlTableCell
						nonNumerical;
						with: keyObject.
					self render: html with: object ] ]
]

{ #category : #accessing }
PSTableDictionaryComponent >> rowAtIndex: anIndex [
	"Return the row at given index"

	^ self filteredListObject at: (self keyAtIndex: anIndex)
]

{ #category : #'rendering-searching' }
PSTableDictionaryComponent >> validateFilterOf: anObject [
	
	self subclassResponsibility
]
