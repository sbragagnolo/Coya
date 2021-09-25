Class {
	#name : #CoyaTopicTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaTopicTests >> testConstraintedByCommaMessageShouldReceiveNoneMessageFromHimself [

	| topic pub sub variable ref |

	topic := coya findOrCreateTopic: #example.

	pub := CoyaPublication new
		       owner: self;
		       topic: topic.
	sub := CoyaAsyncSubscription new
				 owner: self ;
		       filter: (CoyaFilter shouldUnderstand: #,);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.


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

	| topic pub sub variable ref |
	topic := coya findOrCreateTopic: #example.

	pub := CoyaPublication new
		       owner: self;
		       topic: topic.
	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldUnderstand: #,);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.

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

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.
	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldUnderstand: #,);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ].




	pub publish: #hello.
	self assert: variable equals: nil.

	sub topic: topic.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testNonTopicExistsByDefault [

	self assert: coya topics size equals: 0
]

{ #category : #tests }
CoyaTopicTests >> testNullTypedSubscriberReceivesAllMessages [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldUnderstand: #,);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.

	pub publish: #hello.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testNullTypedSubscriberReceivesNoneMessageFromHimself [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: self;
		       filter: (CoyaFilter shouldUnderstand: #,);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.

	pub publish: #hello.
	self assert: variable equals: nil
]

{ #category : #tests }
CoyaTopicTests >> testObjectTypedSubscriberReceivesAllMessages [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldBeKindOf: Object);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.

	pub publish: #hello.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testObjectTypedSubscriberReceivesNoneFromHimself [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: self;
		       filter: (CoyaFilter shouldBeKindOf: Object);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.
	pub publish: #hello.
	self assert: variable equals: nil
]

{ #category : #tests }
CoyaTopicTests >> testPublisherAutorelease [
	

	| topic pub |
	topic := coya findOrCreateTopic: #example.

	pub := CoyaPublication new
		       owner: self;
		       topic: topic.
	self assert: (topic publicationFor: self) equals: pub. 
	pub := nil. 
	Smalltalk garbageCollect .
	self should: [ topic publicationFor: self ] raise: Error.
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberPublishProducesErrorAfterUnregister [


	| pub sub variable topic |
	
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.
		
	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldBeKindOf: String);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.
	pub publish: #hello.
	self assert: variable equals: #hello.
	pub publish: #hello2.
	self assert: variable equals: #hello2.

	pub unregister.
	self should: [ pub publish: #hello ] raise: Error
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberReceivesNoneAfterUnsubscribe [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldBeKindOf: String);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.
	pub publish: #hello.
	self assert: variable equals: #hello.
	pub publish: #hello2.
	self assert: variable equals: #hello2.
	sub unsubscribe.
	pub publish: #hello.
	self assert: variable equals: #hello2
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberReceivesNoneFromHimself [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: self;
		       filter: (CoyaFilter shouldBeKindOf: String);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.
	pub publish: #hello.
	self assert: variable equals: nil.
	pub publish: 1.
	self assert: variable equals: nil.
	pub publish: self.
	self assert: variable equals: nil
]

{ #category : #tests }
CoyaTopicTests >> testStringTypedSubscriberReceivesOnlyStringMessages [

	| pub sub variable topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldBeKindOf: String);
		       onReadSend: (Message selector: #value:)
		       to: [ :a | variable := a ];
		       topic: topic.
	pub publish: #hello.
	self assert: variable equals: #hello.
	pub publish: 1.
	self assert: variable equals: #hello.
	pub publish: self.
	self assert: variable equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testSubscriberManagesErrorWithHook [

	| pub sub text causedBy topic |
	topic := coya findOrCreateTopic: #example.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.

	sub := CoyaAsyncSubscription new
		       owner: 1;
		       filter: (CoyaFilter shouldBeKindOf: String);
		       onErrorHook: [ :e :b | 
			       text := e messageText.
			       causedBy := b ];
		       onReadSend: (Message selector: #value:)
		       to: [ :a :b | 1 / 0 ];
		       topic: topic.


	pub publish: #hello.
	self assert: text isNotNil.
	self assert: causedBy equals: #hello
]

{ #category : #tests }
CoyaTopicTests >> testSubscriptionAutorelease [
	

	| topic sub |
	topic := coya findOrCreateTopic: #example.

	sub := CoyaAsyncSubscription new
		       owner: self;
		       topic: topic.
	self assert: (topic subscriptionFor: self) equals: sub. 
	sub := nil. 
	 Smalltalk garbageCollect  .
	self should: [ topic subscriptionFor: self ] raise: Error.
]

{ #category : #tests }
CoyaTopicTests >> testTopicAsyncSubscringProducesAnAsyncSubcripion [

	| sub |
	sub := CoyaAsyncSubscription new
		       owner: self ;
		       onReadSend: (Message selector: #value:) to: [ :a :b |  ];
		       yourself.

	self assert: sub isSubscription.
	self assert: sub owner equals: self.
]

{ #category : #tests }
CoyaTopicTests >> testTopicCannotBeChangedPublisher [

	| topic topic2 pub  |
	topic := coya findOrCreateTopic: #example.

	topic2 := coya findOrCreateTopic: #example2.
	pub := CoyaPublication new
		       owner: self;
		       topic: topic.
		
	self assert: pub topic equals: topic. 
	self should: [ pub topic: topic2 ] raise: Error.
	self assert: pub topic equals: topic. 
]

{ #category : #tests }
CoyaTopicTests >> testTopicCannotBeChangedSubscriber [

	| topic topic2 sub |
	topic := coya findOrCreateTopic: #example.

	topic2 := coya findOrCreateTopic: #example2.
	sub := CoyaAsyncSubscription new
		       owner: self;
		       filter: (CoyaFilter shouldUnderstand: #,);
		       onReadSend: (Message selector: #value:) to: [ :a |  ];
		       topic: topic.


	self assert: sub topic equals: topic.
	self should: [ sub topic: topic2 ] raise: Error.
	self assert: sub topic equals: topic
]

{ #category : #tests }
CoyaTopicTests >> testTopicTypedAsyncSubscringProducesAnAsyncSubcripion [

	| sub |
	sub := CoyaAsyncSubscription new
		       owner: self;
		       filter: (CoyaFilter shouldBeKindOf: Object);
		       onReadSend: (Message selector: #value:) to: [ :a :b |  ];
		       yourself.



	self assert: sub isSubscription.
	self assert: sub owner equals: self.

]

{ #category : #tests }
CoyaTopicTests >> testTopicTypedFilterAsyncSubscringProducesAnAsyncSubcripion [

	| sub |
	sub := CoyaAsyncSubscription new
		       owner: self;
		       filter:
			       (CoyaFilter shouldUnderstandAll:
					        { #thisMessage:. #otherMessage });
		       onReadSend: (Message selector: #value:) to: [ :a :b |  ];
		       yourself.

	self assert: sub isSubscription.
	self assert: sub owner equals: self
]
