Class {
	#name : #CoyaPubSubSlot,
	#superclass : #CoyaSlot,
	#instVars : [
		'type',
		'selector'
	],
	#category : #'Coya-Slots'
}

{ #category : #writing }
CoyaPubSubSlot >> printOn: aStream [

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

{ #category : #writing }
CoyaPubSubSlot >> read: anObject [

	^ (self readTuple: anObject) second value
]

{ #category : #writing }
CoyaPubSubSlot >> readTuple: instance [

	| t pub sub |
	^ (super read: instance) ifNil: [ 
		  | tuple |
		  t := instance coya findOrCreateTopic: topic.
		  pub := CoyaPublication new owner: instance.
		  pub topic: t.

		  sub := CoyaSyncSubscription new owner: instance.
		  type ifNotNil: [ sub type: (self class environment at: type) ].
		  selector ifNotNil: [ 
			  sub onReadSend: (Message selector: selector) to: instance ].
		  sub topic: t.

		  tuple := { 
			           pub.
			           sub }.
		  super write: tuple to: instance.
		  tuple ]
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName selector: aSelector [
	topic := aName.
	selector := aSelector
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName type: aType [ 
	topic := aName.
	type := aType.
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName type: aType selector: aSelector [
	self topic: aName type: aType .
	selector := aSelector.
]

{ #category : #writing }
CoyaPubSubSlot >> write: aContent to: anObject [

	| pubVal |
	pubVal := super read: anObject.
	pubVal first publish: aContent.
	pubVal second privateSetValue: aContent. 
	
	
]
