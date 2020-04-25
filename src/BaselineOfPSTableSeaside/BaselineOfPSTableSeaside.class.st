"
Description
-----------


Baseline with all dependencies to PSTableSeaside
"
Class {
	#name : #BaselineOfPSTableSeaside,
	#superclass : #BaselineOf,
	#category : #BaselineOfPSTableSeaside
}

{ #category : #baselines }
BaselineOfPSTableSeaside >> baseline: spec [

	<baseline>
	
	spec
		for: #common
		do: [
			self setUpDependencies: spec.
			spec
				package: 'TablePaginationSeaside-Components'  with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'TablePaginationSeaside-Demo'  with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'TablePaginationSeaside-Tests' with: [ spec requires: 'Seaside3' ] ]
]

{ #category : #initialization }
BaselineOfPSTableSeaside >> setUpDependencies: spec [

	spec	
		baseline: 'Seaside3'	
		with: [ spec	
				repository: 'github://SeasideSt/Seaside:v3.4.x/repository' ].
	spec
		baseline: 'MaterialDesignLite'
		with: [ spec repository: 'github://daniapq/MaterialDesignLite:master/src' ]
]
