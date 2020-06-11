"
Description
-----------

I am a header element to sort rows in a pstable

My function is:

	- Asign an option to sort rows
	- Change state of table
	- Render content of table
"
Class {
	#name : #PSTableSortableHeader,
	#superclass : #Object,
	#instVars : [
		'cells',
		'currentState',
		'unsortedState'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #'instance creation' }
PSTableSortableHeader class >> for: element [
	^ self new cells: element
]

{ #category : #converting }
PSTableSortableHeader >> asPSTableSortableHeader [

	^ self
]

{ #category : #accessing }
PSTableSortableHeader >> cells [

	^ cells
]

{ #category : #accessing }
PSTableSortableHeader >> cells: aCollection [
	cells := aCollection
]

{ #category : #accessing }
PSTableSortableHeader >> currentState [
	^ currentState
		ifNil: [ self unsort.
			currentState ]
]

{ #category : #accessing }
PSTableSortableHeader >> currentState: anObject [
	currentState := anObject
]

{ #category : #'state handling' }
PSTableSortableHeader >> goToNextState [
	self currentState: self currentState nextState
]

{ #category : #rendering }
PSTableSortableHeader >> headingCellOn: html [

	^ html mdlTableHeading
		nonNumerical;
		style: 'cursor: pointer;';
		yourself
]

{ #category : #initialization }
PSTableSortableHeader >> initialize [
	super initialize.
	unsortedState := MDLSortableTableHeaderElementUnsorted new
]

{ #category : #rendering }
PSTableSortableHeader >> renderContentOn: aRenderer forTable: table columnIndex: i [

	self currentState 
		renderContentOn: aRenderer 
		forTable: table 
		columnIndex: i 
		header: self
]

{ #category : #rendering }
PSTableSortableHeader >> tableCellOn: html [
	^ html mdlTableCell nonNumerical
]

{ #category : #sorting }
PSTableSortableHeader >> unsort [
	self currentState: self unsortedState
]

{ #category : #accessing }
PSTableSortableHeader >> unsortedState [
	^ unsortedState
]

{ #category : #accessing }
PSTableSortableHeader >> unsortedState: anObject [
	unsortedState := anObject
]
