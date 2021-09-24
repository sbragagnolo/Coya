Class {
	#name : #CoyaSubscribeSlot,
	#superclass : #CoyaSlot,
	#instVars : [
		'typeFilter',
		'selector'
	],
	#category : #'Coya-Slots'
}

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> printOn: aStream [

	aStream
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name.

	aStream
		nextPutAll: ' topic: #';
		nextPutAll: topic asSymbol.
	type ifNotNil: [ 
		aStream
			nextPutAll: ' type: #';
			nextPutAll: type asSymbol ].
	selector ifNotNil: [ 
		aStream
			nextPutAll: ' selector:#';
			nextPutAll: selector ]
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> read: anInstance [

	^ (self readSubscription: anInstance) value
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> readSubscription: instance [

	| t sub |
	sub := super read: instance.
	sub ifNotNil: [ ^ sub ].
	t := instance coya findOrCreateTopic: topic.
	sub := CoyaSyncSubscription new owner: instance.
	type ifNotNil: [ sub type: (self class environment at: type) ].
	selector ifNotNil: [ 
		sub onReadSend: (Message selector: selector) to: instance ].
	sub topic: t.
	super write: sub to: instance.
	^ sub
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName selector: aSelector [
	topic := aName.
	selector := aSelector
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName type: aType [ 
	topic := aName.
	typeFilter := aType.
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName type: aType selector: aSelector [
	self topic: aName type: aType .
	selector := aSelector.
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> write: aValue to: anObject [
	^ self error: 'Read only slot'
]
