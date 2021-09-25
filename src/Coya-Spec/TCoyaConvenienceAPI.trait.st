"
Provides a convenient API, holding the proper objects. 
It requires the implementation of a coya method that returns a Coya instance. 
"
Trait {
	#name : #TCoyaConvenienceAPI,
	#instVars : [
		'services',
		'subscriptions'
	],
	#category : #'Coya-Spec'
}

{ #category : #initialization }
TCoyaConvenienceAPI >> coya [

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> provide: aServiceName sending: aSymbolSelector to: anObject [

	| sv |
	sv := self coya findOrCreateService: aServiceName.
	self services at: aServiceName put: (CoyaServiceProvider new
			 onRequestSend: (Message selector: aSymbolSelector) to: anObject;
			 service: sv;
			 yourself)
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> publisher: aTopicName for: anObject [

	| t |
	t := self coya findOrCreateTopic: aTopicName.
	^ t publicationFor: anObject ifNone: [ 
		  CoyaPublication new
			  owner: anObject;
			  topic: t;
			  yourself ]
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> request: aServiceName [

	^ self request: aServiceName argument: nil
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> request: aServiceName argument: anArgument [
	| t |
	t := self coya findOrCreateService: aServiceName.
	^ CoyaServiceClient new
		  owner: self;
		  service: t;
		  request: anArgument ifNoneProvider: [ nil ]
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> services [
	^ services ifNil: [ services := Dictionary new ]
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> subscribe: aTopicName activating: aSelector [

	^ self subscribe: aTopicName activating: aSelector filter: CoyaFilter none
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> subscribe: aTopicName activating: aSelector filter: aCoyaFilter [

	| t |
	t := self coya findOrCreateTopic: aTopicName.
	^ self subscriptions add: (CoyaAsyncSubscription new
				filter: aCoyaFilter;
			   owner: self;
			   onReadSend: (Message selector: aSelector) to: self;
			   topic: t;
			   yourself)
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> subscriptions [
	^ subscriptions ifNil: [ subscriptions := OrderedCollection  new ]
]

{ #category : #'as yet unclassified' }
TCoyaConvenienceAPI >> unsubscribeAll [

	self coya unregisterOwner: self.
	subscriptions ifNotNil: [ subscriptions removeAll ].
	services ifNotNil: [ services removeAll ]
]
