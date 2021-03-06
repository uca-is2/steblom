Class {
	#name : #PositionsTable,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionsTable class >> withPlayers: aSetOfPlayers [ 
	^self new initializeWithPlayers:aSetOfPlayers
]

{ #category : #testing }
PositionsTable >> arePositionsGreaterThan: finalLap [
	positions
		detect: [ :position | position isYourLapGreaterThan: finalLap ]
		ifFound: [ ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #initialization }
PositionsTable >> initializeWithPlayers: aSetOfPlayers [
	positions := OrderedCollection new.
	positions := aSetOfPlayers
		collect: [ :player | Position for: player ]
]

{ #category : #accessing }
PositionsTable >> move: player backward: numberOfTiles with: endPosition [
	positions
		detect: [ :position | position areYouFrom: player ]
		ifFound: [ :position | position backward: numberOfTiles with: endPosition ]
		ifNone: [ Error signal: 'Player not found.' ]
]

{ #category : #accessing }
PositionsTable >> move: player forward: numberOfTiles with: endPosition [
	positions
		detect: [ :position | position areYouFrom: player ]
		ifFound: [ :position | position forward: numberOfTiles with: endPosition ]
		ifNone: [ Error signal: 'Player not found.' ]
]

{ #category : #accessing }
PositionsTable >> moveEveryoneExcept: player backward: numberOfTiles with: endPosition [
	positions
		do: [ :position | 
			(position areYouFrom: player)
				ifFalse: [ position backward: numberOfTiles with: endPosition ] ]
]

{ #category : #accessing }
PositionsTable >> playerPositions [
	| auxPositions sortedPlayers |
	auxPositions := SortedCollection new.
	auxPositions sort: [ :a :b | a > b ].
	positions do: [ :position | auxPositions add: position ].
	sortedPlayers := OrderedCollection new.
	auxPositions do: [ :position | sortedPlayers add: position owner ].
	^ sortedPlayers
]

{ #category : #accessing }
PositionsTable >> positionOf: player [
	positions
		detect: [ :position | position areYouFrom: player ]
		ifFound: [ :position | ^ position whereAreYou ]
		ifNone: [ Error signal: 'Player not found.' ]
]

{ #category : #accessing }
PositionsTable >> sendAllPlayersToBeginning [
	positions do: [ :position | position goToBeginning ]
]

{ #category : #'as yet unclassified' }
PositionsTable >> whoIsWinner: finalLap [
	positions
		detect: [ :position | position isYourLapGreaterThan: finalLap ]
		ifFound: [ :position | ^ position owner ]
		ifNone: [ Error signal: 'Game has not ended yet.' ]
]
