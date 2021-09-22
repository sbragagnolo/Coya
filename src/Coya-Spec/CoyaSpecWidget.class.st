"
I am a widget that understands coya methods, allowing the function of the CoyaPubSlot. I do give also access to the hook
initializeTopics 
and some convenience method. 
I ensure the un-registration of all the subcribers / pbulishers
"
Class {
	#name : #CoyaSpecWidget,
	#superclass : #SpPresenter,
	#instVars : [
		'subs'
	],
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
CoyaSpecWidget >> initialize [

	subs := OrderedCollection new.
	super initialize
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

	| t |
	t := self coya findOrCreateTopic: aTopicName.
	subs add: (CoyaAsyncSubscription new
			 owner: self;
			 onReadSend: (Message selector: aSelector) to: self;
			 topic: t;
			 yourself)
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> unsubscribeAll [

	self coya unregisterOwner: self
]
