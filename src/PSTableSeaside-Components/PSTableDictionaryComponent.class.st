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

	self subclassResponsibility
]

{ #category : #rendering }
PSTableDictionaryComponent >> renderTableBodyOn: html [
	"Return body on html"

	html tableBody
		id: tableId, '-body';
		with: [ 
			(self filteredListObject isEmpty and: [ self searchingText isNotEmpty ])
				ifTrue: [ 
				 	html tableRow: [
						html mdlTableCell 
							colSpan: self headers size; 
							nonNumerical;
							style: 'text-align: center;'; 
							with: 'No matching results found' ] ]
				ifFalse: [ 
		(self rowsOfPage)
			keysAndValuesDo: [ :keyObject :object  |
						html tableRow: [ 
						html mdlTableCell nonNumerical; with: keyObject.
						self render: html with: object ] ] ] ]
]

{ #category : #accessing }
PSTableDictionaryComponent >> rowAtIndex: anIndex [
	"Return the row at given index"

	^ self filteredListObject at: (self keyAtIndex: anIndex)
]
