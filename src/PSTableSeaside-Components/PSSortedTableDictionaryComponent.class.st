"
Description
-----------

I am the principal component to create a paginated table with dictionaries
"
Class {
	#name : #PSSortedTableDictionaryComponent,
	#superclass : #PSSortedTableComponent,
	#category : #'PSTableSeaside-Components'
}

{ #category : #adding }
PSSortedTableDictionaryComponent >> addObjectOfIndex: anIndex to: aList [	
	"Add a object with an index into a dictionary list"

	aList at: (self keyAtIndex: anIndex) put: (self rowAtIndex: anIndex).
]

{ #category : #initialization }
PSSortedTableDictionaryComponent >> initialize [

	super initialize.
	rows := OrderedDictionary new.
	unsortedRows := OrderedDictionary new.
	filteredRows := OrderedDictionary new
]

{ #category : #initialization }
PSSortedTableDictionaryComponent >> initializeList [

	^ OrderedDictionary new
]

{ #category : #accessing }
PSSortedTableDictionaryComponent >> keyAtIndex: anIndex [
	"Return key at given index on a list object"

	^ self filteredRows keyAtIndex: anIndex
]

{ #category : #'rendering-table' }
PSSortedTableDictionaryComponent >> render: html with: anObject [
	"Render object on html"

	self subclassResponsibility
]

{ #category : #rendering }
PSSortedTableDictionaryComponent >> renderRowsOfPageOn: html [

	(self rowsByPage)
		keysAndValuesDo: [ :keyObject :object | 
			html
				tableRow: [ 
					html mdlTableCell
						nonNumerical;
						with: keyObject.
					self render: html with: object ] ]
]

{ #category : #accessing }
PSSortedTableDictionaryComponent >> rowAtIndex: anIndex [
	"Return the row at given index"

	^ self filteredRows at: (self keyAtIndex: anIndex)
]

{ #category : #sorting }
PSSortedTableDictionaryComponent >> sortCollectionwith: aSelector OnRowIndex: aRowIndex [
	aRowIndex = 1
		ifFalse: [ self filteredRows: 
				(self filteredRows associations asSortedCollection: [ :cell :anotherCell |
					((cell value) at: aRowIndex - 1) perform: aSelector
						with: ((anotherCell value) at: aRowIndex - 1) ]) asOrderedDictionary ]
]

{ #category : #'rendering-searching' }
PSSortedTableDictionaryComponent >> validateFilterOf: anObject [
	
	self subclassResponsibility
]
