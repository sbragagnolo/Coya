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

	^ self application coya
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
	^ t publicationFor: self ifNone: [ 
		  CoyaPublication new
			  owner: anObject;
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

	self coya unregisterOwner: self
]
