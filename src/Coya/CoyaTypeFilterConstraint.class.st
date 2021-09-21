"
I allow to duck-type by registering constraints such as ""shouldUnderstand"" 
"
Class {
	#name : #CoyaTypeFilterConstraint,
	#superclass : #CoyaTypeFilter,
	#instVars : [
		'rules'
	],
	#category : #Coya
}

{ #category : #asserting }
CoyaTypeFilterConstraint >> filter: anObject [

	^ rules allSatisfy: [ :r | r value: anObject ]
]

{ #category : #asserting }
CoyaTypeFilterConstraint >> initialize [

	super initialize.
	rules := Set new
]

{ #category : #testing }
CoyaTypeFilterConstraint >> isTypeConstraint [

	^ true
]

{ #category : #asserting }
CoyaTypeFilterConstraint >> shouldUnderstand: aString [

	rules add: [ :a | a respondsTo: aString asSymbol ]
]
