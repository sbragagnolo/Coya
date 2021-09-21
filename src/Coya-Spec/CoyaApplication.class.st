Class {
	#name : #CoyaApplication,
	#superclass : #SpApplication,
	#instVars : [
		'coya'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Coya-Spec'
}

{ #category : #accessing }
CoyaApplication class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
CoyaApplication >> coya [
	^ coya
]

{ #category : #initialization }
CoyaApplication >> initialize [ 
	super initialize.
	coya := Coya new.
]
