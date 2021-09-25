"
I am a readonly slot. 
I am not to write. 
When read i do return the last value available on the topic .
I can be configured to filter messages. 
I can be configured to send a message to my object owner when a data has been updated .
"
Class {
	#name : #CoyaSubscribeSlot,
	#superclass : #CoyaSlot,
	#instVars : [
		'typeFilter',
		'selector',
		'type'
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
			nextPutAll: type  asSymbol ].
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
	type ifNotNil: [ 
		sub filter:
			(CoyaFilter shouldBeKindOf: (self class environment at: type)) ].
	selector ifNotNil: [ 
		sub onReadSend: (Message selector: selector) to: instance ].

	super write: sub to: instance.
	sub topic: t.
	^ sub
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName selector: aSelector [
	self topic: aName.
	self assert: aSelector isSymbol description: 'Invalid selector'.
	selector := aSelector
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName type: aType [
	self topic: aName.
	self assert: aType isSymbol description: 'Invalid type name'.
	type := aType
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> topic: aName type: aType selector: aSelector [

	self topic: aName type: aType.
	self assert: aSelector isSymbol description: 'Invalid selector'.

	selector := aSelector
]

{ #category : #'meta-object-protocol' }
CoyaSubscribeSlot >> write: aValue to: anObject [
	
]
