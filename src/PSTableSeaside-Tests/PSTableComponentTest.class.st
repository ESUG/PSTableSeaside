Class {
	#name : #PSTableComponentTest,
	#superclass : #TestCase,
	#instVars : [
		'psTable'
	],
	#category : #'PSTableSeaside-Tests'
}

{ #category : #rendering }
PSTableComponentTest >> orderedCollectionTest [

	^ OrderedCollection new
		add: #('Dan Marsh' 'dan@mail.com' 'Male');
		add: #('Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #('Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #('Bob Jones' 'bob@mail.com' 'Male');
		add: #('Bill Martinez' 'bill@mail.com' 'Male'); 
		yourself
]

{ #category : #rendering }
PSTableComponentTest >> orderedDictionaryTest [

	^ OrderedDictionary new
		at: 1 put: #('Dan Marsh' 'dan@mail.com' 'Male');
		at: 2 put: #('Ben Diaz' 'ben@mail.com' 'Male'); 
		at: 3 put: #('Ann Kisaragi' 'ann@mail.com' 'Female'); 
		at: 4 put: #('Bob Jones' 'bob@mail.com' 'Male');
		at: 5 put: #('Bill Martinez' 'bill@mail.com' 'Male');
		yourself
]

{ #category : #running }
PSTableComponentTest >> setUp [

	super setUp.
	psTable := PSTableComponent new
]

{ #category : #running }
PSTableComponentTest >> tearDown [

	psTable := nil.
	super tearDown
]

{ #category : #tests }
PSTableComponentTest >> testCurrentPage [

	self assert: psTable currentPage equals: 1.
	psTable currentPage: 5.
	self assert: psTable currentPage equals: 5.
]

{ #category : #tests }
PSTableComponentTest >> testDisablePagination [

	self assert: psTable disablePagination equals: false.
	psTable disablePagination: true.
	self assert: psTable disablePagination equals: true.
]

{ #category : #tests }
PSTableComponentTest >> testDisableSearching [

	self assert: psTable disableSearching equals: false.
	psTable disableSearching: true.
	self assert: psTable disableSearching equals: true.
]

{ #category : #tests }
PSTableComponentTest >> testFilteredListObject [

	psTable filteredListObject: OrderedCollection new.
	self assert: psTable filteredListObject size equals: 0.
	psTable filteredListObject: self orderedCollectionTest.
	self assert: psTable filteredListObject size equals: 5.
]

{ #category : #tests }
PSTableComponentTest >> testFirstPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	psTable nextPage.
	psTable nextPage.
	self assert: psTable currentPage equals: 3.
	psTable firstPage.
	self assert: psTable currentPage equals: 1.
]

{ #category : #tests }
PSTableComponentTest >> testHeaders [

	self assert: (psTable headers size) equals: 0.
	psTable headers: #(1 2 3 4).
	self assert: psTable headers size equals: 4.
]

{ #category : #tests }
PSTableComponentTest >> testIsLimitPerPageEqualToListObjectSize [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable isLimitPerPageEqualToListObjectSize equals: false.
	psTable limitPerPage: 5.
	self assert: psTable isLimitPerPageEqualToListObjectSize equals: true.
]

{ #category : #tests }
PSTableComponentTest >> testIsMorePagesThanTheLimitOfShowedPages [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable isMorePagesThanTheLimitOfShowedPages equals: true.
	psTable limitPageShowed: 2.
	self assert: psTable isMorePagesThanTheLimitOfShowedPages equals: false.
]

{ #category : #tests }
PSTableComponentTest >> testIsSelectedPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: (psTable isSelectedPage: 1) equals: true.
	psTable nextPage.
	psTable nextPage.
	self assert: (psTable isSelectedPage: 1) equals: false.
]

{ #category : #tests }
PSTableComponentTest >> testIsTheCurrentPageEqualOrGreaterThanLastPageGroup [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable isTheCurrentPageEqualOrGreaterThanLastPageGroup equals: false.
]

{ #category : #tests }
PSTableComponentTest >> testIsTheFirstPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable isTheFirstPage  equals: true.
	psTable nextPage.
	psTable nextPage.
	self assert: psTable isTheFirstPage equals: false.
]

{ #category : #tests }
PSTableComponentTest >> testIsTheLastPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable isTheLastPage equals: false.
	psTable nextPage.
	psTable nextPage.
	self assert: psTable isTheLastPage equals: true.
]

{ #category : #tests }
PSTableComponentTest >> testLastPage [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 2.
	self assert: psTable currentPage equals: 1.
	psTable lastPage.
	self assert: psTable currentPage equals: 3.
]

{ #category : #tests }
PSTableComponentTest >> testLimitPageShowed [

	self assert: psTable limitPageShowed equals: 5.
	psTable limitPageShowed: 6.
	self assert: psTable limitPageShowed equals: 6.
]

{ #category : #tests }
PSTableComponentTest >> testLimitPerPage [

	self assert: psTable limitPerPage equals: 0.
	psTable limitPerPage: 3.
	self assert: psTable limitPerPage equals: 3.
]

{ #category : #tests }
PSTableComponentTest >> testListObject [

	psTable listObject: OrderedCollection new.
	self assert: psTable listObject size equals: 0.
	psTable listObject: self orderedCollectionTest.
	self assert: psTable listObject size equals: 5.
]

{ #category : #tests }
PSTableComponentTest >> testNextPage [

	self assert: psTable currentPage equals: 1.
	psTable nextPage.
	self assert: psTable currentPage equals: 2.
]

{ #category : #tests }
PSTableComponentTest >> testNumberOfPages [

	psTable listObject: self orderedCollectionTest.
	psTable limitPerPage: 5.
	self assert: psTable numberOfPages equals: 1.
	psTable limitPerPage: 2.
	self assert: psTable numberOfPages equals: 3.
]

{ #category : #tests }
PSTableComponentTest >> testPageOf [

	self assert: psTable currentPage equals: 1.
	psTable pageOf: 5.
	self assert: psTable currentPage equals: 5.
]

{ #category : #tests }
PSTableComponentTest >> testPreviousPage [

	self assert: psTable currentPage equals: 1.
	psTable nextPage.
	psTable nextPage.
	psTable previousPage.
	self assert: psTable currentPage equals: 2.
]

{ #category : #tests }
PSTableComponentTest >> testSearchingText [

	self assert: psTable searchingText equals: ''.
	psTable searchingText: 'Some text'.
	self assert: psTable searchingText equals: 'Some text'.
]

{ #category : #tests }
PSTableComponentTest >> testTableId [

	psTable tableId: 'table-id'.
	self assert: psTable tableId equals: 'table-id'.
]
