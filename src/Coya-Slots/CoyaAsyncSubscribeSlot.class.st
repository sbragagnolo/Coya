Class {
	#name : #CoyaAsyncSubscribeSlot,
	#superclass : #CoyaSubscribeSlot,
	#instVars : [
		'selector'
	],
	#category : #'Coya-Slots'
}

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> initialize: instance [

	| t sub |
	self error: 'Dont use this one! '.
	super initialize: instance.
	t := instance coya findOrCreateTopic: topic.
	sub := CoyaAsyncSubscription new owner: instance.
	sub onReadSend: (Message selector: selector) to: instance.
	type ifNotNil: [ sub type: (self class environment at: type) ].
	sub topic: t.
	super write: sub to: instance
]

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> printOn: aStream [

	super printOn: aStream.
	selector ifNotNil: [ 
		aStream
			nextPutAll: ' selector:#';
			nextPutAll: selector ]
]

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> read: anInstance [

	^ (super read: anInstance) value
]

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> topic: aTopic [
	self error: 'Async slot MUST receive a selector as parameter '
]

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> topic: aName selector: aSelector [

	topic := aName.
	selector := aSelector
]

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> topic: aName type: aType selector: aSelector [
	super topic: aName type: aType .
	selector := aSelector 
]

{ #category : #'meta-object-protocol' }
CoyaAsyncSubscribeSlot >> write: aValue to: anObject [
	^ self error: 'Read only slot'
]
