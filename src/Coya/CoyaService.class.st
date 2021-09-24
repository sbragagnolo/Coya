"
I represent a named service i represent a provider that is able to process a request and to respond to a client .
"
Class {
	#name : #CoyaService,
	#superclass : #Object,
	#instVars : [
		'name',
		'provider'
	],
	#category : #'Coya-Services'
}

{ #category : #'as yet unclassified' }
CoyaService >> installProvider: aCoyaServiceProvider [
	| prov |
	prov := provider ifNotNil: [ :p | p first ].
	
	prov ifNotNil: [ 
		^ TooMuchProviders signal: 'The service has already a provider' ].
	provider := aCoyaServiceProvider asWeakReference.
	aCoyaServiceProvider setService: self
]

{ #category : #accessing }
CoyaService >> name: aString [ 
	name := aString
]

{ #category : #'as yet unclassified' }
CoyaService >> request: aParameter for: aClient ifNoneProvider: aFullBlockClosure [

	| prov |
	prov := provider ifNotNil: [ :p | p first ].
	^ prov
		  ifNil: [ aFullBlockClosure value ]
		  ifNotNil: [ prov request: aParameter for: aClient ]
]
