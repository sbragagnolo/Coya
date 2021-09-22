Class {
	#name : #CoyaSubscribeSlot,
	#superclass : #CoyaSlot,
	#instVars : [
		'type'
	],
	#category : #'Coya-Slots'
}

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> initialize: instance [

	| t sub |
	super initialize: instance.
	t := instance coya findOrCreateTopic: topic.
	sub := CoyaSyncSubscription new owner: instance.
	type ifNotNil: [ sub type: (self class environment at: type) ].
	sub topic: t.
	super write: sub to: instance
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> printOn: aStream [
	type ifNil: [ ^ super printOn: aStream ].
	aStream 
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name.
	
	aStream
		nextPutAll: ' topic: #';
		nextPutAll: topic asSymbol;
		nextPutAll: ' type: #';
		nextPutAll: type asSymbol

]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> read: anInstance [

	^ (super read: anInstance) value
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName type: aType [ 
	topic := aName.
	type := aType.
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> write: aValue to: anObject [
	^ self error: 'Read only slot'
]
