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
	#category : #'Coya-Topics'
}

{ #category : #configuration }
CoyaTopic >> beLatching [
	latching := true. 
]

{ #category : #configuration }
CoyaTopic >> beNotLatching [
	latching := false. 
]

{ #category : #initialization }
CoyaTopic >> initialize [

	super initialize.
	self beLatching.
	publishers := WeakOrderedCollection new.
	subscribers := WeakOrderedCollection new.
]

{ #category : #install }
CoyaTopic >> installPublisher: aPublisher [

	^ self publishers
		  detect: [ :p | p owner = aPublisher owner ]
		  ifFound: [ :a | 
		  self error: 'Publisher is already installed for this owner' ]
		  ifNone: [ 
			  self publishers add: aPublisher.
			  aPublisher installedInto: self ]
]

{ #category : #install }
CoyaTopic >> installSubscription: aSubscription [

	^ self subscribers
		  detect: [ :p | p owner = aSubscription owner ]
		  ifFound: [ :a | 
		  self error: 'Subscription is already installed for this owner' ]
		  ifNone: [ 
			  self subscribers add: aSubscription.
			  aSubscription installedInto: self ]
]

{ #category : #accessing }
CoyaTopic >> lastMessage [
	^ lastMessage
]

{ #category : #accessing }
CoyaTopic >> lastPublisher [
	^ lastPublisher
]

{ #category : #accessing }
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

{ #category : #accessing }
CoyaTopic >> publicationFor: anOwner [

	^ self
		  publicationFor: [ :p | p owner = anOwner ]
		  ifNone: [ self error: 'NonPublisher' ]
]

{ #category : #accessing }
CoyaTopic >> publicationFor: anOwner ifNone: aBlock [

	^ self publishers detect: [ :p | p owner = anOwner ] ifNone: aBlock
]

{ #category : #publishing }
CoyaTopic >> publisher: anOwner publishes: aContent [

	self latching ifTrue: [ 
		lastMessage := aContent.
		lastPublisher := anOwner ].

	self subscribers
		select: [ :s | s shouldReceive: aContent from: anOwner ]
		thenDo: [ :s | s receive: aContent from: anOwner ]
]

{ #category : #accessing }
CoyaTopic >> publishers [

	^ publishers := publishers reject: [ :p | p isNil ]
]

{ #category : #accessing }
CoyaTopic >> subscribers [

	^ subscribers := subscribers reject: [ :p | p isNil ]
]

{ #category : #accessing }
CoyaTopic >> subscriptionFor: anOwner [

	^ self
		  subscriptionFor: anOwner
		  ifNone: [ self error: 'Non subscription found' ]
]

{ #category : #accessing }
CoyaTopic >> subscriptionFor: anOwner ifNone: aBlock [

	^ self subscribers detect: [ :p | p owner = anOwner ] ifNone: aBlock
]

{ #category : #register }
CoyaTopic >> unregister: aPublication [

	^ self publishers remove: aPublication ifAbsent: [  ]
]

{ #category : #register }
CoyaTopic >> unregisterOwner: anOwner [

	(self publishers select: [ :p | p owner = anOwner ]) do: [ :p | 
		p unregister ].
	(self subscribers select: [ :s | s owner = anOwner ]) do: [ :s | 
		s unsubscribe ]
]

{ #category : #register }
CoyaTopic >> unsubscribe: aSubscription [

	^ self subscribers remove: aSubscription
]
