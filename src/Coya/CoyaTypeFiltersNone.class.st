"
I filter nothing
"
Class {
	#name : #CoyaTypeFiltersNone,
	#superclass : #CoyaTypeFilter,
	#category : #Coya
}

{ #category : #testing }
CoyaTypeFiltersNone >> filter: anObject [
	 ^ true
]

{ #category : #testing }
CoyaTypeFiltersNone >> isNoneFilter [
	^ true
]
