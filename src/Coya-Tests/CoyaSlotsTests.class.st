Class {
	#name : #CoyaSlotsTests,
	#superclass : #TestCase,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaSlotsTests >> testCoyaPubSubSlotDoesAcceptOnlySymbols [

	self assert: (((CoyaPubSubSlot named: #name)
			  topic: #topic
			  type: #type
			  selector: #selector) isKindOf: CoyaPubSubSlot)
]

{ #category : #tests }
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

{ #category : #tests }
CoyaSlotsTests >> testCoyaPublishSlotDoesAcceptOnlySymbols [

	self assert:
		(((CoyaPublishSlot named: #name) topic: #topic) isKindOf:
			 CoyaPublishSlot)
]

{ #category : #tests }
CoyaSlotsTests >> testCoyaPublishSlotDoesNotAcceptObjectsButOnlySymbols [

	self
		should: [ (CoyaPublishSlot named: #name) topic: Object ]
		raise: Error.
	
]

{ #category : #tests }
CoyaSlotsTests >> testCoyaSubscribeSlotDoesAcceptOnlySymbols [

	self assert: (((CoyaSubscribeSlot named: #name)
			  topic: #topic
			  type: #type
			  selector: #selector) isKindOf: CoyaSubscribeSlot)
]

{ #category : #tests }
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
