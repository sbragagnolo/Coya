"
I represent a publication. I am a writting end of a topic. Belong to one speficic owner 
"
Class {
	#name : #CoyaPublication,
	#superclass : #CoyaTopicRelatedEntity,
	#category : #'Coya-Topics'
}

{ #category : #testing }
CoyaPublication >> isPublication [ 
	^ true
]

{ #category : #'as yet unclassified' }
CoyaPublication >> publish: aContent [

	topic publisher: owner publishes: aContent
]

{ #category : #'as yet unclassified' }
CoyaPublication >> topic: aTopic [

	aTopic installPublisher: self
]

{ #category : #'as yet unclassified' }
CoyaPublication >> unregister [
	topic unregister: self.
	topic := nil. 
]
