/**
 * Type used to refer to a 2D "array" in which all cells contents are a given type.
 *
 * This is not a 2D array and should not be used as such, since it allows non-integer and negative numbers.
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
