"
Description
-----------

I am the principal component to create a paginated table

My function is:

	- Give the pagination bar functionality to your table
	- Calculate the quantity of pages that you need to paginate your objects
	- Give the required methods to render your table correctly
"
Class {
	#name : #PSTableComponent,
	#superclass : #WAComponent,
	#instVars : [
		'limitPerPage',
		'currentPage',
		'listObject',
		'disablePagination',
		'headers',
		'tableId',
		'renderBlock',
		'limitPageShowed',
		'searchingText',
		'filteredListObject',
		'disableSearching'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #adding }
PSTableComponent >> addObjectOfIndex: anIndex to: aList [
	"Add object of a given index in a list to render in your page"

	self subclassResponsibility
]

{ #category : #accessing }
PSTableComponent >> currentPage [
	"Current page of pagination"

	^ currentPage
]

{ #category : #accessing }
PSTableComponent >> currentPage: aNumber [
	"Current page of pagination"

	currentPage := aNumber
]

{ #category : #accessing }
PSTableComponent >> disablePagination [
	"Option to disable pagination. The defect value is false"

	^ disablePagination
]

{ #category : #accessing }
PSTableComponent >> disablePagination: aBoolean [
	"Option to disable pagination. The defect value is false"

	disablePagination := aBoolean
]

{ #category : #accessing }
PSTableComponent >> disableSearching [

	^ disableSearching
]

{ #category : #accessing }
PSTableComponent >> disableSearching: aBoolean [

	disableSearching := aBoolean
]

{ #category : #'ajax-events' }
PSTableComponent >> executeCallback: aCallback on: html [

	^ html jQuery ajax
		callback: aCallback;
		context: 'this' js;
		onSuccess: (self updateContentTableOn: html)
]

{ #category : #'rendering-searching' }
PSTableComponent >> filterRowsOn: html [
	^ html jQuery ajax
		context: 'this' js;
		callback: [ :val | 
			self filteredListObject: self listObject.
			searchingText := val.
			currentPage := 1.
			searchingText isEmpty
				ifFalse: [ | listFiltered |
					listFiltered := self filteredListObject
						select:
							[ :object | self validateFilterOf: object ].
					self filteredListObject: listFiltered ] ]
			value: (html jQuery id: self tableId asString, '-searchInputTable') value;
		onSuccess: (self updateContentTableOn: html)
]

{ #category : #accessing }
PSTableComponent >> filteredListObject [

	^ filteredListObject
]

{ #category : #accessing }
PSTableComponent >> filteredListObject: aList [

	filteredListObject := aList
]

{ #category : #actions }
PSTableComponent >> firstPage [
	^ currentPage := 1
]

{ #category : #accessing }
PSTableComponent >> firstPageShowed [
	"Return the first page showed in pages option bar"

	self isTheCurrentPageEqualOrGreaterThanLastPageGroup
		ifFalse: [ ^ self numberOfPages - self limitPageShowed max: 1 ]
		ifTrue: [ ^ self currentPage - self limitPageShowed max: self currentPage ]
]

{ #category : #accessing }
PSTableComponent >> headers [

	^ headers
]

{ #category : #accessing }
PSTableComponent >> headers: aCollection [
	"Header of table"

	headers := aCollection
]

{ #category : #initialization }
PSTableComponent >> initialize [

	limitPerPage := 0.
	headers := OrderedCollection new.
	currentPage := 1.
	disablePagination := false.
	disableSearching := false.
	limitPageShowed := 5.
	searchingText := ''
]

{ #category : #initialization }
PSTableComponent >> initializeList [

	self subclassResponsibility
]

{ #category : #validation }
PSTableComponent >> isLimitPerPageEqualToListObjectSize [
	"Return true if the limit per page is the same as the list object size"

	^ self limitPerPage = self filteredListObject size
]

{ #category : #validation }
PSTableComponent >> isMorePagesThanTheLimitOfShowedPages [
	"Return true if the number of pages is less than the limit page showed"

	^ self numberOfPages < self limitPageShowed
]

{ #category : #validation }
PSTableComponent >> isSelectedPage: aPage [
	"Return true if the current page has the same value as a given page"

	^ self currentPage = aPage
]

{ #category : #validation }
PSTableComponent >> isTheCurrentPageEqualOrGreaterThanLastPageGroup [
	^ self numberOfPages - self limitPageShowed >= self currentPage
]

{ #category : #validation }
PSTableComponent >> isTheFirstPage [
	"Return true if your current page is the first page of your table"

	^ self currentPage = 1
]

{ #category : #validation }
PSTableComponent >> isTheLastPage [
	"Return true if the current page is the last page of your table"

	^ self currentPage = self numberOfPages
]

{ #category : #actions }
PSTableComponent >> lastPage [
	^ currentPage := self numberOfPages
]

{ #category : #accessing }
PSTableComponent >> limitOfShowedPages [
	"Return a limit of showed pages in pages options bar"
	
	(self isTheCurrentPageEqualOrGreaterThanLastPageGroup)
		ifFalse: [ ^ self numberOfPages ]
		ifTrue: [ ^ self currentPage + self limitPageShowed ]
]

{ #category : #accessing }
PSTableComponent >> limitPageShowed [

	^ limitPageShowed
]

{ #category : #accessing }
PSTableComponent >> limitPageShowed: aNumber [

	limitPageShowed := aNumber
]

{ #category : #accessing }
PSTableComponent >> limitPerPage [
	"Limit of rows per page"

	^ limitPerPage
]

{ #category : #accessing }
PSTableComponent >> limitPerPage: aNumber [
	"Limit of rows per page"

	limitPerPage := aNumber
]

{ #category : #accessing }
PSTableComponent >> listObject [
	"List of objects to render"

	^ listObject
]

{ #category : #accessing }
PSTableComponent >> listObject: aCollection [
	"List of objects to render"

	listObject := aCollection.
	self filteredListObject: listObject.
]

{ #category : #actions }
PSTableComponent >> listObjectOfPage [
	"List of objects on a given page"

	| listOfPage index |
	listOfPage := self initializeList.
	index := (self currentPage - 1) * self limitPerPage.
	index := index + 1.
	[ listOfPage size < self limitPerPage and: [ index <= self filteredListObject size ] ]
		whileTrue: [ 
			self addObjectOfIndex: index to: listOfPage.
			index := index + 1 ].
	^ listOfPage
]

{ #category : #actions }
PSTableComponent >> nextPage [

	^ currentPage := currentPage + 1
]

{ #category : #accessing }
PSTableComponent >> numberOfPages [
	"Calculate the number of page based in size of list objects and limit per page"

	^ (self filteredListObject size / self limitPerPage) roundUpTo: 1
]

{ #category : #actions }
PSTableComponent >> pageOf: aPage [
	^ currentPage := aPage
]

{ #category : #actions }
PSTableComponent >> previousPage [
	"Go to previous page of current page"
	
	^ currentPage := currentPage - 1
]

{ #category : #actions }
PSTableComponent >> rangeOfPages [
	"Generate a range to render page buttons"

	self isMorePagesThanTheLimitOfShowedPages
		ifTrue: [ ^ 1 to: self numberOfPages ]
		ifFalse: [ ^ self firstPageShowed to: self limitOfShowedPages ]
]

{ #category : #'rendering-table' }
PSTableComponent >> render: html with: anObject [

	self subclassResponsibility
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderButtonFirstPageOn: html [
	"Render the button to go to the first page of table"

	(self isTheFirstPage  or: [ self filteredListObject isEmpty ])
		ifTrue: [ self
				renderDisabledButtonWithId: 'firstPageButtonPagination'
				andText: 'first'
				on: html ]
		ifFalse: [ html mdlButton
				id: 'firstPageButtonPagination';
				primaryColor;
				rippleEffect;
				onClick: (self executeCallback: [ self firstPage ] on: html);
				with: 'first' ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderButtonLastPageOn: html [
	"Render the button to go to the last page of table"

	(self isTheLastPage or: [ self filteredListObject isEmpty ])
		ifTrue: [ self
				renderDisabledButtonWithId: 'lastButtonPagination'
				andText: 'last'
				on: html ]
		ifFalse: [ html mdlButton
				id: 'lastButtonPagination';
				primaryColor;
				rippleEffect;
				onClick: (self executeCallback: [ self lastPage ] on: html);
				with: 'last' ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderButtonNextPageOn: html [
	"Render the button to go to next page of table"

	(self isTheLastPage or: [ self filteredListObject isEmpty ])
		ifTrue: [ self
				renderDisabledButtonWithId: 'nextButtonPagination'
				andText: 'next'
				on: html ]
		ifFalse: [ html mdlButton
				id: 'nextButtonPagination';
				raised;
				primaryColor;
				rippleEffect;
				onClick: (self executeCallback: [ self nextPage ] on: html);
				with: 'next' ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderButtonOfPage: aPage on: html [
	"Render the button to go to given page of table"

	(self isSelectedPage: aPage)
		ifTrue: [ self
				renderDisabledButtonWithId: 'buttonPagination' , aPage printString
				andText: aPage printString
				on: html ]
		ifFalse: [ html mdlButton
				raised;
				id: 'buttonPagination' , aPage printString;
				onClick: (self executeCallback: [ self pageOf: aPage ] on: html);
				with: aPage printString ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderButtonPreviousPageOn: html [
	"Render the button to go to previous page of table"

	(self isTheFirstPage  or: [ self filteredListObject isEmpty ])
		ifTrue: [ self
				renderDisabledButtonWithId: 'previousButtonPagination'
				andText: 'prev'
				on: html ]
		ifFalse: [ html mdlButton
				id: 'previousButtonPagination';
				raised;
				primaryColor;
				rippleEffect;
				onClick: (self executeCallback: [ self previousPage ] on: html);
				with: 'prev' ]
]

{ #category : #rendering }
PSTableComponent >> renderContentOn: html [
	"Render the table with the pagination option bar on html"

	self renderSearchingBarOn: html.
	self renderTableSectionOn: html
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderDisabledButtonWithId: aButtonId andText: aString on: html [
	"Render a disabled button with a given id and text on html"
	
	html mdlButton
		id: aButtonId;
		disabled;
		raised;
		with: aString
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderNextButtonsOn: html [
	"Render next button options of table pagination bar"

	self renderButtonNextPageOn: html.
	self renderButtonLastPageOn: html
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderPageButtonsOn: html [
	"Render page button options of table pagination bar"

	html div
		id: 'page-buttons';
		with: [ self renderPageSelectionButtonsOn: html ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderPageSelectionButtonsOn: html [
	"Render page options in pagination bar"

	self rangeOfPages do: [ :page | self renderButtonOfPage: page on: html. ]
]

{ #category : #'rendering-table' }
PSTableComponent >> renderPaginatedTableOn: html [
	"Render paginated table on html"

	html mdlTable
		id: 'pstable';
		class: 'mdl-shadow--2p';
		style: 'width:100%;';
		with: [ 
			self renderTableHeadersOn: html.
			self renderTableBodyOn: html ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderPaginationBarOn: html [
	"Render pagination bar on html"

	(self disablePagination
		or: [ self isLimitPerPageEqualToListObjectSize ])
		ifFalse: [ html div
				id: 'page-bar-options';
				style: 'display: flex; justify-content: space-evenly; padding: 10px 0px;';
				with: [ 
					self renderPreviousButtonsOn: html.
					self renderPageButtonsOn: html.
					self renderNextButtonsOn: html ] ]
		ifTrue: [ ^ nil ]
]

{ #category : #'rendering-pagination' }
PSTableComponent >> renderPreviousButtonsOn: html [
	"Render previous button option of table pagination bar"

	self renderButtonFirstPageOn: html.
	self renderButtonPreviousPageOn: html
]

{ #category : #'rendering-searching' }
PSTableComponent >> renderSearchingBarOn: html [

	html div
		id: 'searching-bar';
		style: '
		    display: flex;
    justify-content: flex-end;
    border: 1px solid rgba(0,0,0,.12);
    border-collapse: collapse;
    padding: 0px 10px;';
		with: [
			html mdlTextFieldContainer 
			floatingLabel;
				with: [ 
				html mdlTextFieldLabel
					for: self tableId asString, '-searchInputTable';
					with: 'Search'.
				html mdlTextFieldInput
					value: self searchingText;
					onInput: (self filterRowsOn: html);
					noAutocomplete;
					id: self tableId asString, '-searchInputTable' ] ]
]

{ #category : #'rendering-table' }
PSTableComponent >> renderTableBodyOn: html [
	"Render table Body on html"

	self subclassResponsibility
]

{ #category : #'rendering-table' }
PSTableComponent >> renderTableHeadersOn: html [
	"Render the given headers of a table"

	html tableHead
		id: 'pstable-head';
		with: [
			html tableRow: [
				self headers do: [ :each |
					html mdlTableHeading nonNumerical; with: each ] ] ]
]

{ #category : #'rendering-table' }
PSTableComponent >> renderTableSectionOn: html [
	html div
		id: tableId;
		with: [ 
			self renderPaginatedTableOn: html.
			self renderPaginationBarOn: html ]
]

{ #category : #accessing }
PSTableComponent >> rowAtIndex: anIndex [
	"Return the row of a index"

	self subclassResponsibility
]

{ #category : #actions }
PSTableComponent >> rowsOfPage [
	"If the pagination is able show a list by page. If it is not, show the complete list object"

	(disablePagination)
		ifTrue: [ ^ self filteredListObject ]
		ifFalse: [ ^ self listObjectOfPage ]
]

{ #category : #accessing }
PSTableComponent >> searchingText [

	^ searchingText
]

{ #category : #accessing }
PSTableComponent >> searchingText: aString [

	searchingText := aString
]

{ #category : #accessing }
PSTableComponent >> tableId [

	^ tableId
]

{ #category : #accessing }
PSTableComponent >> tableId: anId [
	"An ID to update table when change the page. It is important to assign an id to your table if you want to change the page in your paginated table"

	tableId := anId
]

{ #category : #'ajax-events' }
PSTableComponent >> updateContentTableOn: html [
	"Update the content of table with the given id"

	^ html jQuery
		script: [ :s | 
			(s << (html jQuery id: self tableId) load)
				html: [ :ajaxHtml | self renderTableSectionOn: ajaxHtml ];
				onComplete: 'componentHandler.upgradeDom();' ]
]

{ #category : #'rendering-searching' }
PSTableComponent >> validateFilterOf: object [
	| objectElements |
	objectElements := (object copy) select: [ :elem | elem includesSubstring: self searchingText caseSensitive: false ].
	^ (objectElements isNotEmpty)
]
