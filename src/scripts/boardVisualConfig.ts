import { ref, type Ref } from 'vue';

export interface BoardVisualConfig {
	angle: number;
}

const boardVisualConfigBase: BoardVisualConfig = {
	angle: 30,
};

// There is definitely a better way of doing this
// but I'm not too bothered about it since it's just a startup issue
/**
 * 
 */
const boardVisualConfig: Ref<BoardVisualConfig> = ref(boardVisualConfigBase);

export default boardVisualConfig;
