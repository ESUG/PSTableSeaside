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
				package: 'PSTableSeaside-Components'  with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'PSTableSeaside-Demo'  with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'PSTableSeaside-Tests' with: [ spec requires: 'Seaside3' ];
				package: 'PSTableSeaside-Extensions' ]
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
