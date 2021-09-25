Class {
	#name : #CoyaSlotsDummy,
	#superclass : #Object,
	#instVars : [
		'#pub => CoyaPublishSlot topic: #pub',
		'#pubSub => CoyaPubSubSlot topic: #pubSub',
		'#sub => CoyaSubscribeSlot topic: #sub'
	],
	#category : #'Coya-Tests'
}

{ #category : #initialization }
CoyaSlotsDummy >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]
