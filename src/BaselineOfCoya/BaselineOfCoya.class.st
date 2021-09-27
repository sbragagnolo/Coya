Class {
	#name : #BaselineOfCoya,
	#superclass : #BaselineOf,
	#category : #BaselineOfCoya
}

{ #category : #baselines }
BaselineOfCoya >> baseline: spec [

	<baseline>
	spec
		package: #Coya;
		package: #'Coya-Slots' with: [ spec requires: #( 'Coya' ) ];
		package: #'Coya-Spec'
		with: [ spec requires: #( 'Coya' 'Coya-Slots' ) ];
		package: #'Coya-Tests'
		with: [ spec requires: #( 'Coya' 'Coya-Slots' 'Coya-Spec' ) ]
]
