Class {
	#name : #CoyaSpecWidgetTests,
	#superclass : #TestCase,
	#instVars : [
		'application',
		'widget',
		'window'
	],
	#category : #'Coya-Tests'
}

{ #category : #tests }
CoyaSpecWidgetTests >> setUp [

	super setUp.
	application := CoyaApplication new.
	widget := CoyaTestSpecWidget newApplication: application.
	window := widget openWithSpec
]

{ #category : #tests }
CoyaSpecWidgetTests >> tearDown [
	window  ifNotNil: [ window close ].
	super tearDown
]

{ #category : #tests }
CoyaSpecWidgetTests >> testOnWindowClosedTheWindowTopicsAndServicesFromTheWindowAreUnregistered [ 
	
	widget provide: #serviceName sending: #yourself to: self.
	widget subscribe: #topic activating: #yourself filter: CoyaFilter none.
	window close. 
	self assert: widget subscriptions size equals: 0 .
]

{ #category : #tests }
CoyaSpecWidgetTests >> testServiceIsRegisteredProperly [

	self assert: widget services size equals: 0.
	widget provide: #serviceName sending: #yourself to: self.
	self assert: widget services size equals: 1
]

{ #category : #tests }
CoyaSpecWidgetTests >> testSubcriptionIsRegisteredProperly [ 
	
	
	self assert: widget subscriptions size equals: 0 .
	widget subscribe: #topic activating: #yourself filter: CoyaFilter none.
	self assert: widget subscriptions size equals: 1.
]

{ #category : #tests }
CoyaSpecWidgetTests >> testWhenLink2EffectIsAutomatic [

	self assert: widget currentText equals: ''.
	(widget publisher: #link2 for: self) publish: 'Hi!'.
	self assert: widget currentText equals: 'Hi!'
]

{ #category : #tests }
CoyaSpecWidgetTests >> testWhenLinkOneIsSentRequiresToCallSetLink1ToGetEffect [

	(widget publisher: #link for: self) publish: 'Hi!'.
	self assert: widget currentText equals: ''.
	widget setLink1.
	self assert: widget currentText equals: 'Hi!'
]
