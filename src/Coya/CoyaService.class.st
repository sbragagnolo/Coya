Class {
	#name : #CoyaService,
	#superclass : #Object,
	#instVars : [
		'name',
		'provider'
	],
	#category : #Coya
}

{ #category : #'as yet unclassified' }
CoyaService >> installProvider: aCoyaServiceProvider [

	provider ifNotNil: [ 
		^ TooMuchProviders signal: 'The service has already a provider' ].
	provider := aCoyaServiceProvider.
	aCoyaServiceProvider setService: self
]

{ #category : #accessing }
CoyaService >> name: aString [ 
	name := aString
]

{ #category : #'as yet unclassified' }
CoyaService >> request: aParameter for: aClient ifNoneProvider: aFullBlockClosure [

	^ provider
		  ifNil: [ aFullBlockClosure value ]
		  ifNotNil: [ provider request: aParameter for: aClient ]
]
