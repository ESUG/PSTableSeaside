"
Description
-----------

I am the principal component to create a paginated table with dictionaries
"
Class {
	#name : #PSSortedTableDictionaryComponent,
	#superclass : #PSSortedTableComponent,
	#category : #'PSTableSeaside-Components'
}

{ #category : #initialization }
PSSortedTableDictionaryComponent >> initializeList [

	^ OrderedDictionary new
]

{ #category : #'rendering-searching' }
PSSortedTableDictionaryComponent >> validateFilterOf: anObject [
	
	self subclassResponsibility
]
