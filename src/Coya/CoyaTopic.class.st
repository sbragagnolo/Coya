Class {
	#name : #CoyaTopic,
	#superclass : #Object,
	#instVars : [
		'name',
		'latching',
		'publishers',
		'subscribers',
		'lastMessage'
	],
	#category : #Coya
}

{ #category : #'as yet unclassified' }
CoyaTopic >> beLatching [
	latching := true. 
]

{ #category : #'as yet unclassified' }
CoyaTopic >> beNotLatching [
	latching := false. 
]

{ #category : #'as yet unclassified' }
CoyaTopic >> initialize [

	super initialize.
	self beLatching.
	publishers := Set new.
	subscribers := Set new.
]

{ #category : #'as yet unclassified' }
CoyaTopic >> latching [

	^ latching
]

{ #category : #accessing }
CoyaTopic >> name [
	^ name
]

{ #category : #accessing }
CoyaTopic >> name: aString [ 
	name := aString
]

{ #category : #'as yet unclassified' }
CoyaTopic >> publicationFor: anOwner [

	^ publishers detect: [ :p | p owner = anOwner ] ifNone: [ 
		  | pub |
		  pub := CoyaPublication new
			         topic: self;
			         owner: anOwner.
		  publishers add: pub ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> publisher: anOwner publishes: aContent [

	self latching ifTrue: [ lastMessage := aContent ].

	subscribers
		select: [ :s | s shouldReceive: aContent ]
		thenDo: [ :s | s receive: aContent ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> subscriptionFor: anOwner [

	^ subscribers detect: [ :p | p owner = anOwner ] ifNone: [ 
		  | pub |
		  pub := CoyaSubscription new
			         topic: self;
			         owner: anOwner.
		  subscribers add: pub ]
]
