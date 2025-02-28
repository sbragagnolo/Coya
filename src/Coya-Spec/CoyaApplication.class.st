"
I am an application that holds a coya instance. 
"
Class {
	#name : #CoyaApplication,
	#superclass : #SpApplication,
	#traits : 'TCoyaConvenienceAPI',
	#classTraits : 'TCoyaConvenienceAPI classTrait',
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
CoyaApplication class >> reset [
	instance := nil 
]

{ #category : #accessing }
CoyaApplication >> coya [
	^ coya
]

{ #category : #initialization }
CoyaApplication >> initialize [ 
	super initialize.
	coya := Coya new.
	self initializeTopicsAndServices 
]

{ #category : #accessing }
CoyaApplication >> initializeTopicsAndServices [
]
