"
I do represent a Publisher / Subscriber slot. 
What ever information set on me is going to be transmited to whatever interested counter part in the system. 
When ever i am used to read i am going to return the most fresh value on the topic 
I can be configured to filter messages.
I can be configured to send a message to my object owner when a data has been updated .

"
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


		  sub := CoyaSyncSubscription new owner: instance.
		  type ifNotNil: [ 
			  sub filter:
				  (CoyaFilter shouldBeKindOf: (self class environment at: type)) ].
		  selector ifNotNil: [ 
			  sub onReadSend: (Message selector: selector) to: instance ].


		  tuple := { 
			           pub.
			           sub }.
		  super write: tuple to: instance.
		  pub topic: t.
		  sub topic: t.

		  tuple ]
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName selector: aSelector [
	self topic: aName. 
	self assert: aSelector isSymbol description: 'Invalid selector'.
	selector := aSelector
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName type: aType [ 
	self topic: aName.
	self assert: aType isSymbol description: 'Invalid type name'.
	type := aType.
]

{ #category : #writing }
CoyaPubSubSlot >> topic: aName type: aType selector: aSelector [
	self topic: aName type: aType .
	self assert: aSelector isSymbol description: 'Invalid selector'.
	selector := aSelector.
]

{ #category : #writing }
CoyaPubSubSlot >> write: aContent to: anObject [

	| pubVal |
	pubVal :=  self readTuple: anObject.
	pubVal first publish: aContent.
	pubVal second privateSetValue: aContent. 
	
	
]
