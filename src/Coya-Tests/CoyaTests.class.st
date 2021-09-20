Class {
	#name : #CoyaTests,
	#superclass : #TestCase,
	#instVars : [
		'coya'
	],
	#category : #'Coya-Tests'
}

{ #category : #initialization }
CoyaTests >> setUp [
	super setUp.
	coya := Coya new. 
	
]
