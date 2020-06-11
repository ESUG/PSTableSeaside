"
Description
-----------

I am a sortable header state for unsort all rows in ps table

My function is:

	- Render rows unsort
"
Class {
	#name : #PSTableSortableHeaderElementUnsorted,
	#superclass : #PSTableSortableHeaderState,
	#category : #'PSTableSeaside-Components'
}

{ #category : #accessing }
PSTableSortableHeaderElementUnsorted class >> defaultNextState [
	^ PSTableSortableHeaderElementSortedAscending
]

{ #category : #rendering }
PSTableSortableHeaderElementUnsorted >> renderContentOn: html forTable: table columnIndex: i header: header [
	(header headingCellOn: html)
		onClick:
			(html jQuery ajax
				callback: [ table sortAscendingAtRow: i.
					header goToNextState ];
				onSuccess: (table ajaxUpdateScriptFrom: html));
		with: header cells
]
