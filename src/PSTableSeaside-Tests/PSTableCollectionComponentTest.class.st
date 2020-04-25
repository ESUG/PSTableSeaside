Class {
	#name : #PSTableCollectionComponentTest,
	#superclass : #PSTableComponentTest,
	#category : #'PSTableSeaside-Tests'
}

{ #category : #running }
PSTableCollectionComponentTest >> setUp [

	super setUp.
	psTable := PSTableCollectionComponent new
]

{ #category : #tests }
PSTableCollectionComponentTest >> testAddObjectToList [

	| list |
	list := self orderedCollectionTest.
	psTable filteredListObject: self orderedCollectionTest.
	self assert: list size equals: 5.
	psTable addObjectOfIndex: 4 to: list.
	self assert: list size equals: 6.
]

{ #category : #tests }
PSTableCollectionComponentTest >> testListObjectOfPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable rowsOfPage size equals: 2.
	psTable nextPage.
	self assert: psTable rowsOfPage size equals: 2.
	psTable nextPage.
	self assert: psTable rowsOfPage size equals: 1.
]

{ #category : #tests }
PSTableCollectionComponentTest >> testRowAtIndex [

	psTable listObject: self orderedCollectionTest.
	self assert: (psTable rowAtIndex: 1) equals: #('Dan Marsh' 'dan@mail.com' 'Male').
]

{ #category : #tests }
PSTableCollectionComponentTest >> testRowsOfPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable rowsOfPage size equals: 2.
	psTable disablePagination: true.
	self assert: psTable rowsOfPage size equals: 5.
]
