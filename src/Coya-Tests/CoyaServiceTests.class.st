Class {
	#name : #CoyaServiceTests,
	#superclass : #CoyaTests,
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaServiceTests >> testFindOrCreateServiceReturnsAlwaysTheSameService [

	| service service2 |
	service := coya findOrCreateService: #getItDone.
	service2 := coya findOrCreateService: #getItDone.
	self assert: service equals: service2
]

{ #category : #tests }
CoyaServiceTests >> testServiceAdmitsSingleProvider [

	| service provider provider2 var |
	var := false.
	service := coya findOrCreateService: #getItDone.
	provider := CoyaServiceProvider new
		            onRequestSend: (Message selector: #value:)
		            to: [ :request | 1 ];
		            service: service;
		            owner: self.
	provider2 := CoyaServiceProvider new
		             onRequestSend: (Message selector: #value:)
		             to: [ :request | 1 ];
		             owner: self.
	self should: [ provider2 service: service ] raise: TooMuchProviders
]

{ #category : #tests }
CoyaServiceTests >> testServiceExecutorGetsExceptionWhenNoneProviderIsAvailable [

	| service executor |
	service := coya findOrCreateService: #getItDone.
	executor := CoyaServiceClient new
		            service: service;
		            owner: self.
	self should: [ executor request: 1 ] raise: NoneProvider
]

{ #category : #tests }
CoyaServiceTests >> testServiceExecutorInstanceIsAlwaysDifferent [

	| service executors |
	service := coya findOrCreateService: #getItDone.
	executors := (1 to: 10 ) collect: [: i | CoyaServiceClient new
		            service: service;
		            owner: 1.].

	self assert: executors size equals: 10 .
]

{ #category : #tests }
CoyaServiceTests >> testServiceExecutorWhenNoneProviderIsAvailableIfNoneProviderBlockExecuted [

	| service executor var |
	var := false.
	service := coya findOrCreateService: #getItDone.
	executor := CoyaServiceClient new
		            service: service;
		            owner: self.
	executor request: 1 ifNoneProvider: [ var := true ].
	self assert: var
]

{ #category : #tests }
CoyaServiceTests >> testServicesProviderShouldRespondToExecutor [

	| service provider executor var param |
	service := coya findOrCreateService: #getItDone.
	provider := CoyaServiceProvider new
		            onRequestSend: (Message selector: #value:value:)
		            to: [ :request :interested | 
			            param := request.
			            var := interested.
			            42 ];
		            service: service;
		            owner: self.
	executor := CoyaServiceClient new
		            service: service;
		            owner: self.
	self assert: (executor request: 10) equals: 42.
	self assert: param equals: 10.
	self assert: var equals: self
]

{ #category : #tests }
CoyaServiceTests >> testWhenFindingUnexistantServiceExecutesBlock [

	| var |
	var := false. 
	coya findService: #getItDone ifNone: [ var := true ].
	self assert: var
]

{ #category : #tests }
CoyaServiceTests >> testWhenFindingUnexistantServiceExplodes [

	self should: [ coya findService: #getItDone ] raise: NotFound
]
