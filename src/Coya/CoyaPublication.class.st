Class {
	#name : #CoyaPublication,
	#superclass : #CoyaTopicRelatedEntity,
	#category : #Coya
}

{ #category : #testing }
CoyaPublication >> isPublication [ 
	^ true
]

{ #category : #'as yet unclassified' }
CoyaPublication >> publish: aContent [

	topic publisher: owner publishes: aContent
]
