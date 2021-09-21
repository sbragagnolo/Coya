Class {
	#name : #CoyaSpecWidget,
	#superclass : #SpPresenter,
	#category : #'Coya-Spec'
}

{ #category : #'instance creation' }
CoyaSpecWidget class >> new [

	^ self newApplication: CoyaApplication instance 
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> coya [

	^ self application coya
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> displayStringOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self class title;
		nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> initializePrivateHooks [

	super initializePrivateHooks.
	self initializeTopics
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> initializeTopics [
	" Initialize here the Coya connections "
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> initializeWindow: aWindow [
	aWindow whenClosedDo: [ self unsubscribeAll ]
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> subscribe: aTopicName activating: aSelector [

	(self coya subscriptionOn: aTopicName for: self)
		onReadSend: (Message selector: aSelector) to: self;
		yourself
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> unsubscribeAll [

	self coya unregisterOwner: self
]
