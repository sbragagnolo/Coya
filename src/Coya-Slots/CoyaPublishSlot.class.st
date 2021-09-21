Class {
	#name : #CoyaPublishSlot,
	#superclass : #CoyaSlot,
	#category : #'Coya-Slots'
}

{ #category : #'code generation' }
CoyaPublishSlot >> emitStore: aMethodBuilder [
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

{ #category : #writing }
CoyaPublishSlot >> printOn: aStream [
	aStream 
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name.
	
	aStream
		nextPutAll: ' topic: #';
		nextPutAll: topic asSymbol

]

{ #category : #writing }
CoyaPublishSlot >> write: aContent to: anObject [
	(anObject coya publicationOn: topic for: anObject ) publish: aContent. 
	super write: aContent to: anObject
]
