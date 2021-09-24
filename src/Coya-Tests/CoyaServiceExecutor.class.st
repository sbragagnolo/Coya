Class {
	#name : #CoyaServiceExecutor,
	#superclass : #Object,
	#instVars : [
		'service',
		'owner'
	],
	#category : #'Coya-Tests'
}

{ #category : #accessing }
CoyaServiceExecutor >> owner: anOwner [

	owner := anOwner
]

{ #category : #accessing }
CoyaServiceExecutor >> request: aParameter [

	^ self
		  request: aParameter
		  ifNoneProvider: [ 
		  NoneProvider signal: ' Non provider is yet available ' ]
]

{ #category : #'as yet unclassified' }
CoyaServiceExecutor >> request: aParamter ifNoneProvider: aFullBlockClosure [

	^ service
		  request: aParamter
		  for: owner
		  ifNoneProvider: aFullBlockClosure
]

{ #category : #accessing }
CoyaServiceExecutor >> service: aCoyaService [

	service := aCoyaService
]
