Class {
	#name : #CoyaTopicRelatedEntity,
	#superclass : #Object,
	#instVars : [
		'topic',
		'owner'
	],
	#category : #Coya
}

{ #category : #testing }
CoyaTopicRelatedEntity >> isPublication [
	^ false
]

{ #category : #testing }
CoyaTopicRelatedEntity >> isSubscription [
	^ false
]

{ #category : #accessing }
CoyaTopicRelatedEntity >> owner [
	^ owner
]

{ #category : #accessing }
CoyaTopicRelatedEntity >> owner: aCoyaTopicTests [ 
	owner := aCoyaTopicTests
]

{ #category : #accessing }
CoyaTopicRelatedEntity >> topic [
	^ topic
]

{ #category : #accessing }
CoyaTopicRelatedEntity >> topic: aCoyaTopic [ 
	topic := aCoyaTopic
]
