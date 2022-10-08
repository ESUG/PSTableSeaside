"
Right now disabling the dependencies because the only user may have dependencies that are looping.
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
				package: 'PSTableSeaside-Components' ;
					"with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];"
				package: 'PSTableSeaside-Demo'  
					with: [ spec requires: #('PSTableSeaside-Components')]; 
				package: 'PSTableSeaside-Tests' with: [ spec requires: 'PSTableSeaside-Components' ];
				package: 'PSTableSeaside-Extensions' ]
]

{ #category : #initialization }
BaselineOfPSTableSeaside >> setUpDependencies: spec [

	"for now disable the dependencies"
	"spec	
		baseline: 'Seaside3'	
		with: [ spec	
				repository: 'github://SeasideSt/Seaside:v3.4.8/repository' ]."
	"spec
		baseline: 'MaterialDesignLite'
		with: [ spec repository: 'github://DuneSt/MaterialDesignLite:v2.4.1/src' ]"
]
