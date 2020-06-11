"
Description
-----------

I am a sortable header state for sort descending all rows in ps table

My function is:

	- Render rows descending
"
Class {
	#name : #PSTableSortableHeaderElementSortedDescending,
	#superclass : #PSTableSortableHeaderState,
	#category : #'PSTableSeaside-Components'
}

{ #category : #accessing }
PSTableSortableHeaderElementSortedDescending class >> defaultNextState [

	^ PSTableSortableHeaderElementUnsorted
]

{ #category : #rendering }
PSTableSortableHeaderElementSortedDescending >> renderContentOn: html forTable: table columnIndex: i header: header [
	(header headingCellOn: html)
		sortedDescending;
		onClick:
			(html jQuery ajax
				callback: [ table unsort.
					header goToNextState ];
				onSuccess: (table ajaxUpdateScriptFrom: html));
		with: header cells
]
