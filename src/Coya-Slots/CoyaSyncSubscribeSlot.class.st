Class {
	#name : #CoyaSyncSubscribeSlot,
	#superclass : #CoyaSubscribeSlot,
	#category : #'Coya-Slots'
}

{ #category : #'meta-object-protocol' }
CoyaSyncSubscribeSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read:
]

{ #category : #'meta-object-protocol' }
CoyaSyncSubscribeSlot >> initialize: instance [

	| t sub |
	
	t := instance coya findOrCreateTopic: topic.
	sub := CoyaSyncSubscription new owner: instance.
	type ifNotNil: [ sub type: (self class environment at: type) ].
	sub topic: t.
	super write: sub to: instance
]

{ #category : #'meta-object-protocol' }
CoyaSyncSubscribeSlot >> read: anInstance [

	^ (super read: anInstance) value
]

{ #category : #'meta-object-protocol' }
CoyaSyncSubscribeSlot >> write: aValue to: anObject [
	^ self error: 'Read only slot'
]
