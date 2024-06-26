//
//  bitMasks.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 13/06/24.
//

enum bitMasks: UInt32 {
    case safe = 0b00
    case lock = 0b01
    case human = 0b10
    case ghost = 0b11
    case vent = 0b100
    case bolt = 0b101
    case human2 = 0b110
    case drawer = 0b111
    case screw = 0b1000
    case draggable = 0b1001
    case hero = 0b1010
    case wall = 0b1011
    case bed = 0b1100
    case ground = 0b1101
}

enum RotationDirection {
    case none
    case clockwise
    case counterclockwise
}

enum AnimationDirection {
    case up, down, left, right, none
}
