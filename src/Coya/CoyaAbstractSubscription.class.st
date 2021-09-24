Class {
	#name : #CoyaAbstractSubscription,
	#superclass : #CoyaTopicRelatedEntity,
	#instVars : [
		'filter'
	],
	#category : #'Coya-Topics'
}

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> filter [
	^ filter
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> filter:  aFilter [

	filter := aFilter
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> initialize [

	super initialize.
	filter := CoyaFilter default.
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
	^ filter filter: aMessage
]

{ #category : #'as yet unclassified' }
CoyaAbstractSubscription >> topic: aTopic [
	aTopic installSubscription: self 
]

{ #category : #accessing }
CoyaAbstractSubscription >> unsubscribe [

	topic unsubscribe: self.
	topic := nil.
	filter := nil
]
