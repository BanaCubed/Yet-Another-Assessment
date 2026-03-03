/**
 * Type used to refer to a 2D "array" in which all cells contents are a given type.
 * Intended to be used to reference the items stored at a coordinate on the main game board, but could be used for other purposes.
 *
 * This is not a 2D array and should not be used as such, since it allows non-integer and negative numbers.
 *
 * @see {@link getReferenceFromCoordinatePair}
 */
export type CoordinateReference<K> = Record<number, Record<number, K>>;

/**
 * Object containing a pair of coordinates in a 2D space.
 */
export interface CoordinatePair {
	/** The value of the X dimension. */
	x: number;
	/** The value of the Y dimension. */
	y: number;
}

/**
 * Function meant for easier use of coordinate references.
 *
 * @param coordRef
 * @param coordPair
 * @returns The element at the coordinates in the coordinate reference.
 * @see {@link CoordinateReference}, {@link CoordinatePair}
 * @todo Give this function a shorter name.
 */
export function getReferenceFromCoordinatePair<K>(
	coordRef: CoordinateReference<K>,
	coordPair: CoordinatePair,
): K | undefined {
	return coordRef[coordPair.x]?.[coordPair.y] ?? undefined;
}
