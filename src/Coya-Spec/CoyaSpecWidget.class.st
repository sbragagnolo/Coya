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
		'subscriptions',
		'services'
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

	subscriptions := OrderedCollection new.
	services := Dictionary new.
	super initialize
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> initializePrivateHooks [

	super initializePrivateHooks.
	self initializeTopicsAndServices
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> initializeTopicsAndServices [ 
	" Initialize here the Coya connections "
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> initializeWindow: aWindow [
	aWindow whenClosedDo: [ self unsubscribeAll ]
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> provide: aServiceName sending: aSymbolSelector to: anObject [

	| serv |
	serv := self coya findOrCreateService: aServiceName.
	services at: aServiceName put: (CoyaServiceProvider new
			 onRequestSend: (Message selector: aSymbolSelector) to: anObject;
			 service: serv;
			 yourself)
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> request: aServiceName argument: anArgument [
	| t |
	t := self coya findOrCreateService: aServiceName.
	^ CoyaServiceClient new
		  owner: self;
		  service: t;
		  request: anArgument ifNoneProvider: [ nil ]
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> subscribe: aTopicName activating: aSelector [

	| t |
	t := self coya findOrCreateTopic: aTopicName.
	subscriptions add: (CoyaAsyncSubscription new
			 owner: self;
			 onReadSend: (Message selector: aSelector) to: self;
			 topic: t;
			 yourself)
]

{ #category : #'as yet unclassified' }
CoyaSpecWidget >> unsubscribeAll [

	self coya unregisterOwner: self
]
