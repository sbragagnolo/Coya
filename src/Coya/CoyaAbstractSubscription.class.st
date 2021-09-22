Class {
	#name : #CoyaAbstractSubscription,
	#superclass : #CoyaTopicRelatedEntity,
	#instVars : [
		'typeFilter'
	],
	#category : #Coya
}

{ #category : #initialization }
CoyaAbstractSubscription >> initialize [

	super initialize.
	typeFilter := CoyaTypeFilter default.
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> installedInto: aTopic [

	super installedInto: aTopic.
	aTopic latching ifTrue: [ 
		(self shouldReceive: aTopic lastMessage from: aTopic lastPublisher) 
			ifTrue: [ self receive: aTopic lastMessage ] ]
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> isSubscription [
	^ true
]

{ #category : #accessing }
CoyaAbstractSubscription >> receive: anObject [
	self subclassResponsibility 
]

{ #category : #asserting }
CoyaAbstractSubscription >> shouldReceive: aMessage from: anOwner [

	owner = anOwner ifTrue: [ ^ false ].
	^ typeFilter filter: aMessage
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> topic: aTopic [
	aTopic installSubscription: self 
]

{ #category : #'accessing - structure variables' }
CoyaAbstractSubscription >> type: aClass [

	typeFilter := CoyaTypeFiltersClass new
		              filteringClass: aClass;
		              yourself
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> typeConstraint: aFullBlockClosure [

	typeFilter := CoyaTypeFilterConstraint new.
	aFullBlockClosure value: typeFilter
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> typeFilter [
	^ typeFilter
]

{ #category : #accessing }
CoyaAbstractSubscription >> unsubscribe [

	topic unsubscribe: self.
	topic := nil.
	typeFilter := nil
]
