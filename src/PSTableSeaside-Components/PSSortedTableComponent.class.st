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
	#name : #PSSortedTableComponent,
	#superclass : #WAComponent,
	#instVars : [
		'showPaginationBar',
		'showSelectionLimit',
		'showSearchingField',
		'tableId',
		'header',
		'rows',
		'ajaxOnCompleteHook',
		'unsortedRows',
		'position',
		'elementsToShow',
		'rowsPerPagePossibilities',
		'searchingText',
		'filteredRows',
		'limitPageShowed'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #adding }
PSSortedTableComponent >> addObjectOfIndex: anIndex to: aList [
	"Add object of a given index in a list to render in your page"

	self subclassResponsibility
]

{ #category : #'ajax-events' }
PSSortedTableComponent >> ajaxOnCompleteHook [

	^ ajaxOnCompleteHook ifNil: [ 'componentHandler.upgradeDom();' ]
]

{ #category : #'ajax-events' }
PSSortedTableComponent >> ajaxOnCompleteHook: anObject [

	ajaxOnCompleteHook := anObject
]

{ #category : #'ajax-events' }
PSSortedTableComponent >> ajaxUpdateScriptFrom: html [

	^ html jQuery
		script: [ :s | 
			(s << (html jQuery id: self psTableId) load)
				html: [ :ajaxHtml | 
					self renderTableOn: ajaxHtml ];
					onComplete: 'componentHandler.upgradeDom();'.
			(s << (html jQuery id: self tableId asString, '-pagination-bar-bottom') load)
				html: [ :ajaxHtml | 
					self renderPaginationBarOn: ajaxHtml ];
					onComplete: 'componentHandler.upgradeDom();'.
			(s << (html jQuery id: self tableId asString, '-pagination-bar-top') load)
				html: [ :ajaxHtml | 
					self renderPaginationBarOn: ajaxHtml ];
					onComplete: 'componentHandler.upgradeDom();'. ]


]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> changeLimitRowsOn: html [

	^ html jQuery ajax serializeThis
		onComplete: (self ajaxUpdateScriptFrom: html)
]

{ #category : #accessing }
PSSortedTableComponent >> elementsToShow [
	^ elementsToShow
]

{ #category : #accessing }
PSSortedTableComponent >> elementsToShow: anObject [
	elementsToShow := anObject
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> executeCallback: aCallback on: html [

^ html jQuery ajax
		callback: aCallback;
		context: 'this' js;
		onSuccess: (self ajaxUpdateScriptFrom: html)
]

{ #category : #'rendering-searching' }
PSSortedTableComponent >> filterByText: aString [
	| listFiltered |
	searchingText := aString.
	self filteredRows: self rows copy.
	position := 1.
	searchingText isEmpty
		ifTrue: [ unsortedRows := self rows copy. ^ self ].
	listFiltered := self filteredRows
		select: [ :object | self validateFilterOf: object ].
	unsortedRows := listFiltered copy.
	self filteredRows: listFiltered copy.
	
]

{ #category : #'rendering-searching' }
PSSortedTableComponent >> filterRowsOn: html [
	^ html jQuery ajax
		context: 'this' js;
		callback:
				[ :val | self filterByText: val ]
			value: (html jQuery id: self tableId asString , '-searchInputTable') value;
		onSuccess: (self ajaxUpdateScriptFrom: html)
]

{ #category : #accessing }
PSSortedTableComponent >> filteredRows [

	^ filteredRows
]

{ #category : #accessing }
PSSortedTableComponent >> filteredRows: aCollection [

	filteredRows := aCollection
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> firstPage [

	position := 1
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> firstPageShowed [

	((self numberOfPages - self limitPageShowed) >= self position)
		ifFalse: [ ^ self numberOfPages - self limitPageShowed max: 1 ]
		ifTrue: [ ^ self position - self limitPageShowed max: self position ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> haveAnyRowFiltered [
	"Return true if there are any row in a filtered result"

	^ self filteredRows isEmpty
		and: [ self searchingText isNotEmpty ]
]

{ #category : #accessing }
PSSortedTableComponent >> header [

	^ header
]

{ #category : #accessing }
PSSortedTableComponent >> header: aCollection [

	header := aCollection collect: [ :each |
		(each isKindOf: PSTableSortableHeaderOptions)
			ifFalse: [ each asPSTableSortableHeader ]
			ifTrue: [ each ] ].
]

{ #category : #initialization }
PSSortedTableComponent >> initialize [

	super initialize.
	header := OrderedCollection new.
	self rowsPerPagePossibilities: #(10 25 50 100).
	showSelectionLimit := true.
	showSearchingField := true.
	showPaginationBar := true.
	position := 1.
	searchingText := ''.
	tableId := ''.
	limitPageShowed := 3
]

{ #category : #initialization }
PSSortedTableComponent >> initializeList [

	self subclassResponsibility
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> isAHeaderOption: head [
	^ head isKindOf: PSTableSortableHeaderOptions
]

{ #category : #validation }
PSSortedTableComponent >> isFirstPage [

	^ self position = 1
]

{ #category : #validation }
PSSortedTableComponent >> isLastPage [

	^ self position = self numberOfPages
]

{ #category : #validation }
PSSortedTableComponent >> isSelectedPage: aPage [

	^ self position = aPage
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> lastPage [

	position := self numberOfPages
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> limitOfShowedPages [

	(self numberOfPages - self limitPageShowed >= self position)
		ifFalse: [ ^ self numberOfPages ]
		ifTrue: [ ^ self position + self limitPageShowed ]
]

{ #category : #accessing }
PSSortedTableComponent >> limitPageShowed [

	^ limitPageShowed
]

{ #category : #accessing }
PSSortedTableComponent >> limitPageShowed: aNumber [

	limitPageShowed := aNumber
]

{ #category : #actions }
PSSortedTableComponent >> listObjectOfPage [
	"List of objects on a given page"

	| listOfPage index |
	listOfPage := self initializeList.
	index := (position - 1) * elementsToShow.
	index := index + 1.
	[ listOfPage size < elementsToShow and: [ index <= self filteredListObject size ] ]
		whileTrue: [ 
			self addObjectOfIndex: index to: listOfPage.
			index := index + 1 ].
	^ listOfPage
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> nextPage [

	position := position + 1
]

{ #category : #accessing }
PSSortedTableComponent >> numberOfPages [
	"Calculate the number of page based in size of list objects and limit per page"

	^ (self filteredRows size / self elementsToShow) roundUpTo: 1
]

{ #category : #'rendering-optionBar' }
PSSortedTableComponent >> optionBarSectionId [
	^ self tableId asString, '-option-bar'
]

{ #category : #'rendering-optionBar' }
PSSortedTableComponent >> optionBarSectionStyle [
	^ 'border: 1px solid rgba(0,0,0,.12); 
		padding: 0px 10px; display: flex;
    	justify-content: space-between;'
]

{ #category : #accessing }
PSSortedTableComponent >> pageOf: aPage [

	position := aPage
]

{ #category : #accessing }
PSSortedTableComponent >> position [

	^ position
]

{ #category : #accessing }
PSSortedTableComponent >> position: aNumber [

	position := aNumber
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> previousPage [

	position := position - 1
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> psTableClasses [
	^ 'mdl-shadow--2p'
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> psTableId [
	^ self tableId asString , '-pstable'
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> psTableStyles [
	^ 'width:100%;'
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> rangeOfPages [

	(self numberOfPages < 4)
		ifTrue: [
			^ 1 to: self numberOfPages ]
		ifFalse: [
			^ self firstPageShowed to: self limitOfShowedPages ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> render: html with: anObject [
	"Render object on html"

	anObject do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderBackButtonOn: html [
	self isFirstPage
		ifTrue: [ html mdlButton
						id: 'previous-button-pagination';
						disabled;
						raised;
						with: 'prev' ]
		ifFalse: [
	html mdlButton
		id: 'previous-button-pagination';
		raised;
		primaryColor;
		rippleEffect;
		onClick: (self executeCallback: [ self previousPage ] on: html);
		with: 'prev' ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderBackButtonsOn: html [
	html div
		id: 'back-section';
		with: [ self renderFirstButtonOn: html.
			self renderBackButtonOn: html ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderButtonOfPage: aPage on: html [
	(self isSelectedPage: aPage)
		ifTrue: [ html mdlButton
						id: 'button-pagination' , aPage printString;
						style: 'margin: 0px 10px';
						disabled;
						raised;
						with: aPage printString ]
		ifFalse: [
	html mdlButton
		raised;
		id: 'button-pagination' , aPage printString;
		style: 'margin: 0px 10px';
		onClick: (self executeCallback: [ self pageOf: aPage ] on: html);
		with: aPage printString ]
]

{ #category : #rendering }
PSSortedTableComponent >> renderContentOn: html [

	showPaginationBar
		ifTrue: [ self renderPaginationBarTopSectionOn: html ].
	(showSelectionLimit or: [ showSearchingField ])
		ifTrue: [ self renderOptionBarSectionOn: html ].
	self renderTableSectionOn: html.
	showPaginationBar
		ifTrue: [ self renderPaginationBarBottomSectionOn: html ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderFirstButtonOn: html [

	self isFirstPage
		ifTrue: [ html mdlButton
						id: 'first-button-pagination';
						style: 'margin: 0px 10px';
						disabled;
						raised;
						with: 'first' ]
		ifFalse: [
	html mdlButton
		id: 'first-button-pagination';
		style: 'margin: 0px 10px';
		primaryColor;
		rippleEffect;
		onClick: (self executeCallback: [ self firstPage ] on: html);
		with: 'first' ]
]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> renderLabelRowsOn: html [

	html div
		style: self selectBoxLabelStyles;
		with: [ html label: 'Rows per page: ' ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderLastButtonOn: html [

	self isLastPage
		ifTrue: [ html mdlButton
						id: 'last-button-pagination';
						style: 'margin: 0px 10px';
						disabled;
						raised;
						with: 'last' ]
		ifFalse: [
			html mdlButton
				id: 'last-button-pagination';
				style: 'margin: 0px 10px';
				primaryColor;
				rippleEffect;
				onClick: (self executeCallback: [ self lastPage ] on: html);
				with: 'last' ]
]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> renderLimitRowsSelectBoxOn: html [
	html
		render:
			(MDLSelectWidget new
				labelBlock: #asString;
				possibilities: self rowsPerPagePossibilities;
				callback: [ :newLimit | 
					elementsToShow := newLimit.
					position := 1 ];
				selectedObject: elementsToShow;
				sortBlock: [ :a :b | a asInteger <= b asInteger ];
				customizationBlock:
						[ :textField | textField onChange: (self changeLimitRowsOn: html) ];
				yourself)
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderNextButtonOn: html [

	self isLastPage
		ifTrue: [ html mdlButton
						id: 'last-button-pagination';
						style: 'margin: 0px 10px';
						disabled;
						raised;
						with: 'next' ]
		ifFalse: [
	html mdlButton
		id: 'next-button-pagination';
		style: 'margin: 0px 10px';
		raised;
		primaryColor;
		rippleEffect;
		onClick: (self executeCallback: [ self nextPage ] on: html);
		with: 'next' ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderNextButtonsOn: html [
	html div
		id: 'next-section';
		with: [ self renderNextButtonOn: html.
			self renderLastButtonOn: html ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> renderNoResultRowOn: html [

	html tableRow: [
			html mdlTableCell 
				colSpan: self header size; 
				nonNumerical;
				style: 'text-align: center;'; 
				with: 'No matching results found' ]
]

{ #category : #'rendering-optionBar' }
PSSortedTableComponent >> renderOptionBarSectionOn: html [

	html div
		id: self optionBarSectionId;
		style: self optionBarSectionStyle;
		with: [ 
			(showSelectionLimit and: [ showPaginationBar ])
				ifTrue: [ self renderSelectBoxSectionOn: html ].
			showSearchingField
				ifTrue: [ self renderSearchingInputOn: html ]. ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderPageButtonsOn: html [

	self rangeOfPages do: [ :page | self renderButtonOfPage: page on: html ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderPaginationBarBottomSectionOn: html [
	
	html div
		id: self tableId asString, '-pagination-bar-bottom';
		style: 'display: flex; justify-content: space-evenly; padding: 10px 0px;';
		with: [ self renderPaginationBarOn: html ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderPaginationBarOn: html [
	self filteredRows size > elementsToShow
		ifFalse: [ ^ self ].
	self renderBackButtonsOn: html.
	self renderPaginationButtonsOn: html.
	self renderNextButtonsOn: html
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderPaginationBarTopSectionOn: html [

	html div
		id: self tableId asString, '-pagination-bar-top';
		style: 'display: flex; justify-content: space-evenly; padding: 10px 0px;';
		with: [ self renderPaginationBarOn: html ]
]

{ #category : #'rendering-pagination' }
PSSortedTableComponent >> renderPaginationButtonsOn: html [
	html div
		id: 'page-button-section';
		with: [ self renderPageButtonsOn: html ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> renderRowsOfPageOn: html [
	"Render rows of a page on html"
	
	self subclassResponsibility
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> renderRowsOn: html [
	
	self haveAnyRowFiltered
		ifTrue: [ self renderNoResultRowOn: html ]
		ifFalse: [ self renderRowsOfPageOn: html ]
]

{ #category : #'rendering-searching' }
PSSortedTableComponent >> renderSearchingInputOn: html [

	html div
		with: [ html mdlTextFieldContainer
				floatingLabel;
				style: 'width: 200px; margin 0px 10px';
				with: [ html mdlTextFieldLabel
						for: self tableId asString , '-searchInputTable';
						with: 'Search'.
					html mdlTextFieldInput
						value: self searchingText;
						onInput: (self filterRowsOn: html);
						noAutocomplete;
						id: self tableId asString , '-searchInputTable' ] ]
]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> renderSelectBoxOn: html [
	
	html div
		style: self selectBoxStyles;
		with: [ self renderLimitRowsSelectBoxOn: html ]
]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> renderSelectBoxSectionOn: html [

	html div
		style: 'display: flex';
		with: [ 
			self renderLabelRowsOn: html.
			self renderSelectBoxOn: html ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> renderTableHeaderOn: html [
	html
		tableHead: [ html
				tableRow: [ header
						doWithIndex: [ :head :i | 
							(self isAHeaderOption: head)
								ifTrue: [ head renderContentOn: html ]
								ifFalse: [ head renderContentOn: html forTable: self columnIndex: i ] ] ] ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> renderTableOn: html [

	html mdlTable
		id: self psTableId;
		class: self psTableClasses;
		style: self psTableStyles;
		with: [ 
			self renderTableHeaderOn: html.
			self renderRowsOn: html ]
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> renderTableSectionOn: html [

	html div
		id: self tableId;
		style: 'overflow-x: auto;';
		with: [ self renderTableOn: html ]
]

{ #category : #accessing }
PSSortedTableComponent >> rows [

	^ rows value
]

{ #category : #accessing }
PSSortedTableComponent >> rows: aCollection [

	rows := aCollection.
	self filteredRows: (self rows copy).
	unsortedRows := (self filteredRows copy)
]

{ #category : #'rendering-table' }
PSSortedTableComponent >> rowsByPage [
	"List of objects on a given page"

	| listOfPage index |
	listOfPage := self initializeList.
	showPaginationBar ifFalse: [ ^ self filteredRows copy ].
	index := (position - 1) * elementsToShow.
	index := index + 1.
	[ listOfPage size < elementsToShow and: [ index <= self filteredRows size ] ]
		whileTrue: [ 
			self addObjectOfIndex: index to: listOfPage.
			index := index + 1 ].
	^ listOfPage
]

{ #category : #accessing }
PSSortedTableComponent >> rowsPerPagePossibilities [
	^ rowsPerPagePossibilities
]

{ #category : #accessing }
PSSortedTableComponent >> rowsPerPagePossibilities: aCollection [
	rowsPerPagePossibilities := aCollection.
	aCollection ifNotEmpty: [ self elementsToShow: aCollection first ]
]

{ #category : #accessing }
PSSortedTableComponent >> searchingText [

	^ searchingText
]

{ #category : #accessing }
PSSortedTableComponent >> searchingText: aString [

	searchingText := aString
]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> selectBoxLabelStyles [
	^ 'align-self: center; margin: 0px 20px'
]

{ #category : #'rendering-selectBox' }
PSSortedTableComponent >> selectBoxStyles [
	^ 'width: 60px;'
]

{ #category : #accessing }
PSSortedTableComponent >> showPaginationBar: aBoolean [

	showPaginationBar := aBoolean
]

{ #category : #accessing }
PSSortedTableComponent >> showSearchingField: aBoolean [

	showSearchingField := aBoolean
]

{ #category : #accessing }
PSSortedTableComponent >> showSelectionLimit: aBoolean [

	showSelectionLimit := aBoolean
]

{ #category : #sorting }
PSSortedTableComponent >> sortAscendingAtRow: aRowIndex [
	self sortAtRow: aRowIndex using: #>
]

{ #category : #sorting }
PSSortedTableComponent >> sortAtRow: aRowIndex using: aSelector [
	self header
		do: [ :each | 
			(self header at: aRowIndex) = each
				ifFalse: [ each unsort ] ].
	self sortCollectionwith: aSelector OnRowIndex: aRowIndex
]

{ #category : #sorting }
PSSortedTableComponent >> sortCollectionwith: aSelector OnRowIndex: aRowIndex [

	self subclassResponsibility.
]

{ #category : #sorting }
PSSortedTableComponent >> sortDescendingAtRow: aRowIndex [
	self sortAtRow: aRowIndex using: #<
]

{ #category : #accessing }
PSSortedTableComponent >> tableId [

	^ tableId
]

{ #category : #accessing }
PSSortedTableComponent >> tableId: anId [

	tableId := anId
]

{ #category : #sorting }
PSSortedTableComponent >> unsort [

	self filteredRows: unsortedRows copy.
	unsortedRows := self filteredRows copy.
]

{ #category : #'rendering-searching' }
PSSortedTableComponent >> validateFilterOf: anObject [
	
	self subclassResponsibility.
]
