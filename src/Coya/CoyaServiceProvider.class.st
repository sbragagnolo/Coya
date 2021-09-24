"
I am a service provider. I am here to hold some callback mechanism and to ensure the linking between the callback and the service client. 
"
Class {
	#name : #CoyaServiceProvider,
	#superclass : #Object,
	#instVars : [
		'onRequest',
		'service',
		'owner'
	],
	#category : #'Coya-Services'
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
