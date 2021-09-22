Class {
	#name : #CoyaPubSubSlot,
	#superclass : #CoyaSlot,
	#instVars : [
		'type'
	],
	#category : #'Coya-Slots'
}

{ #category : #writing }
CoyaPubSubSlot >> initialize: instance [

	| t pub sub |
	super initialize: instance.
	t := instance coya findOrCreateTopic: topic.
	pub := CoyaPublication new owner: instance .
	pub topic: t.
	super initialize: instance.
	t := instance coya findOrCreateTopic: topic.
	sub := CoyaSyncSubscription new owner: self.
	type ifNotNil: [ sub type: (self class environment at: type) ].
	sub topic: t.



	super
		write: { 
				pub.
				sub }
		to: instance
]

{ #category : #writing }
CoyaPubSubSlot >> printOn: aStream [
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

{ #category : #writing }
CoyaPubSubSlot >> read: anObject [

	^ (super read: anObject) second value 
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName type: aType [ 
	topic := aName.
	type := aType.
]

{ #category : #writing }
CoyaPubSubSlot >> write: aContent to: anObject [

	| pubVal |
	pubVal := super read: anObject.
	pubVal first publish: aContent.
	
	
]
