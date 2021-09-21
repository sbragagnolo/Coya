"
I filter all messages! nothing will reach
"
Class {
	#name : #CoyaTypeFiltersAll,
	#superclass : #CoyaTypeFilter,
	#category : #Coya
}

{ #category : #testing }
CoyaTypeFiltersAll >> filter: anObject [
	 ^ false 
]

{ #category : #testing }
CoyaTypeFiltersAll >> isAllFilter [
	^ true
]
