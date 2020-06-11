"
Description
-----------

I am an example app of Paginated table
"
Class {
	#name : #PSTableDemoApp,
	#superclass : #WAComponent,
	#instVars : [
		'tableOne',
		'tableTwo',
		'tableThree',
		'tableFour',
		'tableFive',
		'listContactOne',
		'listContactTwo',
		'listContactLittleOne',
		'tableSix',
		'tableSeven'
	],
	#category : #'PSTableSeaside-Demo'
}

{ #category : #testing }
PSTableDemoApp class >> canBeRoot [

	^ true
]

{ #category : #'class initialization' }
PSTableDemoApp class >> initialize [

	(WAAdmin register: self asApplicationAt: 'TablePaginationSeasideApp')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: MDLDemoLibrary
]

{ #category : #accessing }
PSTableDemoApp >> blockTableToExecute [

	^ [ :user :html | 
	OrderedCollection new
		add: ([ :att | att at: 1 ] value: user);
		add: ([ :att | att at: 2 ] value: user);
		add: ([ :att | att at: 3 ] value: user);
		add: ([ :att | att at: 4 ] value: user);
		yourself ]
]

{ #category : #actions }
PSTableDemoApp >> deleteContact: aContact ofList: aList [

	aList remove: aContact
]

{ #category : #accessing }
PSTableDemoApp >> headerWithOptions [

	^ { 'Id' . 'Full Name' . 'Email' . 'Genre' . PSTableSortableHeaderOptions new cell: '' }
]

{ #category : #accessing }
PSTableDemoApp >> headers [

	^ { 'Id' . 'Full Name' . 'Email' . 'Genre' }
]

{ #category : #initialization }
PSTableDemoApp >> initialize [
	self initializeCollection.
	self initializeTableOne.
	self initializeTableTwo.
	self initializeTableThree.
	self initializeTableFour.
	self initializeTableFive.
	self initializeTableSix.
	self initializeTableSeven
]

{ #category : #initialization }
PSTableDemoApp >> initializeCollection [
	listContactOne := self orderedCollectionContact.
	listContactLittleOne := self orderedCollectionContactLittle.
	listContactTwo := self orderedDictionaryContact
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableFive [

	tableFive := ExampleTableCollection new
		header: self headers;
		rows: listContactOne;
		tableId: 'table-pagination-5';
		showSelectionLimit: false
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableFour [

	tableFour := ExampleTableCollection new
		header: self headers;
		rows: listContactOne;
		tableId: 'table-pagination-4';
		showPaginationBar: false
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableOne [

	tableOne := ExampleTableBlock new
						header: self headerWithOptions;
						rows: listContactOne;
						tableId: 'table-pagination-1';
						blockToExecute: self blockTableToExecute;
						listToRenderButton: self listDataToRenderButtonOne;
						dictToRenderDownloadButton: Dictionary new.
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableSeven [

	tableSeven := ExampleTableCollection new
		header: self headers;
		rows: listContactOne;
		tableId: 'table-pagination-7';
		showSearchingField: false;
		showPaginationBar: false;
		showSelectionLimit: false
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableSix [

	tableSix := ExampleTableCollection new
		header: self headers;
		rows: listContactOne;
		tableId: 'table-pagination-6';
		showSearchingField: false
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableThree [

	tableThree := ExampleTableDictionary new
						header: self headers;
						rows: listContactTwo;
						tableId: 'table-pagination-3'
]

{ #category : #initialization }
PSTableDemoApp >> initializeTableTwo [

	tableTwo := ExampleTableCollection new
						header: self headers;
						rows: listContactOne;
						tableId: 'table-pagination-2'
]

{ #category : #accessing }
PSTableDemoApp >> listDataToRenderButtonOne [

	^ OrderedCollection new
		add:
			(Array
				with: 'delete'
				with: [ :contact | "Functionality not implemented" ]
				with: [ :contact | (contact at: 1) asString , '-delete' ]
				with: 'Delete user'
				with: 'return alert(''User deleted!'');'
				with: false);
			yourself
]

{ #category : #accessing }
PSTableDemoApp >> listDataToRenderButtonTwo [

	^ OrderedCollection new
		add:
			(Array
				with: 'delete'
				with: [ :contact | self deleteContact: contact ofList: listContactTwo ]
				with: [ :contact | (contact at: 1) , '-delete' ]
				with: 'Delete user'
				with: 'return confirm(''Are you sure you want to delete this contact?'');'
				with: false);
			yourself
]

{ #category : #accessing }
PSTableDemoApp >> orderedCollectionContact [

	^ OrderedCollection new
		add: #(1 'Dan Marsh' 'dan@mail.com' 'Male');
		add: #(2 'Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #(3 'Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #(4 'Bob Jones' 'bob@mail.com' 'Male');
		add: #(5 'Bill Martinez' 'bill@mail.com' 'Male'); 
		add: #(6 'Jenny Klein' 'jenny@mail.com' 'Female');
		add: #(7 'Samantha Martinez' 'dany@mail.com' 'Female');
		add: #(8 'Jan Bourne' 'jan@mail.com' 'Female'); 
		add: #(9 'Al Bourne' 'al@mail.com' 'Male'); 
		add: #(10 'Jhon Hall' 'jhon@mail.com' 'Male');
		add: #(11 'Melissa Price' 'melissa@mail.com' 'Female'); 
		add: #(12 'Sarah Baldwin' 'sarah@mail.com' 'Female');
		add: #(13 'Jessica Price' 'jessica@mail.com' 'Female');
		add: #(14 'Tyler Payne' 'tyler@mail.com' 'Male'); 
		add: #(15 'Ashton Wallace' 'ashton@mail.com' 'Male'); 
		add: #(16 'Karen Morrison' 'karen@mail.com' 'Female');
		add: #(17 'Jule Stanton' 'jule@mail.com' 'Female');
		add: #(18 'Cris Maxwell' 'cris@mail.com' 'Male');
		add: #(19 'Cristopher Thomson' 'cristopher@mail.com' 'Male');
		add: #(20 'William Davis' 'william@mail.com' 'Male');
		add: #(21 'Steve Anderson' 'steve@mail.com' 'Male');
		add: #(22 'Dan Marsh' 'dan@mail.com' 'Male');
		add: #(23 'Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #(24 'Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #(25 'Bob Jones' 'bob@mail.com' 'Male');
		add: #(26 'Bill Martinez' 'bill@mail.com' 'Male'); 
		add: #(27 'Jenny Klein' 'jenny@mail.com' 'Female');
		add: #(28 'Samantha Martinez' 'dany@mail.com' 'Female');
		add: #(29 'Jan Bourne' 'jan@mail.com' 'Female'); 
		add: #(30 'Al Bourne' 'al@mail.com' 'Male'); 
		add: #(31 'Jhon Hall' 'jhon@mail.com' 'Male');
		add: #(32 'Melissa Price' 'melissa@mail.com' 'Female'); 
		add: #(33 'Sarah Baldwin' 'sarah@mail.com' 'Female');
		add: #(34 'Jessica Price' 'jessica@mail.com' 'Female');
		add: #(35 'Tyler Payne' 'tyler@mail.com' 'Male'); 
		add: #(36 'Ashton Wallace' 'ashton@mail.com' 'Male'); 
		add: #(37 'Karen Morrison' 'karen@mail.com' 'Female');
		add: #(38 'Jule Stanton' 'jule@mail.com' 'Female');
		add: #(39 'Cris Maxwell' 'cris@mail.com' 'Male');
		add: #(40 'Cristopher Thomson' 'cristopher@mail.com' 'Male');
		add: #(41 'William Davis' 'william@mail.com' 'Male');
		add: #(42 'Steve Anderson' 'steve@mail.com' 'Male');
		add: #(43 'Dan Marsh' 'dan@mail.com' 'Male');
		add: #(44 'Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #(45 'Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #(46 'Bob Jones' 'bob@mail.com' 'Male');
		add: #(47 'Bill Martinez' 'bill@mail.com' 'Male'); 
		add: #(48 'Jenny Klein' 'jenny@mail.com' 'Female');
		add: #(49 'Samantha Martinez' 'dany@mail.com' 'Female');
		add: #(50 'Jan Bourne' 'jan@mail.com' 'Female'); 
		add: #(51 'Al Bourne' 'al@mail.com' 'Male'); 
		add: #(52 'Jhon Hall' 'jhon@mail.com' 'Male');
		add: #(53 'Melissa Price' 'melissa@mail.com' 'Female'); 
		add: #(54 'Sarah Baldwin' 'sarah@mail.com' 'Female');
		add: #(55 'Jessica Price' 'jessica@mail.com' 'Female');
		add: #(56 'Tyler Payne' 'tyler@mail.com' 'Male'); 
		add: #(57 'Ashton Wallace' 'ashton@mail.com' 'Male'); 
		add: #(58 'Karen Morrison' 'karen@mail.com' 'Female');
		add: #(59 'Jule Stanton' 'jule@mail.com' 'Female');
		add: #(60 'Cris Maxwell' 'cris@mail.com' 'Male');
		add: #(61 'Cristopher Thomson' 'cristopher@mail.com' 'Male');
		add: #(62 'William Davis' 'william@mail.com' 'Male');
		add: #(63 'Steve Anderson' 'steve@mail.com' 'Male');
		add: #(64 'Dan Marsh' 'dan@mail.com' 'Male');
		add: #(65 'Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #(66 'Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #(67 'Bob Jones' 'bob@mail.com' 'Male');
		add: #(68 'Bill Martinez' 'bill@mail.com' 'Male'); 
		add: #(69 'Jenny Klein' 'jenny@mail.com' 'Female');
		add: #(70 'Samantha Martinez' 'dany@mail.com' 'Female');
		add: #(71 'Jan Bourne' 'jan@mail.com' 'Female'); 
		add: #(72 'Al Bourne' 'al@mail.com' 'Male'); 
		add: #(73 'Jhon Hall' 'jhon@mail.com' 'Male');
		add: #(74 'Melissa Price' 'melissa@mail.com' 'Female'); 
		add: #(75 'Sarah Baldwin' 'sarah@mail.com' 'Female');
		add: #(76 'Jessica Price' 'jessica@mail.com' 'Female');
		add: #(77 'Tyler Payne' 'tyler@mail.com' 'Male'); 
		add: #(78 'Ashton Wallace' 'ashton@mail.com' 'Male'); 
		add: #(79 'Karen Morrison' 'karen@mail.com' 'Female');
		add: #(80 'Jule Stanton' 'jule@mail.com' 'Female');
		add: #(81 'Cris Maxwell' 'cris@mail.com' 'Male');
		add: #(82 'Cristopher Thomson' 'cristopher@mail.com' 'Male');
		add: #(83 'William Davis' 'william@mail.com' 'Male');
		add: #(84 'Steve Anderson' 'steve@mail.com' 'Male');
		add: #(85 'Dan Marsh' 'dan@mail.com' 'Male');
		add: #(86 'Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #(87 'Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #(88 'Bob Jones' 'bob@mail.com' 'Male');
		add: #(89 'Bill Martinez' 'bill@mail.com' 'Male'); 
		add: #(90 'Jenny Klein' 'jenny@mail.com' 'Female');
		add: #(91 'Samantha Martinez' 'dany@mail.com' 'Female');
		add: #(92 'Jan Bourne' 'jan@mail.com' 'Female'); 
		add: #(93 'Al Bourne' 'al@mail.com' 'Male'); 
		add: #(94 'Jhon Hall' 'jhon@mail.com' 'Male');
		add: #(95 'Melissa Price' 'melissa@mail.com' 'Female'); 
		add: #(96 'Sarah Baldwin' 'sarah@mail.com' 'Female');
		add: #(97 'Jessica Price' 'jessica@mail.com' 'Female');
		add: #(98 'Tyler Payne' 'tyler@mail.com' 'Male'); 
		add: #(99 'Ashton Wallace' 'ashton@mail.com' 'Male'); 
		add: #(100 'Karen Morrison' 'karen@mail.com' 'Female');
		yourself
]

{ #category : #accessing }
PSTableDemoApp >> orderedCollectionContactLittle [

	^ OrderedCollection new
		add: #('1' 'Dan Marsh' 'dan@mail.com' 'Male');
		add: #('2' 'Ben Diaz' 'ben@mail.com' 'Male'); 
		add: #('3' 'Ann Kisaragi' 'ann@mail.com' 'Female'); 
		add: #('4' 'Bob Jones' 'bob@mail.com' 'Male');
		add: #('5' 'Bill Martinez' 'bill@mail.com' 'Male'); 
		add: #('6' 'Jenny Klein' 'jenny@mail.com' 'Female');
		add: #('7' 'Samantha Martinez' 'dany@mail.com' 'Female');
		add: #('8' 'Jan Bourne' 'jan@mail.com' 'Female'); 
		add: #('9' 'Al Bourne' 'al@mail.com' 'Male'); 
		add: #('10' 'Jhon Hall' 'jhon@mail.com' 'Male');
		yourself
]

{ #category : #accessing }
PSTableDemoApp >> orderedDictionaryContact [

	^ OrderedDictionary new
		at: 1 put: #('Dan Marsh' 'dan@mail.com' 'Male');
		at: 2 put: #('Ben Diaz' 'ben@mail.com' 'Male'); 
		at: 3 put: #('Ann Kisaragi' 'ann@mail.com' 'Female'); 
		at: 4 put: #('Bob Jones' 'bob@mail.com' 'Male');
		at: 5 put: #('Bill Martinez' 'bill@mail.com' 'Male'); 
		at: 6 put: #('Jenny Klein' 'jenny@mail.com' 'Female');
		at: 7 put: #('Samantha Martinez' 'dany@mail.com' 'Female');
		at: 8 put: #('Jan Bourne' 'jan@mail.com' 'Female'); 
		at: 9 put: #('Al Bourne' 'al@mail.com' 'Male'); 
		at: 10 put: #('Jhon Hall' 'jhon@mail.com' 'Male');
		at: 11 put: #('Melissa Price' 'melissa@mail.com' 'Female'); 
		at: 12 put: #('Sarah Baldwin' 'sarah@mail.com' 'Female');
		at: 13 put: #('Jessica Price' 'jessica@mail.com' 'Female');
		at: 14 put: #('Tyler Payne' 'tyler@mail.com' 'Male'); 
		at: 15 put: #('Ashton Wallace' 'ashton@mail.com' 'Male'); 
		at: 16 put: #('Karen Morrison' 'karen@mail.com' 'Female');
		at: 17 put: #('Jule Stanton' 'jule@mail.com' 'Female');
		at: 18 put: #('Cris Maxwell' 'cris@mail.com' 'Male');
		at: 19 put: #('Cristopher Thomson' 'cristopher@mail.com' 'Male');
		at: 20 put: #('William Davis' 'william@mail.com' 'Male');
		at: 21 put: #('Steve Anderson' 'steve@mail.com' 'Male');
		yourself
]

{ #category : #rendering }
PSTableDemoApp >> renderContentOn: html [
	html div
		style: 'padding: 10px';
		with: [
			self renderTableOneOn: html.
			self renderTableTwoOn: html.
			self renderTableThreeOn: html.
			self renderTableFourOn: html.
			self renderTableFiveOn: html.
			self renderTableSixOn: html.
			self renderTableSevenOn: html ]
]

{ #category : #rendering }
PSTableDemoApp >> renderHeadingOn: html withMessage: aString [

	html heading
		level: 2;
		with: aString.
]

{ #category : #rendering }
PSTableDemoApp >> renderTableFiveOn: html [

	self renderHeadingOn: html withMessage: 'Table Five: Render a table disabling select of limit'.
	html render: tableFive
]

{ #category : #rendering }
PSTableDemoApp >> renderTableFourOn: html [

	self renderHeadingOn: html withMessage: 'Table Four: Render a table disabling pagination bar'.
	html render: tableFour
]

{ #category : #rendering }
PSTableDemoApp >> renderTableOneOn: html [

	self renderHeadingOn: html withMessage: 'Table One: Render a table with buttons'.
	html render: tableOne
]

{ #category : #rendering }
PSTableDemoApp >> renderTableSevenOn: html [

	self renderHeadingOn: html withMessage: 'Table Seven: Render a table disabling all options'.
	html render: tableSeven
]

{ #category : #rendering }
PSTableDemoApp >> renderTableSixOn: html [

	self renderHeadingOn: html withMessage: 'Table Six: Render a table disabling search input'.
	html render: tableSix
]

{ #category : #rendering }
PSTableDemoApp >> renderTableThreeOn: html [

	self renderHeadingOn: html withMessage: 'Table Three: Render a table with a dictionary information'.
	html render: tableThree
]

{ #category : #rendering }
PSTableDemoApp >> renderTableTwoOn: html [

	self renderHeadingOn: html withMessage: 'Table Two: Render a table without buttons'.
	html render: tableTwo
]

{ #category : #updating }
PSTableDemoApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot stylesheet 
		url: (WAUrl absolute:'https://code.getmdl.io/1.3.0/material.blue-red.min.css').
]
