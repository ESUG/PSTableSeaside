"
Description
-----------

I am a sortable header state for sort ascending all rows in ps table

My function is:

	- Render rows ascending
"
Class {
	#name : #PSTableSortableHeaderElementSortedAscending,
	#superclass : #PSTableSortableHeaderState,
	#category : #'PSTableSeaside-Components'
}

{ #category : #accessing }
PSTableSortableHeaderElementSortedAscending class >> defaultNextState [

	^ PSTableSortableHeaderElementSortedDescending
]

{ #category : #rendering }
PSTableSortableHeaderElementSortedAscending >> renderContentOn: html forTable: table columnIndex: i header: header [
	(header headingCellOn: html)
		sortedAscending;
		onClick:
			(html jQuery ajax
				callback: [ table sortDescendingAtRow: i.
					header goToNextState ];
				onSuccess: (table ajaxUpdateScriptFrom: html));
		with: header cells
]
