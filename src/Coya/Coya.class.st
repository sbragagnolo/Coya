"
I am an entry point to Coya. 
"
Class {
	#name : #Coya,
	#superclass : #Object,
	#instVars : [
		'topics'
	],
	#category : #Coya
}

{ #category : #'Low API' }
Coya >> findOrCreateTopic: aString [

	^ self findTopic: aString ifNone: [ 
		  | t |
		  t := CoyaTopic new.
		  t name: aString.
		  topics add: t.
		  t ]
]

{ #category : #'Low API' }
Coya >> findTopic: aString [

	^ self
		  findTopic: aString
		  ifNone: [ NotFound signal: aString , ' is not a valid topic ' ]
]

{ #category : #'Low API' }
Coya >> findTopic: aString ifNone: aFullBlockClosure [

	^ topics
		  detect: [ :t | t name asLowercase = aString asLowercase ]
		  ifNone: [ aFullBlockClosure value ]
]

{ #category : #initialization }
Coya >> initialize [

	super initialize.
	topics := Set new
]

{ #category : #'Convenience API' }
Coya >> publicationOn: aTopicName for: anOwner [

	^ (self findOrCreateTopic: aTopicName) publicationFor: anOwner
]

{ #category : #'Convenience API' }
Coya >> subscriptionOn: aTopicName for: anOwner [

	^ (self findOrCreateTopic: aTopicName) subscriptionFor: anOwner
]

{ #category : #'Convenience API' }
Coya >> subscriptionOn: aTopicName for: anOwner onRead: anOnRead onError: anOnError [

	^ ((self findOrCreateTopic: aTopicName) subscriptionFor: anOwner)
		  onErrorHook: anOnError;
		  onReadSend: anOnRead;
		  yourself
]

{ #category : #'Low API' }
Coya >> topics [ 
	^ topics 
]

{ #category : #'Low API' }
Coya >> unregisterOwner: anObject [

	topics do: [ :t | t unregisterOwner: anObject ]
]
