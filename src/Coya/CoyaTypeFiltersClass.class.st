"
I filter the message with given class 
"
Class {
	#name : #CoyaTypeFiltersClass,
	#superclass : #CoyaTypeFilter,
	#instVars : [
		'filteringClass'
	],
	#category : #Coya
}

{ #category : #testing }
CoyaTypeFiltersClass >> filter: anObject [

	^ anObject isKindOf: filteringClass
]

{ #category : #testing }
CoyaTypeFiltersClass >> filteringClass: aClass [ 
	filteringClass := aClass
]

{ #category : #testing }
CoyaTypeFiltersClass >> isClassFilter [

	^ true
]
