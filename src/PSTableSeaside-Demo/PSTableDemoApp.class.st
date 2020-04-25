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
		'listContactTwo'
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

{ #category : #rendering }
PSTableDemoApp >> headerWithOptions [

	^ #('Id' 'Full Name' 'Email' 'Genre' '')
]

{ #category : #rendering }
PSTableDemoApp >> headers [

	^ #('Id' 'Full Name' 'Email' 'Genre')
]

{ #category : #initialization }
PSTableDemoApp >> initialize [

	listContactOne := self orderedCollectionContact.
	listContactTwo := self orderedCollectionContact.
	tableOne := ExampleTable new
						headers: self headerWithOptions;
						listObject: listContactOne;
						tableId: 'table-pagination-1';
						limitPerPage: 7;
						blockToExecute: self blockTableToExecute;
						listToRenderButton: self listDataToRenderButtonOne;
						dictToRenderDownloadButton: Dictionary new.
	tableTwo := ExampleTable new
						headers: self headerWithOptions;
						listObject: listContactTwo;
						disablePagination: true;
						tableId: 'table-pagination-2';
						blockToExecute: self blockTableToExecute;
						listToRenderButton: self listDataToRenderButtonTwo;
						dictToRenderDownloadButton: Dictionary new.
	tableThree := ExampleTableThree new
						headers: self headers;
						listObject: self orderedDictionaryContact;
						tableId: 'table-pagination-3';
						limitPerPage: 7.
	tableFour := ExampleTableTwo new
						headers: self headers;
						listObject: self orderedCollectionContact;
						tableId: 'table-pagination-4';
						limitPerPage: 2.
	tableFive := ExampleTableTwo new
						headers: self headers;
						listObject: self orderedCollectionContact;
						tableId: 'table-pagination-5';
						limitPerPage: 2;
						limitPageShowed: 3.
]

{ #category : #accessing }
PSTableDemoApp >> listDataToRenderButtonOne [

	^ OrderedCollection new
		add:
			(Array
				with: 'delete'
				with: [ :contact | self deleteContact: contact ofList: listContactOne ]
				with: [ :contact | (contact at: 1) , '-delete' ]
				with: 'Delete user'
				with: 'return confirm(''Are you sure you want to delete this contact?'');'
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

{ #category : #rendering }
PSTableDemoApp >> orderedCollectionContact [

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
		add: #('11' 'Melissa Price' 'melissa@mail.com' 'Female'); 
		add: #('12' 'Sarah Baldwin' 'sarah@mail.com' 'Female');
		add: #('13' 'Jessica Price' 'jessica@mail.com' 'Female');
		add: #('14' 'Tyler Payne' 'tyler@mail.com' 'Male'); 
		add: #('15' 'Ashton Wallace' 'ashton@mail.com' 'Male'); 
		add: #('16' 'Karen Morrison' 'karen@mail.com' 'Female');
		add: #('17' 'Jule Stanton' 'jule@mail.com' 'Female');
		add: #('18' 'Cris Maxwell' 'cris@mail.com' 'Male');
		add: #('19' 'Cristopher Thomson' 'cristopher@mail.com' 'Male');
		add: #('20' 'William Davis' 'william@mail.com' 'Male');
		add: #('21' 'Steve Anderson' 'steve@mail.com' 'Male');
		yourself
]

{ #category : #rendering }
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
			html heading
				level: 2;
				with: 'Table One: Render a table with options'.
			html render: tableOne.
			html heading
				level: 2;
				with: 'Table Two: Render a table with a disable pagination'.
			html render: tableTwo.
			html heading
				level: 2;
				with: 'Table Three: Render a table using a dictionary'.
			html render: tableThree.
			html heading
				level: 2;
				with: 'Table Four: Render a table with a large number of pages'.
			html render: tableFour.
			html heading
				level: 2;
				with: 'Table Five: Change limit page button showed'.
			html render: tableFive ]
]

{ #category : #updating }
PSTableDemoApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot stylesheet 
		url: (WAUrl absolute:'https://code.getmdl.io/1.3.0/material.blue-red.min.css').
]
