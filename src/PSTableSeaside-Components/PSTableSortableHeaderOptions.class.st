Class {
	#name : #PSTableSortableHeaderOptions,
	#superclass : #Object,
	#instVars : [
		'cell'
	],
	#category : #'PSTableSeaside-Components'
}

{ #category : #accessing }
PSTableSortableHeaderOptions >> cell [

	^ cell
]

{ #category : #accessing }
PSTableSortableHeaderOptions >> cell: anObject [

	cell := anObject
]

{ #category : #rendering }
PSTableSortableHeaderOptions >> renderContentOn: aRenderer [

	aRenderer mdlTableHeading
		nonNumerical
		with: cell.
]

{ #category : #sorting }
PSTableSortableHeaderOptions >> unsort [

]
