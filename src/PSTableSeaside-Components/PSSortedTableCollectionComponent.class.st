"
Description
-----------

I am the principal component to create a paginated table with collections
"
Class {
	#name : #PSSortedTableCollectionComponent,
	#superclass : #PSSortedTableComponent,
	#category : #'PSTableSeaside-Components'
}

{ #category : #adding }
PSSortedTableCollectionComponent >> addObjectOfIndex: anIndex to: aList [
	"Add object of a given index to a given list"

	aList add: (self rowAtIndex: anIndex)
]

{ #category : #initialization }
PSSortedTableCollectionComponent >> initialize [

	super initialize.
	rows := OrderedCollection new.
	unsortedRows := OrderedCollection new.
	filteredRows := OrderedCollection new.
]

{ #category : #initialization }
PSSortedTableCollectionComponent >> initializeList [
	"Initialize list of object of current page"

	^ OrderedCollection new
]

{ #category : #'rendering-table' }
PSSortedTableCollectionComponent >> render: html with: anObject [
	"Render object on html"

	self subclassResponsibility
]

{ #category : #rendering }
PSSortedTableCollectionComponent >> renderRowsOfPageOn: html [
	"Render rows of a page on html"
	
	(self rowsOfPage)
			do: [ :object |
						html tableRow: [ self render: html with: object ] ]
]

{ #category : #accessing }
PSSortedTableCollectionComponent >> rowAtIndex: anIndex [
	"Return the row at given index"

	^ self filteredRows at: anIndex
]

{ #category : #'rendering-searching' }
PSSortedTableCollectionComponent >> validateFilterOf: anObject [
	
	self subclassResponsibility
]
