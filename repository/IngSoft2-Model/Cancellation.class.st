Class {
	#name : #Cancellation,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #cancelling }
Cancellation >> applyCancellation: aCancellation onPlayer: aString using: aGame [ 
	
]

{ #category : #redoing }
Cancellation >> applyRedo: redo onCard: card onPlayer: player using: game [ 
	game applyCancellationWithRedo: self onCard:card of:player.
]

{ #category : #'applying card' }
Cancellation >> applyUsing: game onCard: card [  
	card applyCancellation:self using:game.
]

{ #category : #'applying card' }
Cancellation >> applyUsing: game onCard: overload onPlayer: player [
	overload applyCancellation: self onPlayer: player using: game
]
