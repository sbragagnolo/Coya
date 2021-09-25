"
CoyaSlot allows the usage of topics by name. 
It uses a BaseSlot to store configuration and value.
emitStore: / emitValue: are redefined to ensure the sole usage of #read: and #write:to:.

"
Class {
	#name : #CoyaSlot,
	#superclass : #PropertySlot,
	#instVars : [
		'topic'
	],
	#category : #'Coya-Slots'
}

{ #category : #'code generation' }
CoyaSlot >> emitStore: aMethodBuilder [
	"generate bytecode to call the reflective write method of the Slot"
	| tempName |
	tempName := '0slotTempForStackManipulation'.  
	aMethodBuilder
		addTemp: tempName;
		storeTemp: tempName;
		popTop;
		pushReceiver;
		pushLiteral: self;
		pushTemp: tempName;
		send: #writeSlot:value:
]

{ #category : #'meta-object-protocol' }
CoyaSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read:
]

{ #category : #writing }
CoyaSlot >> printOn: aStream [

	aStream
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name.

	aStream
		nextPutAll: ' topic: #';
		nextPutAll: (topic ifNil: [ #nil ] ifNotNil: [ :t | t asSymbol ])
]

{ #category : #writing }
CoyaSlot >> topic: aName [
	topic := aName 
]

{ #category : #writing }
CoyaSlot >> wantsInitialization [ 
	^ true 
]
