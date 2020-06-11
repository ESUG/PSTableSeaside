"
Description
-----------

I am a sortable header state for sort all rows in ps table

My function is:

	- Give a state of sortable headers
	- Assign a default state
"
Class {
	#name : #PSTableSortableHeaderState,
	#superclass : #Object,
	#instVars : [
		'nextState'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #accessing }
PSTableSortableHeaderState class >> defaultNextState [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
PSTableSortableHeaderState class >> for: element [
	^ self new element: element
]

{ #category : #accessing }
PSTableSortableHeaderState >> defaultNextState [
	^ self class defaultNextState
]

{ #category : #initialization }
PSTableSortableHeaderState >> initializeNextState [
	self nextState: (self defaultNextState new nextState: (self defaultNextState defaultNextState new nextState: self))
]

{ #category : #accessing }
PSTableSortableHeaderState >> nextState [
	^ nextState ifNil: [ self initializeNextState. nextState ]
]

{ #category : #accessing }
PSTableSortableHeaderState >> nextState: anObject [
	nextState := anObject
]

{ #category : #rendering }
PSTableSortableHeaderState >> renderContentOn: html forTable: table columnIndex: i header: header [
	self subclassResponsibility 
]
