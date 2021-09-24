Class {
	#name : #CoyaSyncSubscription,
	#superclass : #CoyaAsyncSubscription,
	#instVars : [
		'value'
	],
	#category : #Coya
}

{ #category : #accessing }
CoyaSyncSubscription >> privateSetValue: aValue [
	value := aValue.
]

{ #category : #accessing }
CoyaSyncSubscription >> receive: anObject [
	value := anObject .
	super receive: anObject.
]

{ #category : #accessing }
CoyaSyncSubscription >> unsubscribe [

	super unsubscribe.
	value := nil
]

{ #category : #accessing }
CoyaSyncSubscription >> value [
	^ value
]
