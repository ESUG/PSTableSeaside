"
Description
-----------

I am the principal component to create a paginated table with collections
"
Class {
	#name : #PSTableCollectionComponent,
	#superclass : #PSTableComponent,
	#instVars : [
		'filterListObject'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #adding }
PSTableCollectionComponent >> addObjectOfIndex: anIndex to: aList [
	"Add object of a given index to a given list"

	aList add: (self rowAtIndex: anIndex)
]

{ #category : #initialization }
PSTableCollectionComponent >> initialize [

	super initialize.
	listObject := OrderedCollection new.
	filterListObject := OrderedCollection new
]

{ #category : #initialization }
PSTableCollectionComponent >> initializeList [
	"Initialize list of object of current page"

	^ OrderedCollection new
]

{ #category : #rendering }
PSTableCollectionComponent >> render: html with: anObject [
	"Render object on html"

	self subclassResponsibility
]

{ #category : #'rendering-table' }
PSTableCollectionComponent >> renderRowsOfPageOn: html [
	"Render rows of a page on html"
	
	(self rowsOfPage)
			do: [ :object |
						html tableRow: [ self render: html with: object ] ]
]

{ #category : #accessing }
PSTableCollectionComponent >> rowAtIndex: anIndex [
	"Return the row at given index"

	^ self filteredListObject at: anIndex
]

{ #category : #'rendering-searching' }
PSTableCollectionComponent >> validateFilterOf: anObject [
	
	self subclassResponsibility.
]
