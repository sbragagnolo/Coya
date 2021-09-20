Class {
	#name : #CoyaTopicSubscriptionTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaTopicSubscriptionTests >> testTopicSubscringProducesATopic [
	coya subscribe: #example type: #Object do: [:a | a]  .
	self assert: coya topics size equals: 1
]
