Class {
	#name : #CoyaTopicTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaTopicTests >> testConstraintedByCommaMessageShouldReceiveNoneMessageFromHimself [

	| pub sub variable ref |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       typeConstraint: [ :tc | tc shouldUnderstand: #, ];
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: nil.
	pub publish: nil.
	ref := 'self' asFileReference.

	self assert: variable equals: nil.
	pub publish: ref.
	self assert: variable equals: nil
]

{ #category : #tests }
CoyaTopicTests >> testConstraintedByCommaMessageTypedSubscriberReceivesOnlyThoseMessages [

	| pub sub variable ref |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: 1)
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
CoyaTopicTests >> testLatchingTopicInformsLastValueToSubcriberOnSubscription [

	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.

	pub publish: #hello.
	self assert: variable equals: nil.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: 1)
		       type: String;
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testNonTopicExistsByDefault [

	self assert: coya topics size equals: 0
]

{ #category : #tests }
CoyaTopicTests >> testNullTypedSubscriberReceivesAllMessages [

	| pub sub variable |
	pub := ((coya findOrCreateTopic: #example) publicationFor: self).
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: 1)
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals:#hello
]

{ #category : #tests }
CoyaTopicTests >> testNullTypedSubscriberReceivesNoneMessageFromHimself [

	| pub sub variable |
	pub := ((coya findOrCreateTopic: #example) publicationFor: self).
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: nil
]

{ #category : #tests }
CoyaTopicTests >> testObjectTypedSubscriberReceivesAllMessages [

	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: 1)
		       type: Object;
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testObjectTypedSubscriberReceivesNoneFromHimself [
	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       type: Object;
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals:nil
]

{ #category : #tests }
CoyaTopicTests >> testPublisherProducesPublication [

	| pub |
	pub := ((coya findOrCreateTopic: #example) publicationFor: self).

	self assert: pub class equals: CoyaPublication. 
	self assert: pub topic equals: (coya findOrCreateTopic: #example).
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberReceivesNoneFromHimself [

	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: self)
		       type: String;
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].
	pub publish: #hello.
	self assert: variable equals: nil.
	pub publish: 1.
	self assert: variable equals: nil.
	pub publish: self.
	self assert: variable equals: nil
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberReceivesOnlyStringMessages [

	| pub sub variable |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: 1)
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
CoyaTopicTests >> testSubscriberManagesErrorWithHook [

	| pub sub variable text causedBy |
	pub := (coya findOrCreateTopic: #example) publicationFor: self.
	sub := ((coya findOrCreateTopic: #example) subscriptionFor: 1)
		       type: String;
		       onErrorHook: [ :e :b | 
			       text := e messageText.
			       causedBy := b ];
		       onReadSend: (Message selector: #value:)
		       to: [ :a :b | 1 / 0 ].
	pub publish: #hello.
	self assert: variable isNil.
	self assert: text isNotNil.
	self assert: causedBy equals: #hello
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
