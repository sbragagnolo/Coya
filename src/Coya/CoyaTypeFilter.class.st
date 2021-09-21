Class {
	#name : #CoyaTypeFilter,
	#superclass : #Object,
	#category : #Coya
}

{ #category : #accessing }
CoyaTypeFilter class >> default [
	^ CoyaTypeFiltersNone new
]

{ #category : #testing }
CoyaTypeFilter >> filter: aMessage [ 
	 self subclassResponsibility
]

{ #category : #testing }
CoyaTypeFilter >> isAllFilter [
	^ false 
]

{ #category : #testing }
CoyaTypeFilter >> isClassFilter [
	^ false 
]

{ #category : #testing }
CoyaTypeFilter >> isConditionFilter [
	^ false 
]

{ #category : #testing }
CoyaTypeFilter >> isConstraintFilter [
	^ false 
]

{ #category : #testing }
CoyaTypeFilter >> isNoneFilter [
	^ false 
]
