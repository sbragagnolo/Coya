Class {
	#name : #CoyaSubscribeSlot,
	#superclass : #CoyaSlot,
	#instVars : [
		'type'
	],
	#category : #'Coya-Slots'
}

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
CoyaSubscribeSlot >> topic: aName type: aType [ 
	topic := aName.
	type := aType.
]
