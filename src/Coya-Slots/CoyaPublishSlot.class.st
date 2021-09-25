"
I am a publishing slot. 
Whatever written on me is going to be available on the system immediately. 
However when i am read i allways return the last value that has been stored on me. 
"
Class {
	#name : #CoyaPublishSlot,
	#superclass : #CoyaSlot,
	#category : #'Coya-Slots'
}

{ #category : #initialization }
CoyaPublishSlot >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #writing }
CoyaPublishSlot >> isPublishingSlot [

	^ true
]

{ #category : #writing }
CoyaPublishSlot >> read: instance [
	^ (self readTuple: instance ) second
]

{ #category : #writing }
CoyaPublishSlot >> readTuple: instance [

	| t pub |
	^ (super read: instance) ifNil: [ 
		  | tuple |
		  t := instance coya findOrCreateTopic: topic.
		  pub := CoyaPublication new owner: instance.

		  tuple := { 
			           pub.
			           nil }.
		  super write: tuple to: instance.
		  pub topic: t.
		  tuple ]
]

{ #category : #writing }
CoyaPublishSlot >> write: aContent to: anObject [

	| pubVal |
	pubVal := self readTuple: anObject.
	pubVal first publish: aContent.
	pubVal at: 2 put: aContent
]
