Class {
	#name : #CoyaPublishSlot,
	#superclass : #CoyaSlot,
	#category : #'Coya-Slots'
}

{ #category : #writing }
CoyaPublishSlot >> initialize: instance [

	| t pub |
	super initialize: instance.
	t := instance coya findOrCreateTopic: topic.
	pub := CoyaPublication new owner: self.
	pub topic: t.
	super
		write: { 
				pub.
				nil }
		to: instance
]

{ #category : #writing }
CoyaPublishSlot >> read: anObject [

	^ (super read: anObject) second
]

{ #category : #writing }
CoyaPublishSlot >> write: aContent to: anObject [

	| pubVal |
	pubVal := super read: anObject.
	pubVal first publish: aContent.
	pubVal at: 2 put: anObject.
	
]
