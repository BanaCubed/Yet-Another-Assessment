/**
 * Type used to refer to a 2D "array" in which all cells contents are a given type.
 *
 * Intended to be used to reference the items stored at a coordinate
 * on the main game board, but could be used for other purposes.
 *
 * This is not a 2D array and should not be used as such, since it allows non-integer and negative numbers.
 *
 * @see {@link getReferenceFromCoordinatePair}
 */
export type CoordinateContainer<K> = Record<number, Record<number, K>>;

/**
 * Object containing a pair of coordinates in a 2D space.
 */
export interface CoordinatePair {
	/** The value of the X dimension. */
	x: number;
	/** The value of the Y dimension. */
	y: number;
}

export const CoordinatePairZero = {
	x: 0,
	y: 0,
};

/**
 * Function meant for easier use of coordinate containers.
 *
 * @see {@link CoordinateContainer}, {@link CoordinatePair}
 * @todo Give this function a shorter name.
 */
export function coordContainerGrabber<K>(
	coordRef: CoordinateContainer<K>,
	coordPair: CoordinatePair,
): K | undefined {
	return coordRef[coordPair.x]?.[coordPair.y] ?? undefined;
}
