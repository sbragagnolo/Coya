Class {
	#name : #CoyaTopicTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaTopicTests >> testFindTopicExplotesIfNone [

	self should: [ coya findTopic: #example ] raise: Error
]

{ #category : #tests }
CoyaTopicTests >> testFindTopicIfNoneBlock [

	self
		assert: (coya findTopic: #example ifNone: [ #value ])
		equals: #value
]

{ #category : #tests }
CoyaTopicTests >> testNonTopicExistsByDefault [
	self assert: coya topics size equals: 0.
]
