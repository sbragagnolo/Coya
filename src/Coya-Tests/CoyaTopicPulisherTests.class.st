Class {
	#name : #CoyaTopicPulisherTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaTopicPulisherTests >> testTopicPublishingProducesATopic [

	coya publish: #example type: #Object.
	self assert: coya topics size equals: 1
]
