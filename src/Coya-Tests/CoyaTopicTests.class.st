Class {
	#name : #CoyaTopicTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaTopicTests >> testConstraintedByCommaMessageTypedSubscriberReceivesOnlyThoseMessages [

	| pub sub variable ref |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       typeConstraint: [ :tc | tc shouldUnderstand: #, ];
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: #hello.
	pub publish: nil.
	ref := 'self' asFileReference.

	self assert: variable equals: #hello.
	pub publish: ref.
	self assert: variable equals: ref
]

{ #category : #tests }
CoyaTopicTests >> testFindOrCreateTopicGivesAConfiguredTopic [

	| topic |
	topic := coya findOrCreateTopic: #example.
	self assert: (topic isKindOf: CoyaTopic).
	self assert: topic name equals: #example.
	self assert: topic latching 
]

{ #category : #tests }
CoyaTopicTests >> testFindOrCreateTopicGivesAllwaysTheSameTopic [

	| topic topic2 |
	topic := coya findOrCreateTopic: #example.
	topic2 :=  coya findOrCreateTopic: #example.
	self assert: topic equals: topic2 
]

{ #category : #tests }
CoyaTopicTests >> testFindTopicExplotesIfNone [

	self should: [ coya findTopic: #example ] raise: NotFound
]

{ #category : #tests }
CoyaTopicTests >> testFindTopicIfNoneBlock [

	self
		assert: (coya findTopic: #example ifNone: [ #value ])
		equals: #value
]

{ #category : #tests }
CoyaTopicTests >> testNonTopicExistsByDefault [

	self assert: coya topics size equals: 0
]

{ #category : #tests }
CoyaTopicTests >> testNullTypedSubscriberReceivesAllMessages [

	| pub sub variable |
	pub := ((coya findOrCreateTopic: #example) publicationFor: self).
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testObjectTypedSubscriberReceivesAllMessages [

	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       type: Object;
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testPublisherProducesPublication [

	| pub |
	pub := ((coya findOrCreateTopic: #example) publicationFor: self).

	self assert: pub class equals: CoyaPublication. 
	self assert: pub topic equals: (coya findOrCreateTopic: #example).
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberReceivesOnlyStringMessages [

	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       type: String;
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: #hello.
	pub publish: 1.
	self assert: variable equals: #hello.
	pub publish: self.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testTopicAsyncSubscringProducesAnAsyncSubcripion [

	| sub |
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		     onReadSend: (Message selector: #lala:)
		     to: self.

	self assert: sub isSubscription. 
	self assert: sub owner equals: self.
	self assert: sub topic equals: (coya findTopic: #example).
	self assert: sub typeFilter isNoneFilter
]

{ #category : #tests }
CoyaTopicTests >> testTopicTypedAsyncSubscringProducesAnAsyncSubcripion [

	| sub |
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
			  type: Object;
		     onReadSend: (Message selector: #lala:)
		     to: self.

	self assert: sub isSubscription.
	self assert: sub owner equals: self.
	self assert: sub topic equals: (coya findTopic: #example).
	self assert: sub typeFilter isClassFilter
]

{ #category : #tests }
CoyaTopicTests >> testTopicTypedFilterAsyncSubscringProducesAnAsyncSubcripion [

	| sub |
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       typeConstraint: [ :tc | 
			       tc
				       shouldUnderstand: #thisMessage:;
				       shouldUnderstand: #otherMessage ];
		       onReadSend: (Message selector: #lala:) to: self.

	self assert: sub isSubscription. 
	self assert: sub owner equals: self.
	self assert: sub topic equals: (coya findTopic: #example).
	self assert: sub typeFilter isTypeConstraint
]
