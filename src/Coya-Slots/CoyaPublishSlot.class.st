Class {
	#name : #CoyaPublishSlot,
	#superclass : #CoyaSlot,
	#category : #'Coya-Slots'
}

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
		  pub topic: t.
		  tuple := { pub.
			           nil }.
		  super write: tuple to: instance.
		  tuple ]
]

{ #category : #writing }
CoyaPublishSlot >> write: aContent to: anObject [

	| pubVal |
	pubVal := self readTuple: anObject.
	pubVal first publish: aContent.
	pubVal at: 2 put: aContent
]
