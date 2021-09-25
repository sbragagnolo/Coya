Class {
	#name : #CoyaSlotsTests,
	#superclass : #TestCase,
	#instVars : [
		'coya'
	],
	#category : #'Coya-Tests'
}

{ #category : #'configuration test' }
CoyaSlotsTests >> coya [ 	
	^ coya ifNil: [ coya := Coya new  ]
]

{ #category : #initialization }
CoyaSlotsTests >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'configuration test' }
CoyaSlotsTests >> testCoyaPubSubSlotDoesAcceptOnlySymbols [

	self assert: (((CoyaPubSubSlot named: #name)
			  topic: #topic
			  type: #type
			  selector: #selector) isKindOf: CoyaPubSubSlot)
]

{ #category : #'configuration test' }
CoyaSlotsTests >> testCoyaPubSubSlotDoesNotAcceptObjectsButOnlySymbols [

	self
		should: [ (CoyaPubSubSlot named: #name) topic: Object ]
		raise: Error.
	self
		should: [ (CoyaPubSubSlot named: #name) topic: #topic selector: Object ]
		raise: Error.
	self
		should: [ (CoyaPubSubSlot named: #name) topic: #topic type: Object ]
		raise: Error.
		
	self
		should: [ (CoyaPubSubSlot named: #name) topic: #topic type: Object selector: Object ]
		raise: Error.
	self
		should: [ (CoyaPubSubSlot named: #name) topic: #topic type: #Object selector: Object ]
		raise: Error.
	self
		should: [ (CoyaPubSubSlot named: #name) topic: #topic type: Object selector: #Object ]
		raise: Error





]

{ #category : #'read real info' }
CoyaSlotsTests >> testCoyaPubSubSlotReadTupleReturnsPublisherAndValue [

	| slot tupleAttached |
	slot := (CoyaPubSubSlot named: #name) topic: #topic.
	slot installingIn: self class.
	tupleAttached := slot readTuple: self.
	self assert: (tupleAttached second isKindOf: CoyaSyncSubscription).
	self assert: (tupleAttached first isKindOf: CoyaPublication)
]

{ #category : #'configuration test' }
CoyaSlotsTests >> testCoyaPublishSlotDoesAcceptOnlySymbols [

	self assert:
		(((CoyaPublishSlot named: #name) topic: #topic) isKindOf:
			 CoyaPublishSlot)
]

{ #category : #'configuration test' }
CoyaSlotsTests >> testCoyaPublishSlotDoesNotAcceptObjectsButOnlySymbols [

	self
		should: [ (CoyaPublishSlot named: #name) topic: Object ]
		raise: Error.
	
]

{ #category : #'read real info' }
CoyaSlotsTests >> testCoyaPublishSlotReadTupleReturnsPublisherAndValue [

	| slot tupleAttached |
	slot := (CoyaPublishSlot named: #name) topic: #topic.
	slot installingIn: self class .
	tupleAttached := slot readTuple: self.
	self assert: tupleAttached second isNil.
	self assert: (tupleAttached first isKindOf: CoyaPublication)
]

{ #category : #'read real info' }
CoyaSlotsTests >> testCoyaPublishSlotStoresOnlyOnePublication [

	| slot tupleAttached |
	slot := (CoyaPublishSlot named: #name) topic: #topic.
	slot installingIn: self class .
	self assert: _propertyBaseSlot size equals: 0.
	tupleAttached := slot readTuple: self.
	self assert: _propertyBaseSlot size equals: 1
]

{ #category : #'configuration test' }
CoyaSlotsTests >> testCoyaSubscribeSlotDoesAcceptOnlySymbols [

	self assert: (((CoyaSubscribeSlot named: #name)
			  topic: #topic
			  type: #type
			  selector: #selector) isKindOf: CoyaSubscribeSlot)
]

{ #category : #'configuration test' }
CoyaSlotsTests >> testCoyaSubscribeSlotDoesNotAcceptObjectsButOnlySymbols [

	self
		should: [ (CoyaSubscribeSlot named: #name) topic: Object ]
		raise: Error.
	self
		should: [ (CoyaSubscribeSlot named: #name) topic: #topic selector: Object ]
		raise: Error.
	self
		should: [ (CoyaSubscribeSlot named: #name) topic: #topic type: Object ]
		raise: Error.
		
	self
		should: [ (CoyaSubscribeSlot named: #name) topic: #topic type: Object selector: Object ]
		raise: Error.
	self
		should: [ (CoyaSubscribeSlot named: #name) topic: #topic type: #Object selector: Object ]
		raise: Error.
	self
		should: [ (CoyaSubscribeSlot named: #name) topic: #topic type: Object selector: #Object ]
		raise: Error





]

{ #category : #'read real info' }
CoyaSlotsTests >> testCoyaSubscribeSlottReadTupleReturnsPublisherAndValue [

	| slot sub |
	slot := (CoyaSubscribeSlot named: #name) topic: #topic.
	slot installingIn: self class.
	sub := slot readSubscription: self.
	self assert: (sub isKindOf: CoyaSyncSubscription)
]

{ #category : #'read real info' }
CoyaSlotsTests >> testInstallASecondCoyaPubSubSlotSlotOfSameRoleSameTopicProducesError [

	| slot  |
	slot := (CoyaPubSubSlot named: #name) topic: #pubSub.
	
	self
		should: [ slot installingIn: CoyaSlotsDummy. ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'configuration collision test' }
CoyaSlotsTests >> testInstallASecondCoyaPubSubSlot_CoyaPublishSlotSlotOfSameRoleSameTopicProducesError [

	| slot  |
	slot := (CoyaPubSubSlot named: #name) topic: #pub.
	
	self
		should: [ slot installingIn: CoyaSlotsDummy. ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'configuration collision test' }
CoyaSlotsTests >> testInstallASecondCoyaPublishSlot_CoyaPubSubSlotSlotOfSameRoleSameTopicProducesError [

	| slot  |
	slot := (CoyaPublishSlot named: #name) topic: #pubSub.
	
	self
		should: [ slot installingIn: CoyaSlotsDummy. ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'configuration collision test' }
CoyaSlotsTests >> testInstallASecondCoyaPublishSlot_CoyaPublishSlotSlotOfSameRoleSameTopicProducesError [

	| slot  |
	slot := (CoyaPublishSlot named: #name) topic: #pub.
	
	self
		should: [ slot installingIn: CoyaSlotsDummy. ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'configuration collision test' }
CoyaSlotsTests >> testInstallASecondCoyaSubscribeSlot_CoyaPubSubSlotSlotOfSameRoleSameTopicProducesError [

	| slot |
	slot := (CoyaPubSubSlot named: #name) topic: #sub.

	self
		should: [ slot installingIn: CoyaSlotsDummy ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'configuration collision test' }
CoyaSlotsTests >> testInstallASecondCoyaSubscribeSlot_CoyaSubscribeSlotSlotOfSameRoleSameTopicProducesError [

	| slot |
	slot := (CoyaSubscribeSlot named: #name) topic: #sub.

	self
		should: [ slot installingIn: CoyaSlotsDummy ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'read real info' }
CoyaSlotsTests >> testInstallASecondSlotOfSameRoleSameTopicProducesError [

	| slot  |
	slot := (CoyaPubSubSlot named: #name) topic: #pub.
	
	self
		should: [ slot installingIn: CoyaSlotsDummy. ]
		raise: DuplicatedSlotTopicAndKind
]

{ #category : #'read real info' }
CoyaSlotsTests >> testTwoCoyaPubSubSlotStoresTwoPublications [

	| slot slot2 tupleAttached |
	slot := (CoyaPubSubSlot named: #name) topic: #topic.
	slot2 := (CoyaPubSubSlot named: #name2) topic: #otherTopic.
	slot installingIn: self class.
	slot2 installingIn: self class.
	self assert: _propertyBaseSlot size equals: 0.
	tupleAttached := slot readTuple: self.
	self assert: _propertyBaseSlot size equals: 1.
	self deny: tupleAttached equals: (slot2 readTuple: self).
	self assert: _propertyBaseSlot size equals: 2
]

{ #category : #'read real info' }
CoyaSlotsTests >> testTwoCoyaPublishSlotStoresTwoPublications [

	| slot slot2 tupleAttached |
	slot := (CoyaPublishSlot named: #name) topic: #topic.
	slot2 := (CoyaPublishSlot named: #name2) topic: #otherTopic.
	slot installingIn: self class.
	slot2 installingIn: self class.
	self assert: _propertyBaseSlot size equals: 0.
	tupleAttached := slot readTuple: self.
	self assert: _propertyBaseSlot size equals: 1.
	self deny: tupleAttached equals: (slot2 readTuple: self).
	self assert: _propertyBaseSlot size equals: 2
]

{ #category : #'read real info' }
CoyaSlotsTests >> testTwoCoyaSubscribeSlotStoresTwoSubscriptions [

	| slot slot2 tupleAttached |
	slot := (CoyaSubscribeSlot named: #name) topic: #topic.
	slot2 := (CoyaSubscribeSlot named: #name2) topic: #otherTopic.
	slot installingIn: self class.
	slot2 installingIn: self class.
	self assert: _propertyBaseSlot size equals: 0.
	tupleAttached := slot readSubscription: self.
	self assert: _propertyBaseSlot size equals: 1.
	self deny: tupleAttached equals: (slot2 readSubscription: self).
	self assert: _propertyBaseSlot size equals: 2
]
