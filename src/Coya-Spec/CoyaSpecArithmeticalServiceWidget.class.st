"
I am a widget that register the arithmetical operations required and responds to requests with results 
"
Class {
	#name : #CoyaSpecArithmeticalServiceWidget,
	#superclass : #CoyaSpecWidget,
	#instVars : [
		'label'
	],
	#category : #'Coya-Spec-Examples'
}

{ #category : #specs }
CoyaSpecArithmeticalServiceWidget class >> defaultSpec [

	^ SpBoxLayout newLeftToRight add: #label
]

{ #category : #specs }
CoyaSpecArithmeticalServiceWidget class >> open [

	<example>
	self new openWithSpec
]

{ #category : #initialization }
CoyaSpecArithmeticalServiceWidget >> initializePresenters [

	super initializePresenters.
	label := self newLabel
		         label: '....';
		         yourself
]

{ #category : #initialization }
CoyaSpecArithmeticalServiceWidget >> initializeTopicsAndServices [

	self provide: #arithmeticalService sending: #value:from: to: self
]

{ #category : #initialization }
CoyaSpecArithmeticalServiceWidget >> value: anArray from: aSender [

	label label: aSender asString , ' requires the calculation of '
		, anArray first asString , ' X ' , anArray second asString.
	^ anArray first * anArray second
]
