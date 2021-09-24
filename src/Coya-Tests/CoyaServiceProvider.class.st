Class {
	#name : #CoyaServiceProvider,
	#superclass : #Object,
	#instVars : [
		'onRequest',
		'service',
		'owner'
	],
	#category : #'Coya-Tests'
}

{ #category : #'as yet unclassified' }
CoyaServiceProvider >> onRequestSend: aMessage to: anObject [ 
	onRequest := aMessage asSendTo: anObject .
]

{ #category : #accessing }
CoyaServiceProvider >> owner: anOwner [

	owner := anOwner
]

{ #category : #'as yet unclassified' }
CoyaServiceProvider >> request: aParameter for: aSender [

	^ onRequest cull: aParameter cull: aSender
]

{ #category : #accessing }
CoyaServiceProvider >> service: aCoyaService [

	aCoyaService installProvider: self
]

{ #category : #initialization }
CoyaServiceProvider >> setService: aCoyaService [

	service := aCoyaService
]
