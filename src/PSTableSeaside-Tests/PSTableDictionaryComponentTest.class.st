Class {
	#name : #PSTableDictionaryComponentTest,
	#superclass : #PSTableComponentTest,
	#category : #'PSTableSeaside-Tests'
}

{ #category : #running }
PSTableDictionaryComponentTest >> setUp [

	super setUp.
	psTable := PSTableDictionaryComponent new
]

{ #category : #tests }
PSTableDictionaryComponentTest >> testAddObjectToList [

	| list otherList |
	list := self orderedDictionaryTest.
	otherList := self orderedDictionaryTest.
	otherList := otherList 
		at: 6 put: #('Jenny Klein' 'jenny@mail.com' 'Female');
		yourself.
	psTable filteredListObject: otherList.
	self assert: list size equals: 5.
	psTable addObjectOfIndex: 6 to: list.
	self assert: list size equals: 6.
]

{ #category : #tests }
PSTableDictionaryComponentTest >> testKeyAtIndex [

	psTable listObject: self orderedDictionaryTest.
	self assert: (psTable keyAtIndex: 1) equals: 1.
]

{ #category : #tests }
PSTableDictionaryComponentTest >> testListObjectOfPage [

	psTable listObject: self orderedDictionaryTest.
	psTable limitPerPage: 2.
	self assert: psTable rowsOfPage size equals: 2.
	psTable nextPage.
	self assert: psTable rowsOfPage size equals: 2.
	psTable nextPage.
	self assert: psTable rowsOfPage size equals: 1.
]

{ #category : #tests }
PSTableDictionaryComponentTest >> testRowAtIndex [

	psTable listObject: self orderedDictionaryTest.
	self assert: (psTable rowAtIndex: 1) equals: #('Dan Marsh' 'dan@mail.com' 'Male').
]

{ #category : #tests }
PSTableDictionaryComponentTest >> testRowsOfPage [

	psTable listObject: self orderedDictionaryTest.
	psTable limitPerPage: 2.
	self assert: psTable rowsOfPage size equals: 2.
	psTable disablePagination: true.
	self assert: psTable rowsOfPage size equals: 5.
]
