"
I am a topic. I represent a subject of conversation. I deal inside with publishers and subscribers 
"
Class {
	#name : #CoyaTopic,
	#superclass : #Object,
	#instVars : [
		'name',
		'latching',
		'publishers',
		'subscribers',
		'lastMessage',
		'lastPublisher'
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
	publishers := WeakOrderedCollection new.
	subscribers := WeakOrderedCollection new.
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

	^self publishers detect: [ :p | p owner = anOwner ] ifNone: [ 
		  | pub |
		  pub := CoyaPublication new
			         topic: self;
			         owner: anOwner.
		  self publishers add: pub ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> publisher: anOwner publishes: aContent [

	self latching ifTrue: [ 
		lastMessage := aContent.
		lastPublisher := anOwner ].

	self subscribers
		select: [ :s | s shouldReceive: aContent from: anOwner ]
		thenDo: [ :s | s receive: aContent ]
]

{ #category : #accessing }
CoyaTopic >> publishers [

	^ publishers := publishers reject: [ :p | p isNil ]
]

{ #category : #accessing }
CoyaTopic >> subscribers [

	^ subscribers := subscribers reject: [ :p | p isNil ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> subscriptionFor: anOwner [

	^ self subscribers detect: [ :p | p owner = anOwner ] ifNone: [ 
		  | sub |
		  sub := CoyaSubscription new
			         topic: self;
			         owner: anOwner.
		  self subscribers add: sub.
		  sub ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> unregister: aPublication [

	^ self publishers remove: aPublication ifAbsent: [  ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> unregisterOwner: anOwner [

	(self publishers select: [ :p | p owner = anOwner ]) do: [ :p | 
		p unregister ].
	(self subscribers select: [ :s | s owner = anOwner ]) do: [ :s | 
		s unsubscribe ]
]

{ #category : #'as yet unclassified' }
CoyaTopic >> unsubscribe: aSubscription [

	^ self subscribers remove: aSubscription
]

{ #category : #'as yet unclassified' }
CoyaTopic >> welcomeSubscriber: sub [
	(latching and: [ lastPublisher isNotNil ]) ifTrue: [ 
		(sub shouldReceive: lastMessage from: lastPublisher) ifTrue: [ 
			sub receive: lastMessage ] ]
]
