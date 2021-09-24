"
Here only to put together the problematic of the publication and subcription togetehr. 
"
Class {
	#name : #CoyaTopicRelatedEntity,
	#superclass : #Object,
	#instVars : [
		'topic',
		'owner'
	],
	#category : #'Coya-Topics'
}

{ #category : #accessing }
CoyaTopicRelatedEntity >> installedInto: aTopic [

	topic ifNotNil: [ 
		topic = aTopic ifFalse: [ 
			^ self error:
				  'The Subcription / Publication has been already installed into an other topic ' ] ].
	topic := aTopic
]

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
CoyaTopicRelatedEntity >> topic: aTopic [
	self subclassResponsibility 
]
