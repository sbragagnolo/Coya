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

{ #category : #'as yet unclassified' }
Coya >> findOrCreateTopic: aString [

	^ self findTopic: aString ifNone: [ 
		  | t |
		  t := CoyaTopic new.
		  t name: aString.
		  topics add: t.
		  t ]
]

{ #category : #'as yet unclassified' }
Coya >> findTopic: aString [

	^ self
		  findTopic: aString
		  ifNone: [ NotFound signal: aString , ' is not a valid topic ' ]
]

{ #category : #'as yet unclassified' }
Coya >> findTopic: aString ifNone: aFullBlockClosure [

	^ topics
		  detect: [ :t | t name asLowercase = aString asLowercase ]
		  ifNone: [ aFullBlockClosure value ]
]

{ #category : #'as yet unclassified' }
Coya >> initialize [

	super initialize.
	topics := Set new
]

{ #category : #accessing }
Coya >> topics [
	^ topics
]
