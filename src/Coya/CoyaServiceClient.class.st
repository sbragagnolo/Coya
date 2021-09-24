"
I am a service client. I am able to invoke a service with the proper parameters 
"
Class {
	#name : #CoyaServiceClient,
	#superclass : #Object,
	#instVars : [
		'service',
		'owner'
	],
	#category : #'Coya-Services'
}

{ #category : #accessing }
CoyaServiceClient >> owner: anOwner [

	owner := anOwner
]

{ #category : #accessing }
CoyaServiceClient >> request: aParameter [

	^ self
		  request: aParameter
		  ifNoneProvider: [ 
		  NoneProvider signal: ' Non provider is yet available ' ]
]

{ #category : #'as yet unclassified' }
CoyaServiceClient >> request: aParamter ifNoneProvider: aFullBlockClosure [

	^ service
		  request: aParamter
		  for: owner
		  ifNoneProvider: aFullBlockClosure
]

{ #category : #accessing }
CoyaServiceClient >> service: aCoyaService [

	service := aCoyaService
]
