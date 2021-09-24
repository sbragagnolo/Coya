"
I am an entry point to Coya. 
"
Class {
	#name : #Coya,
	#superclass : #Object,
	#instVars : [
		'topics',
		'services'
	],
	#category : #Coya
}

{ #category : #'as yet unclassified' }
Coya >> findOrCreateService: aString [

	^ services at: aString ifAbsentPut: [ 
		  CoyaService new
			  name: aString;
			  yourself ]
]

{ #category : #'Low API' }
Coya >> findOrCreateTopic: aString [

	^ self findTopic: aString ifNone: [ 
		  | t |
		  t := CoyaTopic new.
		  t name: aString.
		  topics add: t.
		  t ]
]

{ #category : #accessing }
Coya >> findService: aString [

	^ self
		  findService: aString
		  ifNone: [ 
		  NotFound signal: aString , ' is not a valid service name ' ]
]

{ #category : #'as yet unclassified' }
Coya >> findService: aString ifNone: aFullBlockClosure [

	^ services at: aString ifAbsent: [ aFullBlockClosure value ]
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
	topics := Set new.
	services := Dictionary new. 
]

{ #category : #'Convenience API' }
Coya >> publicationOn: aTopicName for: anOwner [

	^ (self findOrCreateTopic: aTopicName) publicationFor: anOwner
]

{ #category : #'Convenience API' }
Coya >> subscriptionOn: aTopicName for: anOwner [

	^ (self findOrCreateTopic: aTopicName) subscriptionFor: anOwner
]

{ #category : #'Low API' }
Coya >> topics [ 
	^ topics 
]

{ #category : #'Low API' }
Coya >> unregisterOwner: anObject [

	topics do: [ :t | t unregisterOwner: anObject ]
]
